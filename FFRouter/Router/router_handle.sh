
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
# touch router_list.h

echo "// create by jinfeng" > router_map.json
:<< json
{
    "class": "ViewController",
    "method": "method",
    "url": "ff://xxx/xx/x"
    "platform": "ios"
    "language": "oc" #"swift" or other.
}
json

cd $PRODUCT_PATH
for file in `ls ${PRODUCT_PATH}`
do
    if [ -f ${file} ]; then
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
        cat $file | while read line
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
                url=${router_arr[1]#*"}
                echo "method=$method"
                echo "url=$url"
            fi
        done
    else
        echo "$file is a dir"
    fi
done




