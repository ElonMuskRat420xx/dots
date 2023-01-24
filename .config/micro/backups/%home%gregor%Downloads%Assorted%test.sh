function imageext () 
{ 
    if ! ((${#imageextensionlist[@]})); then
        declare -ga imageextensionlist=($(grep / /etc/mime.types|grep 'image/'|xargs printf '%s\n'|grep -v /));
    fi;
    [[ " ${imageextensionlist[@]} " == *" ${1,,} "* ]]
}
function videoext () 
{ 
    if ! ((${#videoextensionlist[@]})); then
        declare -ga videoextensionlist=($(grep / /etc/mime.types|grep 'video/'|xargs printf '%s\n'|grep -v /));
    fi;
    [[ " ${videoextensionlist[@]} " == *" ${1,,} "* ]]
}
function imagesize () # you may need to install imagemagick
{ 
    local re=$(identify -format %wx%h "${1}");
    printf "${re%%x*}x${re##*x}"
}

cd /parrent/dir/where/your/pictures;
mkdir tmp;
mv * tmp/;
mkdir videos pictures other;


find "${PWD}/tmp" -type f | while read thefile;do
    if imageext "${thefile##*.}";then
        imgsize="$(imagesize "${thefile}")";
        [[ ! -d "${imgsize:-none}" ]] && mkdir -p "${imgsize:-none}"
        mv "${thefile}" pictures/${imgsize:-none}/;
    elif videoext "${thefile##*.}";then
        mv "${thefile}" videos/;
    else
        mv "${thefile}" other/
    fi
done