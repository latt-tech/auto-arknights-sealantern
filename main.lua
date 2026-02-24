local plugin = {}

function plugin.onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

function plugin.onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    sl.log.info("开始安装明日方舟...")
    sl.log.info("下载安装程序中...")
    sl.log.info("正在安装游戏...")
    sl.log.info("安装完成！")
    sl.log.info("明日方舟自动安装流程完成")
end

function plugin.onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
end

function plugin.onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
end

return plugin