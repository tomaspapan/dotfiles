
export RED="\[\033[0;31m\]"
export RED_BOLD="\[\033[01;31m\]"
export BLUE="\[\033[0;34m\]"
export CYAN='\[\e[0;36m\]'
export PURPLE='\[\e[0;35m\]'
export GREEN="\[\033[0;32m\]"
export YELLOW="\[\033[0;33m\]"
export BLACK="\[\033[0;38m\]"
export NO_COLOUR="\[\033[0m\]"

export C_RESET='\[\e[0m\]'

function __encrypt_file {
    IN="$1"
    OUT="$2"
    gpg2 -ca --cipher-algo aes256 -o "$OUT" "$IN"
}

function __decrypt_file {
    IN="$1"
    OUT="$2"
    gpg2 -da -o "$OUT" "$IN"
}

function __backup {
    case "$1" in 
        "backup")
            URL='/home/morpheus/backup/'
            ;;
        "web")
            URL='/home/pub/Papan.sk/'
            ;;
        *)
            echo "Unknown Error. Ask Microsoft"
    esac
    case "$2" in
        "pull")
            scp -P 7777 -r "morpheus@papan.sk:$URL/\"$3\"" .
            ;;

        "push")
            scp -P 7777 -r "$3" morpheus@papan.sk:$URL 
            if [ "$1" == "web" ] 
            then 
                echo "http://papan.sk/share/$3" 
            fi
            ;;
        "list")
            ssh -p 7777 morpheus@papan.sk "cd $URL && du -ms *" 
            if [ $? -ne 0 ]; then
                echo "There is nothing!"
            fi
            ;;
        "rm")
            ssh -p 7777 morpheus@papan.sk "cd $URL && rm -rf \"$3\""
            ;;
        *)
            echo "Wrong option"
            echo "commands"
            echo "pull <remote target> <destination>"
            echo "push <target> <remote destination>"
            echo "list"
            echo "rm <remote target>"
            ;;
    esac
}

function flac_to_alac()
{
    mkdir alac;
    for f in *.flac
    do
            ffmpeg -i "$f" -acodec alac "alac/${f%.flac}.m4a"
    done
}

function flac_to_mp3()
{
    mkdir mp3;
    for f in *.flac
    do
            ffmpeg -i "$f" -ab 196k -ac 2 -ar 48000 "mp3/${f%.flac}.mp3"
    done
}

function flac_to_320_mp3()
{
    mkdir mp3_320;
    for f in *.flac
    do
            ffmpeg -i "$f" -ab 320k -ac 2 "mp3_320/${f%.flac}.mp3"
    done
}

function genpasswd() 
{
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

function genpasswds() 
{
    local l=$1
    local t=$2
    [ "$l" == "" ] && l=20
    [ "$t" == "" ] && t=10
    for i in `seq $t` 
    do
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
    done
}

function timer()
{
    notify="/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"
    sleep $1 && $notify -title 'Terminal Notifier' -message $2
}

function kernel-compile()
{
    cd /kernel/linux
    mv .config ../
    make mrproper
    mv ../.config .
    make oldconfig
    make menuconfig
    make -j9

    echo -e "\nKernel is compiled. Please install it (and modules too)"
    echo -e "\n# make install"
    echo -e "\n# make modules_install"
}

function notify()
{
    TIME=$1
    MSG=$2

    sleep $TIME

    /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message $MSG -title 'terminal'
}

function resize()
{
    RESIZE=$1
    mkdir resize
    for pic in *
    do
            convert -resize $RESIZE "$pic" "resize/$pic"
    done
}

function brewremovewithdep()
{
    keg=$1
    brew rm $keg
    brew rm $(join <(brew leaves) <(brew deps $keg))
}

function __docker-shell() {
    docker exec -ti $1 bash
}

function cp1250toUtf8() {
    iconv -f WINDOWS-1250 -t UTF-8 < "$1" > tmpfile
}

function __scan_network() {
    nmap -sP $1 2> /dev/null | grep report | awk '{print $5}'
}
