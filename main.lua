local plugin_id = "auto-arknights"

-- 插件加载时调用
function onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

-- 插件启用时调用
function onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    -- 显示网易云游戏页面
    createCloudGameOverlay()
end

-- 插件禁用时调用
function onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
    -- 移除可能存在的覆盖层
    sl.ui.remove_html("arknights-cloud-game-overlay")
end

-- 插件卸载时调用
function onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
    -- 移除可能存在的覆盖层
    sl.ui.remove_html("arknights-cloud-game-overlay")
end

-- 创建网易云游戏全屏覆盖层
function createCloudGameOverlay()
    sl.log.info("创建网易云游戏覆盖层")
    local overlay_id = "arknights-cloud-game-overlay"
    
    -- 先移除可能存在的旧覆盖层
    sl.ui.remove_html(overlay_id)
    
    -- 注入CSS样式
    local css = [[
        #arknights-cloud-game-overlay {
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
        
        #arknights-cloud-game-iframe {
            width: 100% !important;
            height: 100% !important;
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
    
    sl.ui.inject_css("arknights-cloud-game-styles", css)
    sl.log.info("注入CSS样式")
    
    -- 创建全屏覆盖层，显示网易云游戏
    local html = [[
        <div id="arknights-cloud-game-overlay">
            <button id="arknights-close-button" onclick="this.parentElement.remove();">×</button>
            <iframe id="arknights-cloud-game-iframe" src="https://cg.163.com/static/game/mrfz?sourcepage=mobile&show=mrfz&back=https%3A%2F%2Fcg.163.com%2F%23%2Fmobile%3Ftopic%3D%25E7%2583%25AD%25E9%2597%25A8%25E6%2589%258B%25E6%25B8%25B8"></iframe>
        </div>
    ]]
    
    sl.log.info("注入HTML")
    
    local result = sl.ui.inject_html(overlay_id, html)
    sl.log.info("注入结果: " .. tostring(result))
end

-- 获取插件页面内容
function getPageContent()
    return [[
        <div style="width: 100%; height: 100vh; margin: 0; padding: 0; overflow: hidden;">
            <iframe src="https://cg.163.com/static/game/mrfz?sourcepage=mobile&show=mrfz&back=https%3A%2F%2Fcg.163.com%2F%23%2Fmobile%3Ftopic%3D%25E7%2583%25AD%25E9%2597%25A8%25E6%2589%258B%25E6%25B8%25B8" style="width: 100%; height: 100%; border: none;"></iframe>
        </div>
    ]]
end