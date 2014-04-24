
# functions
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

function prompt {
    if [[ ${EUID} == 0 ]] ; then
        export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
    fi
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
