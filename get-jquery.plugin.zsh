export ZSH_PLUGIN_JQUERY_SOURCES=""

get-jquery() {
    zparseopts -D \
        v:=jquery_version -jquery-version:=jquery_version \
        u=uncompressed -uncompressed=uncompressed \
        -help=help -h=help h=help

    if [[ -n $help ]]; then
        cat <<EOF
Usage: get-jquery [options...] [target directory or file] 

Options:
  -v, --jquery-version  set jQuery version
  -u, --uncompressed    get uncompressed (development) version
  -h, --h, --help       show this output

Examples:
  get-jquery -u -v1.0.1 js/jquery-latest.js
  get-jquery . # will get the latest jQuery release and save into the current directory
EOF
        return 0
      fi

    if [[ -z $ZSH_PLUGIN_JQUERY_SOURCES ]]; then
        _get_jquery_sources
    fi

    if [[ -z $jquery_version ]]; then
        url=http://code.jquery.com/jquery.js
    else
        url=$(echo $ZSH_PLUGIN_JQUERY_SOURCES | sed -rne "s/^$jquery_version[2] (.*)$/\1/p")
    fi
    if [[ -z $uncompressed ]]; then
        url=${url/%.js/.min.js}
    fi

    if [[ ! -z $1 ]]; then
        if [[ -d $1 ]]; then
            curl -sf $url > $1/`basename $url`
            echo "Successfully saved to $1/`basename $url`"
        else
            curl -sf $url > $1
            echo "Successfully saved to $1"
        fi
    else 
        curl -sf $url
    fi
}

_get_jquery_sources() {
    ZSH_PLUGIN_JQUERY_SOURCES=$(curl -sf http://code.jquery.com/jquery/ | \
        sed -ne 's/^.*jQuery Core[[:space:]]\+\([[:digit:]][-.[:alnum:]]*\)[[:space:]].*\?\(\/jquery.*\.js\).*uncompressed.*/\1 http:\/\/code.jquery.com\2/p')
}

_get-jquery() {
    if [[ -z $ZSH_PLUGIN_JQUERY_SOURCES ]]; then
        _get_jquery_sources
    fi

    _arguments \
        '(-h --h --help --jquery-version)'{--jquery-version,-v}"+[jQuery version]:jQuery version:(`echo $ZSH_PLUGIN_JQUERY_SOURCES | cut -d' ' -f 1`)" \
        '(- 1 *)'{--help,--h,-h}'[show help message]' \
        '(-h --h --help -u --uncompressed)'{--uncompressed,-u}'[get uncompessed version]' \
        '(-)1:target directory:_directories' \
        && return 0
}

compdef _get-jquery get-jquery
