#!/bin/bash

# 提示用户输入文件内容
echo "请输入文件内容（每行一条节点，输入完成后按回车键开始统计）:"
input_content=""
while IFS= read -r line; do
    if [[ -z "$line" ]]; then
        break
    fi
    input_content+="$line"$'\n'
done

# 统计输入的总数量
total_lines=$(echo "$input_content" | wc -l)
echo "输入的总数量: $total_lines"

# 定义输出文件
output_file="sub.txt"

# 初始化计数器
current_line=0
kept_lines=0

# 处理输入内容，剔除包含 vless 的行，并进行 base64 编码
echo "$input_content" | while IFS= read -r line; do
    current_line=$((current_line + 1))
    # 显示进度条
    printf "\r处理进度: %d/%d" "$current_line" "$total_lines"
    if [[ "$line" != *"vless"* ]]; then
        echo "$line" | base64 >> "$output_file"
        kept_lines=$((kept_lines + 1))
    fi
done

# 输出处理结果
echo -e "\n处理完成，结果已保存到 $output_file"
echo "输入的总数量: $total_lines"
echo "剔除后的数量: $kept_lines"
