#if (Test-Path "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd. 
# x-cmd巨慢，请避雷
# 定义一个函数，只有当你输入 x 时才加载 x-cmd 环境
function x {
    if (Test-Path "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1") {
        Set-ExecutionPolicy Bypass -Scope Process;
        . "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1"
    }
    # 执行完加载后再运行你本想输入的命令
    x-cmd @args 
}

function fuck {
    # 这里的路径改为你实际保存 fuck.ps1 的位置
    $scriptPath = "$HOME\.fuck\mainDEEPSEEK.ps1" 
    
    if (Test-Path $scriptPath) {
        # 加载脚本定义
        . $scriptPath
        # 将本次输入的参数传递给主函数
        Invoke-FuckAI @args
    } else {
        Write-Host "找不到脚本文件：$scriptPath" -ForegroundColor Red
    }
}




# ====== oh-my-posh 可以替代starship ======
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\montys.omp.json" | Invoke-Expression
# 导入posh-git模块
#Import-Module posh-git 

# === Pwsh7自带PSReadLine，记录命令记录和补全 ===
# 点击Ctrl + r 就进入了PSReadLine的交互式历史搜索
# 注意点击F2即可进入列表模式!!!
#输入前缀 + F8（前缀搜索）

# 优化快捷键：把 [上箭头] 和 [下箭头] 改为自动匹配前缀
# 这样你输入 "cd" 再按上箭头，就只会循环出现 cd 开头的历史，不再需要按 F8 
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# 开启 Tab 键的菜单补全模式
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# 这一行命令会直接用记事本打开你所有的历史记录文件
# notepad (Get-PSReadLineOption).HistorySavePath



# ====== zoxide AND starship ======
Invoke-Expression (& { (zoxide init powershell | Out-String) })
#Invoke-Expression (&starship init powershell)

# ====== superfile 出现黑框因为东亚字符 ======
$env:RUNEWIDTH_EASTASIAN = 0

# ====== Fastfetch配置 ======
# Fastfetch, 25完整卡片风，28/29极简风格，31新世纪福音战士
#fastfetch -c examples/28 # 启动终端就启动
function Invoke-fastfetch-pretty {
    fastfetch -c examples/31 $args
}
function Invoke-fastfetch-simple {
    fastfetch -c examples/29 $args
}
# ffm 13 cat 简单地自定义fastfetch的主题和logo
# 相当于ff -c examples/13 --file ~/.config/fastfetch/cat.txt
function ffm {
    param(
        [Parameter(Position = 0)]
        $Arg1,  # 可能是 "logo" / 数字 / Logo名
        
        [Parameter(Position = 1)]
        $Arg2   # 可能是 Logo名 / 为空
    )

    # ==================== 用户自定义默认配置 ====================
    $default_example = "20"      # 默认的主题数字
    $default_logo    = "cat"     # 默认的 logo 文件名（不含后缀）
    $logoDir = "$HOME/.config/fastfetch"
    # ============================================================

    # --- 功能 1：列出所有可选的 Logo ---
    if ($Arg1 -eq "logo") {
        Write-Host "--- 可用的自定义 Logo 列表 ---" -ForegroundColor Cyan
        Get-ChildItem "$logoDir\*.txt" | ForEach-Object { $_.BaseName } | Out-Host
        return
    }
    if ($Arg1 -eq "help" -or $Arg1 -eq "--help") {
      Write-Host "--- HELP ffm ----" -ForegroundColor Cyan
      Write-Host "第一个参数写2到32的数字意思是fastfetch的预设examples" -ForegroundColor Cyan
      Write-Host "第二个参数是你放在~/.config/fastfetch/里面的ASCII点艺术txt文件名字不用加.txt后缀" -ForegroundColor Cyan
      return
    }

    # --- 功能 2：智能参数解析 ---
    $final_config = $default_example
    $final_logo   = $default_logo

    # 情况 A：输入了两个参数 (例如: ffm 13 cat)
    if ($Arg1 -and $Arg2) {
        $final_config = $Arg1
        $final_logo   = $Arg2
    }
    # 情况 B：只输入了一个参数
    elseif ($Arg1) {
        if ($Arg1 -match '^\d+$') {
            # 如果是纯数字，说明用户只想改配置 (例如: ffm 13)
            $final_config = $Arg1
            $final_logo   = $default_logo
        } else {
            # 如果不是数字，说明用户只想改 Logo (例如: ffm cat)
            $final_config = $default_example
            $final_logo   = $Arg1
        }
    }
    # 情况 C：没输入参数 (例如: ffm)
    else {
        # 直接使用默认配置
    }

    # --- 功能 3：路径拼接与安全检查 ---
    $configPath = "examples/$final_config"
    $fullLogoPath = "$logoDir/$final_logo.txt"

    # 检查 Logo 文件是否存在
    if (-not (Test-Path $fullLogoPath)) {
        Write-Host "错误: 找不到 Logo 文件 '$final_logo.txt' 于 $logoDir" -ForegroundColor Red
        return
    }

    # --- 功能 4：执行命令 ---
    fastfetch -c $configPath --file "$fullLogoPath"
}
#Set-Alias -Name ff fastfetch.exe
Set-Alias -Name ff fastfetch.exe
Set-Alias -Name ffp -Value Invoke-fastfetch-pretty
Set-Alias -Name ffs -Value Invoke-fastfetch-simple
#ffs # 使用简单模式启动
 
# ====== eza 配置 ======
function Invoke-eza-la {
    eza -lah --icons $args
}

function Invoke-eza-ll {
    eza -lah --git --icons $args
}
function Invoke-eza-tree {
  eza --tree --icons $args
}

Set-Alias -Name ll -Value Invoke-eza-ll
Set-Alias -Name els -Value Invoke-eza-la
Set-Alias -Name et -Value Invoke-eza-tree
#可以替代ls，但是会与PowerShell的Get-ChildItem别名冲突，需要强制覆盖
# Set-Alias -Name ls -Value Invoke-eza-la -Option AllScope -Force

Set-Alias -Name which -Value where.exe
# 强制让 bash 指向 Git 的 bash
Set-Alias bash "C:\Program Files\Git\bin\bash.exe"
#Set-Alias bash "E:\DEV_PACKAGE\scoop\shims\bash.exe"
