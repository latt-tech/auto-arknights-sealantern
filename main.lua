local plugin = {}

function plugin.onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

function plugin.onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
    
    -- 尝试创建新的标签页显示网易云游戏
    local success, err = sl.ui.createTab({
        id = "arknights-cloud-game",
        title = "明日方舟云游戏",
        content = [[
            <html>
            <head>
                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        height: 100vh;
                        overflow: hidden;
                    }
                    iframe {
                        width: 100%;
                        height: 100%;
                        border: none;
                    }
                </style>
            </head>
            <body>
                <iframe src="https://cg.163.com/static/game/mrfz?sourcepage=mobile&show=mrfz&back=https%3A%2F%2Fcg.163.com%2F%23%2Fmobile%3Ftopic%3D%25E7%2583%25AD%25E9%2597%25A8%25E6%2589%258B%25E6%25B8%25B8"></iframe>
            </body>
            </html>
        ]]
    })
    
    if success then
        sl.log.info("成功创建明日方舟云游戏标签页")
    else
        sl.log.error("创建标签页失败: " .. tostring(err))
        
        -- 备选方案：尝试打开外部浏览器
        local openSuccess, openErr = sl.system.openUrl("https://cg.163.com/static/game/mrfz?sourcepage=mobile&show=mrfz&back=https%3A%2F%2Fcg.163.com%2F%23%2Fmobile%3Ftopic%3D%25E7%2583%25AD%25E9%2597%25A8%25E6%2589%258B%25E6%25B8%25B8")
        if openSuccess then
            sl.log.info("已在外部浏览器打开明日方舟云游戏")
        else
            sl.log.error("打开外部浏览器失败: " .. tostring(openErr))
        end
    end
end

function plugin.onDisable()
    sl.log.info("明日方舟自动安装器插件已禁用")
end

function plugin.onUnload()
    sl.log.info("明日方舟自动安装器插件已卸载")
end

function plugin.getPageContent()
    return [[
        <div class="arknights-iframe-container">
            <iframe class="arknights-iframe" src="https://cg.163.com/static/game/mrfz?sourcepage=mobile&show=mrfz&back=https%3A%2F%2Fcg.163.com%2F%23%2Fmobile%3Ftopic%3D%25E7%2583%25AD%25E9%2597%25A8%25E6%2589%258B%25E6%25B8%25B8"></iframe>
        </div>
    ]]
end

return plugin