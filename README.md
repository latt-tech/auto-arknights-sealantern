# Auto Arknights - SeaLantern 明日方舟自动安装插件

一个用于 SeaLantern 的自动安装明日方舟游戏客户端的插件。

## 功能概述

Auto Arknights 插件提供以下功能：

- **自动下载**：从指定服务器下载明日方舟安装程序
- **静默安装**：使用 NSIS 静默安装参数自动安装游戏
- **安装检测**：通过标记文件检测是否已安装，避免重复安装
- **一键启用**：启用插件即可自动完成下载和安装流程

## 核心功能

### 自动下载安装

插件启用时会自动执行以下步骤：

1. 检测 `%LOCALAPPDATA%\.ark-installed` 标记文件
2. 如果标记文件不存在，开始下载安装程序
3. 从 `https://codeload.whirity404.tech/plugins-dist/arknights.exe` 下载安装程序
4. 保存到 `%TEMP%\arknights.exe`
5. 执行静默安装命令 `arknights.exe /S`
6. 创建标记文件 `%LOCALAPPDATA%\.ark-installed` 并写入数字 1

### 安装检测

插件通过检查标记文件来判断是否已安装：

- 标记文件路径：`%LOCALAPPDATA%\.ark-installed`
- 标记文件内容：数字 1
- 如果标记文件存在，插件会跳过安装流程

## 使用方法

### 安装插件

1. 在插件市场中找到 Auto Arknights
2. 点击"安装"按钮
3. 等待插件安装完成

### 启用插件

1. 进入"插件"页面
2. 找到 Auto Arknights 插件
3. 点击开关启用插件
4. 插件会自动开始下载和安装明日方舟

### 查看日志

1. 打开 SeaLantern 控制台
2. 查看插件输出的日志信息
3. 日志会显示下载进度和安装状态

## 工作原理

### 插件生命周期

```
onLoad() -> 插件加载
onEnable() -> 插件启用（执行自动安装）
onDisable() -> 插件禁用
onUnload() -> 插件卸载
```

### 安装流程

```
启用插件
    ↓
检查标记文件
    ↓
标记文件存在？
    ↓ 是
跳过安装
    ↓ 否
下载安装程序
    ↓
保存到临时目录
    ↓
执行静默安装
    ↓
创建标记文件
    ↓
安装完成
```

## 文件说明

### manifest.json

定义了插件的基本信息和权限：

```json
{
  "id": "auto-arknights",
  "name": "明日方舟自动安装器",
  "version": "1.0.0",
  "permissions": ["log", "filesystem", "http", "process"]
}
```

**权限说明：**
- `log`：记录日志信息
- `filesystem`：访问文件系统（读取/写入标记文件）
- `http`：下载安装程序
- `process`：执行安装程序

### main.lua

插件的主要逻辑文件，包含：

- **下载 URL**：`https://codeload.whirity404.tech/plugins-dist/arknights.exe`
- **标记文件**：`.ark-installed`
- **安装命令**：`arknights.exe /S`

### style.css

插件的自定义样式文件（当前为空）。

### icon.png

插件的图标文件。

## 配置说明

### 修改下载地址

如需修改下载地址，编辑 [main.lua](main.lua#L3)：

```lua
local DOWNLOAD_URL = "https://your-server.com/arknights.exe"
```

### 修改标记文件路径

如需修改标记文件位置，编辑 [main.lua](main.lua#L4)：

```lua
local MARKER_FILE_NAME = ".ark-installed"
```

### 修改安装参数

如需修改安装参数，编辑 [main.lua](main.lua#L55)：

```lua
local installCommand = "\"" .. installerPath .. "\" /S"
```

## 限制和注意事项

1. **仅限 Windows**：插件使用 Windows 特定的环境变量和命令
2. **网络要求**：需要能够访问下载服务器
3. **管理员权限**：安装程序可能需要管理员权限
4. **一次性安装**：插件只会在首次启用时安装，之后会跳过
5. **手动卸载**：如需重新安装，需手动删除标记文件

## 常见问题

### 如何重新安装明日方舟？

1. 删除 `%LOCALAPPDATA%\.ark-installed` 文件
2. 禁用并重新启用插件
3. 插件会重新执行安装流程

### 安装失败怎么办？

1. 检查网络连接
2. 检查控制台日志查看错误信息
3. 确保下载服务器可访问
4. 确保有足够的磁盘空间

### 如何查看安装进度？

1. 打开 SeaLantern 控制台
2. 查看插件输出的日志信息
3. 日志会显示每个步骤的执行状态

### 标记文件在哪里？

标记文件位于：`%LOCALAPPDATA%\.ark-installed`

通常路径为：`C:\Users\你的用户名\AppData\Local\.ark-installed`

## 技术细节

### 环境变量

插件使用以下环境变量：

- `LOCALAPPDATA`：用于存储标记文件
- `TEMP`：用于存储下载的安装程序

### HTTP 请求

插件使用 `sl.http.get()` 方法下载文件：

```lua
local response, err = sl.http.get(DOWNLOAD_URL)
```

### 文件操作

插件使用标准 Lua I/O 操作文件：

```lua
local file = io.open(filePath, "wb")
file:write(response.body)
file:close()
```

### 进程执行

插件使用 `os.execute()` 执行安装程序：

```lua
os.execute("\"" .. installerPath .. "\" /S")
```

## 开发者说明

如果你想基于此插件开发自己的自动安装插件：

1. 复制 Auto Arknights 的实现结构
2. 修改 [manifest.json](manifest.json) 中的插件信息
3. 在 [main.lua](main.lua) 中修改下载 URL 和安装逻辑
4. 确保使用正确的权限
5. 测试插件的完整流程

## 版本历史

### v1.0.0

- 初始版本
- 支持自动下载明日方舟安装程序
- 支持静默安装
- 支持安装检测
- 支持标记文件管理

## 许可证

GPLv3 License

## 贡献

欢迎贡献！请提交 Pull Request 或创建 Issue。

## 相关链接

- **SeaLantern 项目**：https://github.com/SeaLantern-Studio/SeaLantern
- **插件仓库**：https://github.com/latt-tech/auto-arknights-sealantern.git

## 致谢

SeaLantern 是一个开源项目，遵循 GPLv3 协议。
明日方舟是鹰角网络的游戏，本插件仅用于自动化安装，与鹰角网络无关。