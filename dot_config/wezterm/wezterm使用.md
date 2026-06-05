这是一款配置详细且个性化的 **WezTerm** 快捷键和鼠标操作设置。由于您禁用了默认绑定，所以所有的快捷操作都依赖于这份配置。

以下为您详细讲解这份配置中的主要快捷操作：

---

## 💻 基础修饰键定义

您的配置根据操作系统定义了主要的修饰键：

| **操作系统**          | **mod.SUPER (主要修饰键)**                 | **mod.SUPER_REV (主要修饰键 + CTRL)** |
| ----------------- | ------------------------------------- | -------------------------------- |
| **macOS**         | **$\text{SUPER}$** ($\text{CMD}$ 或 ⌘) | **$\text{SUPER}$**               |
| **Windows/Linux** | **$\text{ALT}$** ($\text{ALT}$ 或 ⌥)   | **$\text{ALT}$**                 |

**注意**：在接下来的说明中，我将使用 $\text{SUPER}$ 和 $\text{SUPER\_REV}$ 来表示这些组合，请根据您的操作系统（Windows/Linux 默认为 $\text{ALT}$ 和 $\text{ALT} + \text{CTRL}$）进行操作。

---

## ⌨️ 键盘快捷键 (keys)

### 杂项/实用功能

| **快捷键**                   | **动作**                   | **功能说明**                                         |
| ------------------------- | ------------------------ | ------------------------------------------------ |
| $\text{F1}$               | `ActivateCopyMode`       | **激活复制模式**，允许用键盘选择文本。                            |
| $\text{F2}$               | `ActivateCommandPalette` | **激活命令面板**，搜索并执行 WezTerm 命令。                     |
| $\text{F3}$               | `ShowLauncher`           | **显示启动器**，快速启动新的 $\text{Tab}$ 或 $\text{Window}$。 |
| $\text{F4}$               | `ShowTabNavigator`       | **显示 $\text{Tab}$ 导航器**，快速切换 $\text{Tab}$。       |
| $\text{F11}$              | `ToggleFullScreen`       | **切换全屏模式**。                                      |
| $\text{F12}$              | `ShowDebugOverlay`       | 显示调试叠加层。                                         |
| $\text{SUPER} + \text{f}$ | `Search`                 | **启动搜索**（在终端输出中）。                                |

---

### 📋 复制与粘贴

| **快捷键**                                 | **动作**                   | **功能说明**           |
| --------------------------------------- | ------------------------ | ------------------ |
| $\text{CTRL} + \text{SHIFT} + \text{c}$ | `CopyTo("Clipboard")`    | **复制**选中的内容到系统剪贴板。 |
| $\text{CTRL} + \text{SHIFT} + \text{v}$ | `PasteFrom("Clipboard")` | **粘贴**系统剪贴板的内容到终端。 |

---

### 🏷️ $\text{Tab}$s（标签页）操作

#### $\text{Tab}$s：创建与关闭

| **快捷键**                                 | **动作**                                    | **功能说明**                                     |
| --------------------------------------- | ----------------------------------------- | -------------------------------------------- |
| $\text{SUPER} + \text{t}$               | `SpawnTab("DefaultDomain")`               | **创建新的 $\text{Tab}$**（在默认域）。                 |
| $\text{SUPER\_REV} + \text{t}$          | `SpawnTab({ DomainName = "WSL:Ubuntu" })` | **创建新的 $\text{Tab}$**，并连接到 **WSL:Ubuntu** 域。 |
| $\text{SUPER\_REV} + \text{w}$          | `CloseCurrentTab({ confirm = false })`    | **关闭当前 $\text{Tab}$**（不弹出确认）。                |
| $\text{CTRL} + \text{SHIFT} + \text{R}$ | `PromptInputLine`                         | **重命名当前 $\text{Tab}$**。                      |

#### $\text{Tab}$s：导航与移动

| **快捷键**                        | **动作**                    | **功能说明**                   |
| ------------------------------ | ------------------------- | -------------------------- |
| $\text{SUPER} + \text{[}$      | `ActivateTabRelative(-1)` | **切换到上一个 $\text{Tab}$**。   |
| $\text{SUPER} + \text{]}$      | `ActivateTabRelative(1)`  | **切换到下一个 $\text{Tab}$**。   |
| $\text{SUPER\_REV} + \text{[}$ | `MoveTabRelative(-1)`     | **将当前 $\text{Tab}$ 向左移动**。 |
| $\text{SUPER\_REV} + \text{]}$ | `MoveTabRelative(1)`      | **将当前 $\text{Tab}$ 向右移动**。 |

---

### 🖼️ $\text{Window}$（窗口）操作

| **快捷键**                   | **动作**        | **功能说明**                  |
| ------------------------- | ------------- | ------------------------- |
| $\text{SUPER} + \text{n}$ | `SpawnWindow` | **创建新的 $\text{Window}$**。 |

---

### ⚙️ $\text{Panes}$（分屏）操作

#### $\text{Panes}$：分屏与关闭

| **快捷键**                                     | **动作**                                  | **功能说明**                 |
| ------------------------------------------- | --------------------------------------- | ------------------------ |
| $\text{SUPER\_REV} + \text{/}$              | `SplitVertical`                         | **垂直分割当前分屏**。            |
| $\text{SUPER\_REV} + \text{\textbackslash}$ | `SplitHorizontal`                       | **水平分割当前分屏**。            |
| $\text{SUPER\_REV} + \text{-}$              | `CloseCurrentPane({ confirm = true })`  | **关闭当前分屏**（需要确认）。        |
| $\text{SUPER} + \text{w}$                   | `CloseCurrentPane({ confirm = false })` | **关闭当前分屏**（不弹出确认）。       |
| $\text{SUPER\_REV} + \text{z}$              | `TogglePaneZoomState`                   | **切换当前分屏的缩放状态**（最大化/恢复）。 |

#### $\text{Panes}$：导航（切换分屏焦点）

| **快捷键**                        | **动作**                           | **功能说明**        |
| ------------------------------ | -------------------------------- | --------------- |
| $\text{SUPER\_REV} + \text{k}$ | `ActivatePaneDirection("Up")`    | **切换焦点到上方的分屏**。 |
| $\text{SUPER\_REV} + \text{j}$ | `ActivatePaneDirection("Down")`  | **切换焦点到下方的分屏**。 |
| $\text{SUPER\_REV} + \text{h}$ | `ActivatePaneDirection("Left")`  | **切换焦点到左侧的分屏**。 |
| $\text{SUPER\_REV} + \text{l}$ | `ActivatePaneDirection("Right")` | **切换焦点到右侧的分屏**。 |

#### $\text{Panes}$：直接调整大小

| **快捷键**                                 | **动作**                       | **功能说明**             |
| --------------------------------------- | ---------------------------- | -------------------- |
| $\text{SUPER\_REV} + \text{UpArrow}$    | `AdjustPaneSize("Up", 1)`    | **向上调整分屏大小**（收缩上边界）。 |
| $\text{SUPER\_REV} + \text{DownArrow}$  | `AdjustPaneSize("Down", 1)`  | **向下调整分屏大小**（收缩下边界）。 |
| $\text{SUPER\_REV} + \text{LeftArrow}$  | `AdjustPaneSize("Left", 1)`  | **向左调整分屏大小**（收缩左边界）。 |
| $\text{SUPER\_REV} + \text{RightArrow}$ | `AdjustPaneSize("Right", 1)` | **向右调整分屏大小**（收缩右边界）。 |

---

### 📏 字体大小调整

| **快捷键**                           | **动作**             | **功能说明**        |
| --------------------------------- | ------------------ | --------------- |
| $\text{SUPER} + \text{UpArrow}$   | `IncreaseFontSize` | **增大字体大小**。     |
| $\text{SUPER} + \text{DownArrow}$ | `DecreaseFontSize` | **减小字体大小**。     |
| $\text{SUPER} + \text{r}$         | `ResetFontSize`    | **重置字体大小**到默认值。 |

---

## 🔑 $\text{Key}$ $\text{Tables}$（按键表，即 $\text{Leader}$ 模式）

您的配置使用了 **$\text{Leader}$ 键**来启用一组临时的快捷键模式，这类似于 Vim 或 Tmux 的操作方式。

### ⚙️ $\text{Leader}$ 键定义

| **动作**          | **键组合**                                               | **功能说明**                                                                               |
| --------------- | ----------------------------------------------------- | -------------------------------------------------------------------------------------- |
| $\text{LEADER}$ | **$\text{CTRL} + \text{SHIFT} + \text{Space}$** (空格键) | **激活 $\text{Leader}$ 模式**。按住 $\text{CTRL} + \text{SHIFT}$ 后按一下 $\text{Space}$ 即可进入该模式。 |

### 调整模式 (resize_font/resize_pane)

一旦进入 $\text{Leader}$ 模式（按 $\text{CTRL} + \text{SHIFT} + \text{Space}$），您可以接着按以下键进入不同的调整模式：

| **快捷键 (在 Leader 模式下)** | **动作**                            | **功能说明**      |
| ---------------------- | --------------------------------- | ------------- |
| $\text{f}$             | `ActivateKeyTable("resize_font")` | **进入字体调整模式**。 |
| $\text{p}$             | `ActivateKeyTable("resize_pane")` | **进入分屏调整模式**。 |

#### 字体调整模式 (`resize_font`)

在 $\text{Leader} \rightarrow \text{f}$ 之后，您可以：

| **键**                        | **动作**             | **功能说明**      |
| ---------------------------- | ------------------ | ------------- |
| $\text{k}$                   | `IncreaseFontSize` | **增大字体**。     |
| $\text{j}$                   | `DecreaseFontSize` | **减小字体**。     |
| $\text{r}$                   | `ResetFontSize`    | **重置字体**。     |
| $\text{Escape}$ 或 $\text{q}$ | `PopKeyTable`      | **退出字体调整模式**。 |

#### 分屏调整模式 (`resize_pane`)

在 $\text{Leader} \rightarrow \text{p}$ 之后，您可以：

| **键**                        | **动作**                       | **功能说明**           |
| ---------------------------- | ---------------------------- | ------------------ |
| $\text{k}$                   | `AdjustPaneSize("Up", 1)`    | **向上收缩**（上方分屏会变大）。 |
| $\text{j}$                   | `AdjustPaneSize("Down", 1)`  | **向下收缩**（下方分屏会变大）。 |
| $\text{h}$                   | `AdjustPaneSize("Left", 1)`  | **向左收缩**（左侧分屏会变大）。 |
| $\text{l}$                   | `AdjustPaneSize("Right", 1)` | **向右收缩**（右侧分屏会变大）。 |
| $\text{Escape}$ 或 $\text{q}$ | `PopKeyTable`                | **退出分屏调整模式**。      |

---

## 🖱️ 鼠标操作 (mouse_bindings)

| **鼠标事件**                    | **修饰键**       | **动作**                                                     | **功能说明**                                        |
| --------------------------- | ------------- | ---------------------------------------------------------- | ----------------------------------------------- |
| $\text{Left Click}$ (单击)    | $\text{CTRL}$ | `OpenLinkAtMouseCursor`                                    | **$\text{CTRL} + \text{左键}$**：**打开**光标下的**链接**。 |
| $\text{Left Click}$ (按住/拖拽) | $\text{NONE}$ | `SelectTextAtMouseCursor` / `ExtendSelectionToMouseCursor` | **左键按住并拖拽**：**选择文本**（不会自动复制到剪贴板）。               |
| $\text{Left Click}$ (双击)    | $\text{NONE}$ | `SelectTextAtMouseCursor("Word")`                          | **双击左键**：**选择一个单词**。                            |
| $\text{Left Click}$ (三击)    | $\text{NONE}$ | `SelectTextAtMouseCursor("Line")`                          | **三击左键**：**选择一整行**。                             |
| $\text{WheelUp/Down}$ (滚轮)  | $\text{NONE}$ | `ScrollByCurrentEventWheelDelta`                           | **滚轮上下滚动**：**滚动屏幕内容**。                          |
