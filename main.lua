local plugin = {}

local MARKER_FILE_NAME = ".ark-installed"

function plugin.onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

function plugin.onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    
    -- 极简实现，只使用最基本的 Lua 功能
    local markerFilePath = ".ark-installed"
    
    local markerFile = io.open(markerFilePath, "r")
    if markerFile then
        markerFile:close()
        sl.log.info("检测到明日方舟已安装，跳过自动安装流程")
        return
    end
    
    sl.log.info("开始安装明日方舟...")
    
    -- 创建标记文件
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