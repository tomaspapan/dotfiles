#!/bin/bash

URL="$1"

#URL="http://wallgig.net/?aspect_ratios%5B%5D=1_77&aspect_ratios%5B%5D=1_60&exclude_tags%5B%5D=anime+girls&height=1600&order=popular&per_page=60&purity%5B%5D=sfw&purity%5B%5D=sketchy&resolution_exactness=at_least&width=2560"

wget -O index.html $URL

IMG_LIST=`cat index.html | grep data-src | sed -e 's/.*data-src\=\"//g' -e 's/\".*//g' -e 's/_250x188.*/jpg/g'`

for link in $IMG_LIST
do
    wget -nc $link > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo $link + ".... done"
    else
        echo $link + ".... false"
    fi
done

rm index.html


