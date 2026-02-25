local plugin_id = "auto-arknights"

-- 插件加载时调用
function onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

-- 插件启用时调用
function onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    sl.log.info("明日方舟图片功能已准备就绪")
    sl.log.info("请点击侧边栏中的'明日方舟'查看图片")
end

-- 插件禁用时调用
function onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
end

-- 插件卸载时调用
function onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
end

-- 获取插件页面内容
function getPageContent()
    return [[
        <div style="width: 100%; height: 100vh; margin: 0; padding: 0; overflow: hidden; display: flex; align-items: center; justify-content: center; background: #000000;">
            <img src="logo.png" alt="明日方舟" style="max-width: 80%; max-height: 80%; border: none;">
        </div>
    ]]
end
