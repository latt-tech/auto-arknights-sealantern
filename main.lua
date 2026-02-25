local plugin = {}

function plugin.onLoad()
    sl.log.info("明日方舟自动安装器插件已加载")
end

function plugin.onEnable()
    sl.log.info("明日方舟自动安装器插件已启用")
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