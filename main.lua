local plugin_id = "auto-arknights"

-- 插件加载时调用
function onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

-- 插件启用时调用
function onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    -- 显示明日方舟图片
    createImageOverlay()
end

-- 插件禁用时调用
function onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
    -- 移除可能存在的覆盖层
    sl.ui.remove_html("arknights-image-overlay")
end

-- 插件卸载时调用
function onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
    -- 移除可能存在的覆盖层
    sl.ui.remove_html("arknights-image-overlay")
end

-- 创建明日方舟图片全屏覆盖层
function createImageOverlay()
    sl.log.info("创建明日方舟图片覆盖层")
    local overlay_id = "arknights-image-overlay"
    
    -- 先移除可能存在的旧覆盖层
    sl.ui.remove_html(overlay_id)
    
    -- 注入CSS样式
    local css = [[
        #arknights-image-overlay {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: #000000 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            z-index: 9999 !important;
            margin: 0 !important;
            padding: 0 !important;
            border: none !important;
            opacity: 1;
        }
        
        #arknights-image {
            max-width: 80% !important;
            max-height: 80% !important;
            border: none !important;
        }
        
        #arknights-close-button {
            position: absolute !important;
            top: 20px !important;
            right: 20px !important;
            background: rgba(0, 0, 0, 0.5) !important;
            color: white !important;
            border: none !important;
            border-radius: 50% !important;
            width: 40px !important;
            height: 40px !important;
            font-size: 20px !important;
            cursor: pointer !important;
            z-index: 10000 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }
        
        #arknights-close-button:hover {
            background: rgba(0, 0, 0, 0.8) !important;
        }
    ]]
    
    sl.ui.inject_css("arknights-image-styles", css)
    sl.log.info("注入CSS样式")
    
    -- 创建全屏覆盖层，显示明日方舟图片
    local html = [[
        <div id="arknights-image-overlay">
            <button id="arknights-close-button" onclick="this.parentElement.remove();">×</button>
            <img id="arknights-image" src="logo.png" alt="明日方舟">
        </div>
    ]]
    
    sl.log.info("注入HTML")
    
    local result = sl.ui.inject_html(overlay_id, html)
    sl.log.info("注入结果: " .. tostring(result))
end

-- 获取插件页面内容
function getPageContent()
    return [[
        <div style="width: 100%; height: 100vh; margin: 0; padding: 0; overflow: hidden; display: flex; align-items: center; justify-content: center; background: #000000;">
            <img src="logo.png" alt="明日方舟" style="max-width: 80%; max-height: 80%; border: none;">
        </div>
    ]]
end