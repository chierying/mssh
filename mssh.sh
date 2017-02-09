#!/usr/bin/env bash

# 默认配置文件放在 ~/.mssh中
configDir=~/.mssh
configFile=${configDir}/config

# 检查配置文件目录是否存在,不在就创建.
if [ ! -d "$configDir" ]; then
    mkdir ${configDir}
fi

# 添加账号
if [ $1 == 'add' ]; then
    host=$2
    echo '添加账号'$host
    echo $2 >> ${configFile}
    ssh-copy-id ${host}
    exit 0
fi

# 账号列表
if [ $1 == 'list' ]; then
    count=0
    while read line; do
        count=$[$count+1]
        echo $count'	'${line}
    done < $configFile
    exit 0
fi

# 删除账号
if [ $1 == 'delete' ]; then
    sed -i "!$2!d" $configFile
    exit 0
fi

# 默认是执行ssh命令
if [ -n "$1" ]; then
    if [[ "$1" =~ .*[@].* ]]; then
        # 输入的是账号
        ssh $1
    else
        # 输入序号
        hostName=$(sed -n "${1}p" ${configFile})
        ssh $hostName
    fi
    exit 0
fi


