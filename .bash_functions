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

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
        if [[ -n "$@" ]]; then
            du $arg -- "$@";
        else
            du $arg .[^.]* *;
    fi;
}

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}…";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version");
        echo "Common Name:";
        echo ""; # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
        echo ""; # newline
        echo "Subject Alternative Name(s):";
        echo ""; # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
        return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
    if [ $# -eq 0 ]; then
        vim .;
    else
        vim "$@";
    fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

if [ $OS == "Darwin" ]
then

  # Change working directory to the top-most Finder window location
  function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
  }

  # `o` with no arguments opens the current directory, otherwise opens the given
  # location
  function o() {
    if [ $# -eq 0 ]; then
        open .;
    else
        open "$@";
    fi;
  }
 fi 
