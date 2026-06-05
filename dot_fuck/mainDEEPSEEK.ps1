# --- fuck.ps1 - PowerShell 终极版 ---
#gemini3.5flash生成
# 颜色与表情定义
$C_RED_BOLD = { param($m) Write-Host $m -ForegroundColor Red -NoNewline; Write-Host "" }
$FUCK_TEXT = "操!"
$FCKN_TEXT = "你他妈"

# 获取系统信息
function Get-FuckSysInfo {
    $os = [System.Environment]::OSVersion.VersionString
    $arch = $env:PROCESSOR_ARCHITECTURE
    $psVer = $PSVersionTable.PSVersion.ToString()
    $cwd = Get-Location
    $pkgMgr = "unknown"
    if (Get-Command winget -ErrorAction SilentlyContinue) { $pkgMgr = "winget" }
    elseif (Get-Command choco -ErrorAction SilentlyContinue) { $pkgMgr = "choco" }
    
    return "OS: $os, Arch: $arch, PS: $psVer, PkgMgr: $pkgMgr, CWD: $cwd"
}

# 卸载逻辑
function Uninstall-Fuck {
    Write-Host "好好好！" -ForegroundColor Red -NoNewline
    Write-Host "怎么着，要卸磨杀驴啊？行啊你个老六，我真谢谢你了。" -ForegroundColor Yellow
    
    $profilePath = $PROFILE
    if (Test-Path $profilePath) {
        $content = Get-Content $profilePath
        # 移除加载行
        $newContent = $content | Where-Object { $_ -notmatch "fuck.ps1" -and $_ -notmatch "function fuck" }
        $newContent | Set-Content $profilePath
    }
    
    Write-Host "当前会话及 Profile 中的 'fuck' 已移除。" -ForegroundColor Green
    Write-Host "临别赠诗：`n" -ForegroundColor Yellow
    $poem = @(
        "《诗经·彼阳》", "彼阳若至，初升东曦。", "绯雾飒蔽，似幕绡绸。",
        "彼阳篝碧，雾霂涧滁。", "赤石冬溪，似玛瑙潭。", "彼阳晚意，暖梦似乐。", "寐游浮沐，若雉飞舞。"
    )
    foreach ($line in $poem) {
        Write-Host $line -ForegroundColor Yellow
        Start-Sleep -Milliseconds 800
    }
}

# 执行主逻辑
function Invoke-FuckAI {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$ArgsArray
    )

    $description = $ArgsArray -join " "

    if ($description -eq "uninstall") {
        Uninstall-Fuck
        return
    }

    if (-not $description) {
        Write-Host "$FUCK_TEXT " -ForegroundColor Red -NoNewline
        Write-Host "你他妈哑巴了？到底要我干啥？" -ForegroundColor Red
        return
    }

    $apiKey = $env:DEEPSEEK_API_KEY
    if (-not $apiKey) {
        Write-Host "$FUCK_TEXT " -ForegroundColor Red -NoNewline
        Write-Host "环境变量 DEEPSEEK_API_KEY 没设置！去填一下。" -ForegroundColor Red
        return
    }

    $sysInfo = Get-FuckSysInfo
    $systemMsg = "你是一个专业的 shell 命令生成器。根据用户的描述和系统信息，输出一条可以直接在 PowerShell 执行的命令。不要输出任何解释、不要输出 markdown 标记、不要多余空格。只输出命令本身。"
    $userMsg = "系统信息: $sysInfo`n用户要求: $description"

    # 构造 JSON (PowerShell 会自动处理转义)
    $body = @{
        model = "deepseek-v4-flash"
        messages = @(
            @{ role = "system"; content = $systemMsg },
            @{ role = "user"; content = $userMsg }
        )
        temperature = 0
        max_tokens = 512
    } | ConvertTo-Json -Compress

    try {
        $response = Invoke-RestMethod -Uri "https://api.deepseek.com/v1/chat/completions" `
            -Method Post `
            -Headers @{ "Authorization" = "Bearer $apiKey"; "Content-Type" = "application/json" } `
            -Body ([System.Text.Encoding]::UTF8.GetBytes($body)) # 确保 UTF8 编码
        
        $command = $response.choices[0].message.content.Trim()
        
        Write-Host "--- AI 建议执行以下命令 ---" -ForegroundColor Yellow
        Write-Host $command -ForegroundColor Cyan
        Write-Host "--------------------------------" -ForegroundColor Yellow

        $confirm = Read-Host "看完了没？干不干？[y/N]"
        if ($confirm -eq "y") {
            Write-Host "我操！" -ForegroundColor Red -NoNewline
            Write-Host " 还等啥呢，干他妈的！" -ForegroundColor Cyan
            Invoke-Expression $command
            Write-Host "`n完事了，应该没啥问题，有问题也是你的问题。" -ForegroundColor Green
        } else {
            Write-Host "怂逼！不干就滚，别浪费老子时间。" -ForegroundColor Red
        }
    } catch {
        Write-Host "API 炸了：$($_.Exception.Message)" -ForegroundColor Red
    }
}