
echo '--- Start router script ---'

ROUTER_DIR='RouterBox'

if [ ! -d $ROUTER_DIR ]; then
    echo 'create dir RouterBox'
    mkdir $ROUTER_DIR
fi

#${SRCROOT} ${PROJECT_NAME}

# 列出工程目录下的所有文件和文件夹
PRODUCT_PATH=$PWD/${PROJECT_NAME}
echo "project path: $PRODUCT_PATH"

cd $ROUTER_DIR
echo "router path: $PWD"

# 创建映射表
touch router_map.json

# 创建路由字符串对应变量清单
touch router_list.h

echo "// create by jinfeng" > router_map.json
:<< json
{
    "class": "ViewController",
    "method": "method",
    "url": "ff://xxx/xx/x"
    "platform": "ios"
    "language": "oc" #"swift"
}
json


echo "// create by jinfeng" > router_list.h

cd $PRODUCT_PATH
for file in `ls ${PRODUCT_PATH}`
do
    if [ -f ${file} ]; then
        echo "$file is a file"
        
        
        
        cat $file | while read line
        do
            if [ ${#line} == 0 ]; then
                continue;
            fi
            #echo "-line: $line"
            if [[ ${line} == 'Register_router('* ]]; then
                echo "-find router:\n\t $line"
            fi
        done
    else
        echo "$file is a dir"
    fi
done




