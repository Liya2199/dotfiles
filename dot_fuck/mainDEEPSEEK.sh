# --- fuckit.sh 核心逻辑开始 ---

# --- 颜色定义 ---
# 只有在没定义过颜色的情况下才定义 (临时模式用)
if [ -z "${C_RESET:-}" ]; then
    readonly C_RESET='\033[0m'
    readonly C_RED_BOLD='\033[1;31m'
    readonly C_RED='\033[0;31m'
    readonly C_GREEN='\033[0;32m'
    readonly C_YELLOW='\033[0;33m'
    readonly C_CYAN='\033[0;36m'
    readonly C_BOLD='\033[1m'

    # --- 操! ---
    readonly FUCK="${C_RED_BOLD}操!${C_RESET}"
    readonly FCKN="${C_RED}你他妈${C_RESET}"

    # --- 配置 ---
    if [ -z "${HOME:-}" ]; then
        # 这部分是给临时运行模式用的，它不安装任何东西
        # 但我们还是需要定义这些变量，免得脚本报错
        # 安装程序部分会进行真正的检查
        readonly INSTALL_DIR="/tmp/.fuck"
        readonly MAIN_SH="/tmp/.fuck/main.sh"
    else
        readonly INSTALL_DIR="$HOME/.fuck"
        readonly MAIN_SH="$INSTALL_DIR/main.sh"
    fi
fi

# 找用户 shell 配置文件的辅助函数
_installer_detect_profile() {
    if [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        # 兼容 sh, ksh 等
        echo "$HOME/.profile"
    elif [ -f "$HOME/.zshrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.bashrc"
    else
        echo "unknown_profile"
    fi
}

# 检测包管理器
_fuck_detect_pkg_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo "unknown"
    fi
}

# 把系统信息整成一个字符串
_fuck_collect_sysinfo_string() {
    local pkg_manager
    pkg_manager=$(_fuck_detect_pkg_manager)
    # 服务端的 LLM 得能看懂这个字符串
    echo "OS: $(uname -s), Arch: $(uname -m), Shell: ${SHELL:-unknown}, PkgMgr: $pkg_manager, CWD: $(pwd)"
}

# JSON 转义，免得出问题
_fuck_json_escape() {
    # 就转义那几个特殊字符
    printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g'
}

# 卸载脚本
_uninstall_script() {
    echo -e "${C_RED_BOLD}好好好！${C_RESET}${C_YELLOW}怎么着，要卸磨杀驴啊？行啊你个老六，我真谢谢你了。${C_RESET}"

    # 找配置文件
    local profile_file
    profile_file=$(_installer_detect_profile)
    local source_line="source $MAIN_SH"

    if [ "$profile_file" != "unknown_profile" ] && [ -f "$profile_file" ]; then
        if grep -qF "$source_line" "$profile_file"; then
            # 用 sed 把那几行删了，顺便备个份
            sed -i.bak "\|$source_line|d" "$profile_file"
            sed -i.bak "\|# Added by fuckit.sh installer|d" "$profile_file"
        fi
    else
        echo -e "${C_YELLOW}找不到 shell 配置文件，你他妈自己看着办吧。${C_RESET}"
    fi

    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
    fi

    sleep 3
    echo -e "${C_GREEN}行，我滚了，以后别他妈哭着求我回来。${C_CYAN}赶紧重启你那破终端吧，我看见你就烦。${C_RESET}"
    sleep 3
    echo -e "${C_YELLOW}临别之际，献上一首小诗，祝您前程似锦：${C_RESET}"
    sleep 2
    echo -e "\n${C_RED}《诗经·彼阳》${C_RESET}"
    sleep 2
    echo -e "${C_YELLOW}彼阳若至，初升东曦。${C_RESET}"
    sleep 2
    echo -e "${C_YELLOW}绯雾飒蔽，似幕绡绸。${C_RESET}"
    sleep 3
    echo -e "${C_YELLOW}彼阳篝碧，雾霂涧滁。${C_RESET}"
    sleep 4
    echo -e "${C_YELLOW}赤石冬溪，似玛瑙潭。${C_RESET}"
    sleep 4
    echo -e "${C_YELLOW}彼阳晚意，暖梦似乐。${C_RESET}"
    sleep 3
    echo -e "${C_YELLOW}寐游浮沐，若雉飞舞。${C_RESET}"
}

# --- 修改：使用 DeepSeek API ---
# 跟 API 通信的主函数
# 参数就是要执行的命令
_fuck_execute_prompt() {
    # 如果用户只输入 "fuck uninstall"
    if [ "$1" = "uninstall" ] && [ "$#" -eq 1 ]; then
        _uninstall_script
        return 0
    fi

    if ! command -v curl &> /dev/null; then
        echo -e "$FUCK ${C_RED}'fuck' 命令要用 'curl'，你他妈连这都没装？赶紧去装！${C_RESET}" >&2
        return 1
    fi

    # 检查 DeepSeek API 密钥
    if [ -z "${DEEPSEEK_API_KEY:-}" ]; then
        echo -e "$FUCK ${C_RED}环境变量 DEEPSEEK_API_KEY 没设置！去 https://platform.deepseek.com/ 搞个 key 来。${C_RESET}" >&2
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        echo -e "$FUCK ${C_RED}你他妈哑巴了？到底要我干啥？${C_RESET}" >&2
        return 1
    fi

    local prompt="$*"
    local sysinfo_string
    sysinfo_string=$(_fuck_collect_sysinfo_string)

    # 构造 system 消息：强制要求只输出一条 shell 命令
    local system_msg="你是一个专业的 shell 命令生成器。根据用户的描述和系统信息，输出一条可以直接在终端执行的 shell 命令。\
不要输出任何解释、不要输出 markdown 代码块标记、不要输出多余的空格或换行。只输出命令本身。\
如果用户要求不明确，请给出最合理的常见命令。"

    local user_msg="系统信息: ${sysinfo_string}\n用户要求: ${prompt}"

    # 转义 JSON 字符串
    local escaped_system
    local escaped_user
    escaped_system=$(_fuck_json_escape "$system_msg")
    escaped_user=$(_fuck_json_escape "$user_msg")

    # 构建请求 payload
    local model_name="deepseek-v4-flash"   # 如官方名称不同，请修改此处
    local payload
    payload=$(printf '{
        "model": "%s",
        "messages": [
            {"role": "system", "content": "%s"},
            {"role": "user", "content": "%s"}
        ],
        "temperature": 0,
        "max_tokens": 256
    }' "$model_name" "$escaped_system" "$escaped_user")

    local api_url="https://api.deepseek.com/v1/chat/completions"

    # 发起请求
    local response
    response=$(curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
        -d "$payload")

    # 检查 curl 是否出错
    if [ $? -ne 0 ] || [ -z "$response" ]; then
        echo -e "$FUCK ${C_RED}请求 DeepSeek API 失败，网络炸了还是服务器挂了？${C_RESET}" >&2
        return 1
    fi

    # 解析 JSON 响应，提取命令
    # 注意：这里用 grep + sed 简单提取，若响应中包含 "choices" 和 "content"
    local command
    command=$(echo "$response" | grep -o '"content":"[^"]*"' | head -1 | sed 's/"content":"//;s/"$//' | sed 's/\\"/"/g')
    
    # 如果上面的方法失败（比如模型返回了转义字符），尝试用更宽松的方式
    if [ -z "$command" ]; then
        # 可能返回的 content 里有换行，用 awk 提取第一个 choices[0].message.content
        command=$(echo "$response" | sed -n 's/.*"content":"\([^"]*\)".*/\1/p' | head -1)
    fi

    if [ -z "$command" ]; then
        echo -e "$FUCK ${C_RED}AI 返回了一坨屎，解析不出命令。原始响应：${C_RESET}" >&2
        echo "$response" | head -c 500 >&2
        echo >&2
        return 1
    fi

    # --- 用户确认 ---
    echo -e "${C_YELLOW}--- AI 建议执行以下命令 ---${C_RESET}"
    echo -e "${C_CYAN}$command${C_RESET}"
    echo -e "${C_YELLOW}--------------------------------${C_RESET}"

    # 二次确认
    printf "${C_BOLD}${C_YELLOW}看完了没？干不干？[y/N]${C_RESET} "
    local confirmation
    read -r confirmation < /dev/tty

    if [[ "$confirmation" =~ ^[yY]([eE][sS])?$ ]]; then
        echo -e "${C_RED_BOLD}我操！${C_RESET}${C_CYAN} 还等啥呢，干他妈的！${C_RESET}" >&2
        # 执行服务器返回的命令并检查退出码
        if eval "$command"; then
            echo -e "${C_GREEN}完事了，应该没啥问题，有问题也是你的问题。${C_RESET}"
        else
            local exit_code=$?
            echo -e "${C_RED_BOLD}操！${C_RED}这破命令执行失败了，退出码是 $exit_code。别他妈看我，自己想办法。${C_RESET}" >&2
        fi
    else
        echo -e "${C_RED}怂逼！不干就滚，别浪费老子时间。${C_RESET}" >&2
    fi
}

# 定义别名
alias fuck='_fuck_execute_prompt'

# --- 核心逻辑结束 ---