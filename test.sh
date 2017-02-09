#!/usr/bin/env bash

str='11111'

# 默认是执行ssh命令
    # 正则匹配下
    if [[ "$str" =~ .*[@].* ]]; then
        echo '匹配到了'
    fi
