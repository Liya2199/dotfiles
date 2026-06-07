# 🛠️ Ultimate Dotfiles

> 优雅、模块化且跨平台的个人开发环境配置，基于 `chezmoi` 进行管理。

本仓库采用 Conventional Commits 规范进行版本控制。通过 `chezmoi`，所有配置文件在保持本地原有目录结构的同时，实现了云端无缝备份与跨设备安全同步。

---

## 🚀 核心组件清单

| 组件 | 描述 | 主要特性 / 框架 |
| :--- | :--- | :--- |
| **Neovim** | 核心编辑器 | 基于 Lua 配置，支持 LSP、🌲Treesitter、🧠AI 辅助 |
| **WezTerm** | 终端仿真器 | 跨平台 GPU 加速，多标签页与分屏管理 |
| **PowerShell 7** | 核心 Shell | 生产力工具，支持跨平台脚本与别名强化 |

---

## 📦 新设备一键部署 (Quick Start)

当你来到一台全新的电脑前，无需手动安装和复制文件，只需执行以下命令即可实现“一键拎包入住”：

### 1. 安装 
确保你的系统已经安装了 Git 和 chezmoi：
* **Windows (Winget):** `winget install twpayne.chezmoi`
* **macOS/Linux (Homebrew):** `brew install chezmoi`

### 2. 初始化并应用配置
使用 `chezmoi` 配合你的 GitHub **SSH 链接**直接初始化（它会自动拉取并应用配置）：

```bash
# 初始化并立刻应用配置 (-a 表示 apply)
chezmoi init --apply git@github.com:<你的GitHub用户名>/<你的仓库名>.git
# 在这里即是:
chezmoi init --apply git@github.com:Liya2199/dotfiles.git
# 或者
chezmoi init --apply https://github.com/Liya2199/dotfiles.git
