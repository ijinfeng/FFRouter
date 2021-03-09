
echo '--- Start router script ---'

ROUTER_DIR='RouterBox'

if [ ! -d $ROUTER_DIR ]; then
    echo 'create dir RouterBox'
    mkdir $ROUTER_DIR
fi

#${SRCROOT} ${PROJECT_NAME}

echo "current path:\n\t $PWD"

# 列出工程目录下的所有文件和文件夹
PRODUCT_PATH=$PWD/${PROJECT_NAME}
echo "project path:\n\t $PRODUCT_PATH"

echo "router map path:\n\t $PWD/${ROUTER_DIR}/router_map.json"

# 创建映射表
echo "create router_map.json if No this file exit"
cd ${ROUTER_DIR}
touch router_map.txt

echo "// create by jinfeng\n\n" > router_map.json
:<< json
{
    "class": "ViewController",
    "method": "method",
    "url": "ff://xxx/xx/x"
    "platform": "ios"
    "language": "oc" #"swift" or other.
}
json



ROUTER_MAP_STRING='['

#cd $PRODUCT_PATH
read_path=$PRODUCT_PATH

function read_file_router() {
read_path=$read_path$1

echo "read path:\n\t$read_path"

for file in `ls $read_path`
do
    file_path=$read_path'/'$file
    if [ -f ${file_path} ]; then
        echo "$file is a file"
        
        # 先确定是oc还是swift
        # ${string##substring} | 从变量$string的开头，删除最长匹配$substring的子串
        file_extension=${file##*.}
        # ${string%substring} | 从变量$string的结尾，删除最短匹配$substring的子串
        file_name=${file%.*}
        
        # oc的路由通过识别文件后缀.h，swift通过识别文件后缀.swift
        language=''
        cls_name=''
        platform='ios'
        
        if [ $file_extension == 'swift' ]; then
            language='swift'
        elif [ $file_extension == 'h' ]; then
            language='oc'
        fi
        
        if [ ${#language} -eq 0 ]; then
            continue
        fi
        
        # 读取文件中的每一行
        while read line
        do
            if [ ${#line} == 0 ]; then
                continue;
            fi
#            echo "-line: $line"
            
            # 识别文件中包含的类
            # oc通过读取 ‘@interface’ ～ ‘:’之间的就是class
            # swift
            if [[ $language == 'oc' && ${line} == '@interface'* ]]; then
                cls_name=${line%%:*}
                # 这里是分类
                if [[ $cls_name == $line ]]; then
                    cls_name=${line%%(*}
                fi
                cls_name=${cls_name/#@interface/}
                cls_name=${cls_name// /}
                echo "class2=$cls_name, num=${#cls_name}"
            fi
            
            if [[ ${line} == 'Register_router('* ]]; then
                echo "-find router:\n\t $line"
                # Register_router(open, @"ff://home/second")
                router_no_wspace=${line// /}
                router_arr=(${router_no_wspace//,/ })
                method=${router_arr[0]##*(}
                url=${router_arr[1]#*\"}
                url=${url%\"*}
                echo "method=$method"
                echo "url=$url"
                
                # 找到一个就写入一个
                dic="{\"class\":\"$cls_name\",\"method\":\"$method\",\"url\":\"$url\",\"platform\":\"ios\",\"language\":\"$language\"}"
                if [ $ROUTER_MAP_STRING == '[' ]; then
                    ROUTER_MAP_STRING=$ROUTER_MAP_STRING$dic
                else
                    ROUTER_MAP_STRING=$ROUTER_MAP_STRING','$dic
                fi
            fi
        done < $file_path
    elif [ -d ${file_path} ]; then
        echo "$file is a dir"
        read_file_router '/'$file
        # 读取完文件夹下之后需要复原到初始路径
        read_path=$PRODUCT_PATH
    else
        echo "$file is a other file"
    fi
done
}

read_file_router

ROUTER_MAP_STRING=$ROUTER_MAP_STRING']'

echo '--- get all router map ---'

echo $ROUTER_MAP_STRING

echo "router path:\n\t $PWD"

echo $ROUTER_MAP_STRING >> router_map.txt
