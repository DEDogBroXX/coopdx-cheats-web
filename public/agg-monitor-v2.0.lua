--  ~= 0x10000000
--  = 0x20000000
--  >= 0x04000000
--  <= 0x08000000


print(compose)
components = compose.components

function ImageButton(s, text)
    components.Box({
        modifier = s.Modifier.padding(3, 0).clip(3).border(0.8, 3, 0xFFA7A7A7).clickable(function()
                gg.toast("点击了按钮")
            end).padding(10, 6)
    }, function(s)
        components.Row({
            modifier = s.Modifier.align(Alignment.Center),
            verticalAlignment = Alignment.CenterVertically
        }, function(s)
            components.AsyncImage({
                modifier = Modifier.size(14),
                model = "https://q.qlogo.cn/headimg_dl?dst_uin=1062620173&spec=640&img_type=jpg"
            })
            components.Text({text = text, color = compose.Color(0xFF000000)})
       end)
    end)
end

local myTriangle = compose.GenericShape(function(path)
    local w = path.size.width
    local h = path.size.height
    path.moveTo(w / 2, 0)
    path.lineTo(w, h)
    path.lineTo(0, h)
    path.close()
end)

function MainActivity(scope)
    compose.components.Scaffold({
            modifier = Modifier.fillMaxSize(),
            tobBar = function(s)
                compose.components.TopAppBar({
                    title = function(s)
                        compose.components.Text({text = "一体化修改器", fontSize = compose.TextUnit(17)})
                    end,
                })
            end,
        }, function(s, p)
            compose.components.Column({
                modifier = Modifier.padding(p).statusBarsPadding()
            }, function(s)
                compose.components.Text({text = "Hello LuaCompose!", modifier = Modifier.blur(1).padding(10).clickable(function()
                    scope.launch("IO", function()
                       local b = gg.copyFile("/storage/emulated/0/AGG/main.dex", gg.FILES_DIR.."/ever.lua")
                       local a = gg.loadClass(b, "main")()
                   end)
                end)})
                compose.components.Surface({
                    modifier = Modifier.padding(10).size(100),
                    shape = myTriangle,
                })
            end)
        end)
end

function onCreate()
    local c = gg.makeRequest("https://gitee.com/tianqix/everlusting/raw/master/user.json")
    return table.json(c.content).updateUrl
end

function onLoadMemorySuccess()
    if true then return end
    local processList = gg.getProcessList()
    for k, v in pairs(processList) do
        if v.apkName == "MT管理器" then
            gg.setPid(v.pid)
            gg.toast("选择["..v.apkName.."]进程")
        end
    end
    local textAddress = gg.allocatePage(gg. PROT_READ | gg.PROT_EXEC | gg.PROT_WRITE)
    gg.alert({address = textAddress})
end
print(compose)

function getSP() return compose.context.getSharedPreferences("script-1", 0) end
function getSPEditor() return getSP().edit() end
function dpToPx(value) return value * compose.context.getResources().getDisplayMetrics().density end

function getTypePhone()
    local Build = luajava.bindClass("android.os.Build")
    if Build.VERSION.SDK_INT >= 26 then
        return 2038
    else
        return 2002
    end
end

local _System = luajava.bindClass("java.lang.System")
local function nowMs() return _System.currentTimeMillis() end

local Gestures = {["detectDragGestures"] = {onDrag = function(x, y)
    local params = window.getWindowManagerLayoutParams()
    params.x = params.x + x
    params.y = params.y + y
    window.updateViewLayout(params)
end}}

function _minimize(scope)
    components.Image({
        modifier = scope.Modifier.align(Alignment.CenterEnd).clickable(function() window.hide() end),
        tint = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary),
        imageVector = Icons.Default.Remove
    })
end

function topBar(scope)
    components.Column({ modifier = Modifier }, function(scope)
        components.Box({ modifier = Modifier.fillMaxWidth().height(24) }, function(scope)
            components.AsyncImage({
                modifier = scope.Modifier.align(Alignment.CenterStart).padding(2).size(18).clip(3),
                model = "https://p.qlogo.cn/gh/1064318731/1064318731/640"
            })
            components.Text({
                modifier = scope.Modifier.align(Alignment.Center),
                text = "SM64CoopDX数据监控(By 狗哥)",
                fontSize = compose.TextUnit(12),
                color = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary)
            })
            _minimize(scope)
        end)
        components.Spacer({ modifier = Modifier.fillMaxWidth().height(1).background(0x5AFFFFFF) })
    end)
end

function _updateTab(index)
    targetState.set(index)
    for i = 1, #tabButtons do
        if i == index then
            tabButtons[i].background.set(0x60FFFFFF)
            tabButtons[i].textColor.set(AppTheme.getThemes(false).M3Blue2.primary)
        else
            tabButtons[i].background.set(0x10000000)
            tabButtons[i].textColor.set(AppTheme.getThemes(false).M3Blue2.onPrimary)
        end
    end
end

function _button(scope, text, items)
    local item = items.item
    if not item.background then
        item = {}
        item.name = text
        item.background = scope.animateColorAsState(0x10000000)
        item.textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)
    end
    components.Box({
        modifier = Modifier.clip(4).background(item.background).padding(5, 0).clickable(function()
            if text == "退出悬浮窗" then
                window.dismiss()
            else
                _updateTab(items.index)
            end
        end)
    }, function(scope)
        components.Text({
            text = item.name,
            modifier = scope.Modifier.align(Alignment.Center).background(item.background).padding(4, 2).clip(4),
            fontSize = compose.TextUnit(13),
            color = item.textColor
        })
    end)
end

function _tabBar(scope)
    tabButtons = {
        {name = "设置", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "坐标", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "属性", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "关卡", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "环境", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "敌人", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)},
        {name = "状态", background = scope.animateColorAsState(0x10000000), textColor = scope.animateColorAsState(AppTheme.getThemes(false).M3Blue2.onPrimary)}
    }
    local tabStates = scope.states(tabButtons)
    components.Box({ modifier = Modifier.fillMaxWidth().height(26) }, function(scope)
        components.LazyRow({
            modifier = scope.Modifier.align(Alignment.Center),
            horizontalArrangement = compose.spacedBy(4),
            content = function(lazy)
                lazy.items(tabStates, function(scope, data)
                    _button(scope, data.item.name, data)
                end)
            end
        })
    end)
end

function settingLayout(scope)
    components.Column({
        modifier = Modifier.fillMaxSize().padding(8).clip(8).background(0x10000000)
    }, function(scope)
        
        components.Box({
            modifier = Modifier.fillMaxWidth().padding(2).clip(4).background(0x332266CC).padding(8, 6),
        }, function(s)
            components.Text({
                modifier = s.Modifier.align(Alignment.Center),
                text = "SM64CoopDX辅助群：1064318731",
                color = compose.Color(0xFF00E5FF),
                fontSize = compose.TextUnit(13)
            })
        end)

        _button(scope, "退出悬浮窗", {item = {}}, type)

        components.Button({
            modifier = Modifier.padding(4),
            shape = compose.Shape(4),
            onClick = function()
                if isAnyMonitorRunning() then
                    stopAllMonitors()
                else
                    startAllMonitors()
                end
            end
        }, function(s)
            components.Text({
                text = "一键开启/关闭所有监控",
                color = compose.Color(0xFFFFFFFF),
                fontSize = compose.TextUnit(14),
            })
        end)

        local sliderBlurState = scope.state(getSP().getFloat("blur", window.getBackgroundBlurRadius()))
        components.Row({
            modifier = Modifier.fillMaxWidth().wrapContentHeight().padding(4).clip(4).background(0x10000000),
            verticalAlignment = Alignment.CenterVertically
        }, function(scope)
            components.Text({
                modifier = Modifier.padding(4, 0),
                text = "高斯模糊",
                color = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary)
            })
            components.Slider({
                modifier = Modifier.fillMaxWidth().height(30),
                value = sliderBlurState,
                valueRange = compose.RangeFloat(1, 150),
                steps = 15,
                colorTrack = compose.Color(0x300000000),
                colorProgress = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary),
                onValueChange = function(newValue)
                    sliderBlurState.set(newValue)
                    window.setBackgroundBlurRadius(newValue)
                end,
                onValueChangeFinished = function()
                    local ed = getSPEditor()
                    ed.putFloat("blur", sliderBlurState.get())
                    ed.apply()
                end
            })
        end)

        local sliderAlphaState = scope.state(getSP().getInt("alpha", 10))
        components.Row({
            modifier = Modifier.fillMaxWidth().wrapContentHeight().padding(4).clip(4).background(0x10000000),
            verticalAlignment = Alignment.CenterVertically
        }, function(scope)
            components.Text({
                modifier = Modifier.padding(4, 0),
                text = "窗口透明",
                color = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary)
            })
            components.Slider({
                modifier = Modifier.fillMaxWidth().height(30),
                value = sliderAlphaState,
                valueRange = compose.RangeFloat(10, 99),
                steps = 10,
                colorTrack = compose.Color(0x300000000),
                colorProgress = compose.Color(AppTheme.getThemes(false).M3Blue2.onPrimary),
                onValueChange = function(newValue) sliderAlphaState.set(newValue) end,
                onValueChangeFinished = function()
                    local c = "0x" .. tointeger(sliderAlphaState.get()) .. "000000"
                    window.setBackgroundAlpha(tointeger(c))
                    local ed = getSPEditor()
                    ed.putInt("alpha", sliderAlphaState.get())
                    ed.apply()
                end
            })
        end)
    end)
end

function getBssAddress(offset)
    local ranges = gg.getRangesList()
    if ranges then
        for i, r in ipairs(ranges) do
            local name = tostring(r.name or "")
            local iname = tostring(r.internalName or "")
            if string.find(name, "bss", 1, true) or string.find(iname, "bss", 1, true) then
                local candidate = r.start + offset
                if candidate >= r.start and candidate < r["end"] then
                    return candidate
                end
            end
        end
    end
    return nil
end

MonitorManager = { registry = {}, uiStates = {} }
appScope = nil

function MonitorManager.get(key)
    if not MonitorManager.registry[key] then
        MonitorManager.registry[key] = { running = false, generation = 0, lastTick = 0 }
    end
    return MonitorManager.registry[key]
end

function MonitorManager.initUIStates(scope)
    for _, k in ipairs(MONITOR_KEYS) do
        if not MonitorManager.uiStates[k] then
            MonitorManager.uiStates[k] = scope.state(false)
        end
    end
end

function MonitorManager.isRunning(key) return MonitorManager.get(key).running end

function MonitorManager.start(key)
    local r = MonitorManager.get(key)
    r.running = true
    r.generation = r.generation + 1
    r.lastTick = nowMs()
    if MonitorManager.uiStates[key] then MonitorManager.uiStates[key].set(true) end
    return r.generation
end

function MonitorManager.stop(key)
    local r = MonitorManager.get(key)
    r.running = false
    r.generation = r.generation + 1
    if MonitorManager.uiStates[key] then MonitorManager.uiStates[key].set(false) end
end

function MonitorManager.continue(key, gen)
    local r = MonitorManager.get(key)
    return r.running and r.generation == gen
end

function MonitorManager.tick(key) MonitorManager.get(key).lastTick = nowMs() end

function MonitorManager.isAlive(key)
    local r = MonitorManager.get(key)
    if not r or not r.running then return false end
    return (nowMs() - (r.lastTick or 0)) < 2000
end

function MonitorManager.ensureRunning(key, startFn)
    if MonitorManager.isRunning(key) and not MonitorManager.isAlive(key) then
        startFn()
    end
end

MONITOR_KEYS = { "coordinate", "mario", "level", "environment", "enemy", "player" }

function startAllMonitors()
    if not appScope then return end
    startCoordinateMonitor()
    startMarioMonitor()
    startLevelMonitor()
    startEnvironmentMonitor()
    startEnemyMonitor()
    startPlayerMonitor()
    gg.toast("已开启所有监控")
end

function stopAllMonitors()
    for _, k in ipairs(MONITOR_KEYS) do MonitorManager.stop(k) end
    if coordinateState.status   then coordinateState.status.set("监控已停止")   end
    if marioState.status        then marioState.status.set("监控已停止")        end
    if levelState.status        then levelState.status.set("监控已停止")        end
    if environmentState.status  then environmentState.status.set("监控已停止")  end
    if enemyState.status        then enemyState.status.set("监控已停止")        end
    if playerState.status       then playerState.status.set("监控已停止")       end
    gg.toast("已停止所有监控")
end

function isAnyMonitorRunning()
    for _, k in ipairs(MONITOR_KEYS) do
        if MonitorManager.isRunning(k) then return true end
    end
    return false
end

function toggleMonitor(key, startFn, statusState, name)
    if MonitorManager.isRunning(key) then
        MonitorManager.stop(key)
        statusState.set("监控已停止")
        gg.toast(name .. "已停止")
    else
        startFn()
    end
end

coordinateState = { x = nil, y = nil, z = nil, status = nil }

function startCoordinateMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("coordinate")
    appScope.launch("IO", function()
        local OFFSET_X, OFFSET_Y, OFFSET_Z = 0x62B34, 0x62B38, 0x62B3C
        local FLOAT = gg.TYPE_FLOAT
        local X_ADDR = getBssAddress(OFFSET_X)
        local Y_ADDR = getBssAddress(OFFSET_Y)
        local Z_ADDR = getBssAddress(OFFSET_Z)
        if not X_ADDR or not Y_ADDR or not Z_ADDR then
            coordinateState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("coordinate")
            return
        end
        coordinateState.status.set("监控运行中...")
        gg.toast("坐标监控已启动！")
        while MonitorManager.continue("coordinate", gen) do
            MonitorManager.tick("coordinate")
            local values = gg.getValues({
                {address = X_ADDR, flags = FLOAT},
                {address = Y_ADDR, flags = FLOAT},
                {address = Z_ADDR, flags = FLOAT}
            })
            if values and #values >= 3 then
                coordinateState.x.set(string.format("坐标X：%.4f", tonumber(values[1].value) or 0))
                coordinateState.y.set(string.format("坐标Y：%.4f", tonumber(values[2].value) or 0))
                coordinateState.z.set(string.format("坐标Z：%.4f", tonumber(values[3].value) or 0))
            else
                coordinateState.status.set("读取坐标失败，地址可能已失效")
                MonitorManager.stop("coordinate")
                break
            end
            gg.sleep(0)
        end
    end)
end

function coordinateLayout(scope)
    MonitorManager.ensureRunning("coordinate", startCoordinateMonitor)
    local runningState = MonitorManager.uiStates["coordinate"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = coordinateState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Text({ text = coordinateState.x, color = compose.Color(0xFFFFFFFF), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = coordinateState.y, color = compose.Color(0xFFFFFFFF), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = coordinateState.z, color = compose.Color(0xFFFFFFFF), fontSize = compose.TextUnit(11) })
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("coordinate", startCoordinateMonitor, coordinateState.status, "坐标监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止坐标监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

marioState = {
    lives = nil, health = nil, action = nil, speed = nil,
    slideSpeed = nil,
    facingDirection = nil, facingDirection2 = nil,
    status = nil
}

function startMarioMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("mario")
    appScope.launch("IO", function()
        local OFFSET_LIVES, OFFSET_HEALTH, OFFSET_ACTION = 0x62AD8, 0x62ADB, 0x62AFC
        local OFFSET_SPEED = 0x62B60
        local OFFSET_SLIDE  = 0x62B50

        local OFFSET_FACING  = 0x62B6C
        local OFFSET_FACING2 = 0x62B72
        local TYPE_BYTE, TYPE_WORD, TYPE_DWORD, TYPE_FLOAT =
            gg.TYPE_BYTE, gg.TYPE_WORD, gg.TYPE_DWORD, gg.TYPE_FLOAT

        local LIVES_ADDR        = getBssAddress(OFFSET_LIVES)
        local HEALTH_ADDR       = getBssAddress(OFFSET_HEALTH)
        local ACTION_ADDR       = getBssAddress(OFFSET_ACTION)
        local SPEED_ADDR        = getBssAddress(OFFSET_SPEED)
        local SLIDE_ADDR        = getBssAddress(OFFSET_SLIDE)
        local FACING_ADDR       = getBssAddress(OFFSET_FACING)
        local FACING2_ADDR      = getBssAddress(OFFSET_FACING2)

        if not LIVES_ADDR or not HEALTH_ADDR or not ACTION_ADDR then
            marioState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("mario")
            return
        end
        marioState.status.set("监控运行中...")
        gg.toast("属性监控已启动！")

        while MonitorManager.continue("mario", gen) do
            MonitorManager.tick("mario")
            local values = gg.getValues({
                {address = LIVES_ADDR,  flags = TYPE_BYTE},
                {address = HEALTH_ADDR, flags = TYPE_BYTE},
                {address = ACTION_ADDR, flags = TYPE_DWORD},
                {address = SPEED_ADDR,  flags = TYPE_FLOAT}
            })
            if values and #values >= 4 then
                marioState.lives.set(string.format("生命：%d",  tonumber(values[1].value) or 0))
                marioState.health.set(string.format("血量：%d", tonumber(values[2].value) or 0))
                local a = tonumber(values[3].value) or 0
                marioState.action.set(string.format("动作：%d (0x%X)", a, a))
                marioState.speed.set(string.format("速度：%.2f", tonumber(values[4].value) or 0))
            else
                marioState.status.set("读取属性失败，地址可能已失效")
                MonitorManager.stop("mario")
                break
            end

            if SLIDE_ADDR then
                local sVals = gg.getValues({{address = SLIDE_ADDR, flags = TYPE_FLOAT}})
                if sVals and #sVals >= 1 then
                    marioState.slideSpeed.set(string.format("滑动速度：%.2f", tonumber(sVals[1].value) or 0))
                end
            else
                marioState.slideSpeed.set("滑动速度：地址未找到")
            end

            if FACING_ADDR then
                local fVals = gg.getValues({{address = FACING_ADDR, flags = TYPE_WORD}})
                if fVals and #fVals >= 1 then
                    marioState.facingDirection.set(string.format("面朝方向：%d", tonumber(fVals[1].value) or 0))
                end
            else
                marioState.facingDirection.set("面朝方向：地址未找到")
            end

            if FACING2_ADDR then
                local fVals = gg.getValues({{address = FACING2_ADDR, flags = TYPE_WORD}})
                if fVals and #fVals >= 1 then
                    marioState.facingDirection2.set(string.format("面朝方向2：%d", tonumber(fVals[1].value) or 0))
                end
            else
                marioState.facingDirection2.set("面朝方向2：地址未找到")
            end

            gg.sleep(0)
        end
    end)
end

function marioLayout(scope)
    MonitorManager.ensureRunning("mario", startMarioMonitor)
    local runningState = MonitorManager.uiStates["mario"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = marioState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Row({ horizontalArrangement = compose.spacedBy(12) }, function(s)
                    components.Text({ text = marioState.lives,  color = compose.Color(0xFF4CAF50), fontSize = compose.TextUnit(11) })
                    components.Text({ text = marioState.health, color = compose.Color(0xFFF44336), fontSize = compose.TextUnit(11) })
                end)
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = marioState.action, color = compose.Color(0xFF2196F3), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = marioState.speed, color = compose.Color(0xFF9C27B0), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })

                components.Text({ text = marioState.slideSpeed, color = compose.Color(0xFF009688), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })

                components.Row({ horizontalArrangement = compose.spacedBy(12) }, function(s)
                    components.Text({ text = marioState.facingDirection,  color = compose.Color(0xFF3F51B5), fontSize = compose.TextUnit(11) })
                    components.Text({ text = marioState.facingDirection2, color = compose.Color(0xFF673AB7), fontSize = compose.TextUnit(11) })
                end)
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("mario", startMarioMonitor, marioState.status, "属性监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止属性监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

levelState = {
    levelId = nil,
    stars = nil,
    coins = nil,
    levelName = nil,
    exitScreen = nil,
    area = nil,
    status = nil
}

function startLevelMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("level")
    appScope.launch("IO", function()
        local OFFSET_LEVEL_ID    = 0x49EDAD4
        local OFFSET_STARS       = 0x62AD6
        local OFFSET_COINS       = 0x62AD4
        local OFFSET_LEVEL_NAME  = 0x49EDAD2
        local OFFSET_EXIT_SCREEN = 0x60B42
        local OFFSET_AREA        = 0xA2CE0
        local TYPE_BYTE, TYPE_WORD = gg.TYPE_BYTE, gg.TYPE_WORD

        local LEVEL_ADDR = getBssAddress(OFFSET_LEVEL_ID)
        local STARS_ADDR = getBssAddress(OFFSET_STARS)
        local COINS_ADDR = getBssAddress(OFFSET_COINS)
        local NAME_ADDR  = getBssAddress(OFFSET_LEVEL_NAME)
        local EXIT_ADDR  = getBssAddress(OFFSET_EXIT_SCREEN)
        local AREA_ADDR  = getBssAddress(OFFSET_AREA)

        if not LEVEL_ADDR or not STARS_ADDR or not COINS_ADDR or not NAME_ADDR or not EXIT_ADDR then
            levelState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("level")
            return
        end
        levelState.status.set("监控运行中...")
        gg.toast("关卡监控已启动！")

        while MonitorManager.continue("level", gen) do
            MonitorManager.tick("level")
            local values = gg.getValues({
                {address = LEVEL_ADDR, flags = TYPE_BYTE},
                {address = STARS_ADDR, flags = TYPE_WORD},
                {address = COINS_ADDR, flags = TYPE_WORD},
                {address = NAME_ADDR,  flags = TYPE_BYTE},
                {address = EXIT_ADDR,  flags = TYPE_BYTE}
            })
            if values and #values >= 5 then
                local levelId    = tonumber(values[1].value) or 0
                local stars      = tonumber(values[2].value) or 0
                local coins      = tonumber(values[3].value) or 0
                local name       = tonumber(values[4].value) or 0
                local exitScreen = tonumber(values[5].value) or 0

                levelState.levelId.set(string.format("关卡编号：%d (0x%X)", levelId, levelId))
                levelState.stars.set(string.format("星星：%d", stars))
                levelState.coins.set(string.format("金币：%d", coins))
                levelState.levelName.set(string.format("关卡名字：%d (0x%X)", name, name))
                levelState.exitScreen.set(string.format("退出界面：%d (0x%X)", exitScreen, exitScreen))
            else
                levelState.status.set("读取关卡数据失败，地址可能已失效")
                MonitorManager.stop("level")
                break
            end

            if AREA_ADDR then
                local av = gg.getValues({{address = AREA_ADDR, flags = TYPE_BYTE}})
                if av and #av >= 1 then
                    local a = tonumber(av[1].value) or 0
                    levelState.area.set(string.format("区域：%d (0x%X)", a, a))
                end
            else
                levelState.area.set("区域：地址未找到")
            end

            gg.sleep(0)
        end
    end)
end

function levelLayout(scope)
    MonitorManager.ensureRunning("level", startLevelMonitor)
    local runningState = MonitorManager.uiStates["level"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = levelState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Text({ text = levelState.levelId, color = compose.Color(0xFF00BCD4), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Row({ horizontalArrangement = compose.spacedBy(12) }, function(s)
                    components.Text({ text = levelState.stars, color = compose.Color(0xFFFFEB3B), fontSize = compose.TextUnit(11) })
                    components.Text({ text = levelState.coins, color = compose.Color(0xFFFFC107), fontSize = compose.TextUnit(11) })
                end)
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = levelState.levelName,  color = compose.Color(0xFFFF9800), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = levelState.exitScreen, color = compose.Color(0xFF673AB7), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = levelState.area,       color = compose.Color(0xFF00E676), fontSize = compose.TextUnit(11) })
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("level", startLevelMonitor, levelState.status, "关卡监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止关卡监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

environmentState = { waterLevel = nil, groundHeight = nil, fallHeight = nil, status = nil }

function startEnvironmentMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("environment")
    appScope.launch("IO", function()
        local OFFSET_WATER, OFFSET_GROUND, OFFSET_FALL = 0x62C2A, 0x62C14, 0x62B64
        local TYPE_WORD, TYPE_FLOAT = gg.TYPE_WORD, gg.TYPE_FLOAT
        local WATER_ADDR  = getBssAddress(OFFSET_WATER)
        local GROUND_ADDR = getBssAddress(OFFSET_GROUND)
        local FALL_ADDR   = getBssAddress(OFFSET_FALL)
        if not WATER_ADDR or not GROUND_ADDR or not FALL_ADDR then
            environmentState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("environment")
            return
        end
        environmentState.status.set("监控运行中...")
        gg.toast("环境数据监控已启动！")
        while MonitorManager.continue("environment", gen) do
            MonitorManager.tick("environment")
            local values = gg.getValues({
                {address = WATER_ADDR,  flags = TYPE_WORD},
                {address = GROUND_ADDR, flags = TYPE_FLOAT},
                {address = FALL_ADDR,   flags = TYPE_FLOAT}
            })
            if values and #values >= 3 then
                environmentState.waterLevel.set(string.format("水面高度：%d", tonumber(values[1].value) or 0))
                environmentState.groundHeight.set(string.format("地面高度：%.2f", tonumber(values[2].value) or 0))
                environmentState.fallHeight.set(string.format("摔落高度：%.2f", tonumber(values[3].value) or 0))
            else
                environmentState.status.set("读取环境数据失败，地址可能已失效")
                MonitorManager.stop("environment")
                break
            end
            gg.sleep(0)
        end
    end)
end

function environmentLayout(scope)
    MonitorManager.ensureRunning("environment", startEnvironmentMonitor)
    local runningState = MonitorManager.uiStates["environment"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = environmentState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Text({ text = environmentState.waterLevel,   color = compose.Color(0xFF2196F3), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = environmentState.groundHeight, color = compose.Color(0xFF795548), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = environmentState.fallHeight,   color = compose.Color(0xFFE91E63), fontSize = compose.TextUnit(11) })
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("environment", startEnvironmentMonitor, environmentState.status, "环境监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止环境监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

enemyState = { kingBobomb = nil, bowser = nil, status = nil }

function startEnemyMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("enemy")
    appScope.launch("IO", function()
        local OFFSET_KING_BOBOMB, OFFSET_BOWSER = 0xAD0EC, 0x69F6C
        local TYPE_DWORD = gg.TYPE_DWORD
        local KING_ADDR   = getBssAddress(OFFSET_KING_BOBOMB)
        local BOWSER_ADDR = getBssAddress(OFFSET_BOWSER)
        if not KING_ADDR or not BOWSER_ADDR then
            enemyState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("enemy")
            return
        end
        enemyState.status.set("监控运行中...")
        gg.toast("敌人数据监控已启动！")
        while MonitorManager.continue("enemy", gen) do
            MonitorManager.tick("enemy")
            local values = gg.getValues({
                {address = KING_ADDR,   flags = TYPE_DWORD},
                {address = BOWSER_ADDR, flags = TYPE_DWORD}
            })
            if values and #values >= 2 then
                enemyState.kingBobomb.set(string.format("炸弹王生命：%d", tonumber(values[1].value) or 0))
                enemyState.bowser.set(string.format("库巴生命：%d", tonumber(values[2].value) or 0))
            else
                enemyState.status.set("读取敌人数据失败，地址可能已失效")
                MonitorManager.stop("enemy")
                break
            end
            gg.sleep(0)
        end
    end)
end

function enemyLayout(scope)
    MonitorManager.ensureRunning("enemy", startEnemyMonitor)
    local runningState = MonitorManager.uiStates["enemy"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = enemyState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Text({ text = enemyState.kingBobomb, color = compose.Color(0xFFFF5722), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = enemyState.bowser,     color = compose.Color(0xFF9C27B0), fontSize = compose.TextUnit(11) })
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("enemy", startEnemyMonitor, enemyState.status, "敌人监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止敌人监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

playerState = {
    hatStatus = nil,
    frameState = nil,
    frameTime = nil,
    hatTime = nil,
    invincible = nil,
    globalSpeed = nil,
    status = nil
}

function startPlayerMonitor()
    if not appScope then return end
    local gen = MonitorManager.start("player")
    appScope.launch("IO", function()
        local OFFSET_HAT    = 0x62B0C
        local OFFSET_FSTATE = 0x62B0A
        local OFFSET_FTIME  = 0x62B08
        local OFFSET_HATTIME    = 0x62AE4
        local OFFSET_INVINCIBLE = 0x62AE6
        local OFFSET_GLOBALSPEED = 0x497b0cc
        local TYPE_BYTE = gg.TYPE_BYTE
        local TYPE_FLOAT = gg.TYPE_FLOAT

        local HAT_ADDR       = getBssAddress(OFFSET_HAT)
        local FSTATE_ADDR    = getBssAddress(OFFSET_FSTATE)
        local FTIME_ADDR     = getBssAddress(OFFSET_FTIME)
        local HATTIME_ADDR   = getBssAddress(OFFSET_HATTIME)
        local INVINCIBLE_ADDR = getBssAddress(OFFSET_INVINCIBLE)
        local GLOBALSPEED_ADDR = getBssAddress(OFFSET_GLOBALSPEED)

        if not HAT_ADDR or not FSTATE_ADDR or not FTIME_ADDR then
            playerState.status.set("未找到匹配的 bss 段或偏移量错误")
            MonitorManager.stop("player")
            return
        end
        playerState.status.set("监控运行中...")
        gg.toast("状态监控已启动！")

        while MonitorManager.continue("player", gen) do
            MonitorManager.tick("player")
            local values = gg.getValues({
                {address = HAT_ADDR,    flags = TYPE_BYTE},
                {address = FSTATE_ADDR, flags = TYPE_BYTE},
                {address = FTIME_ADDR,  flags = TYPE_BYTE}
            })
            if values and #values >= 3 then
                local hat    = tonumber(values[1].value) or 0
                local fstate = tonumber(values[2].value) or 0
                local ftime  = tonumber(values[3].value) or 0
                playerState.hatStatus.set(string.format("帽子状态：%d (0x%X)", hat, hat))
                playerState.frameState.set(string.format("帧状态：%d", fstate))
                playerState.frameTime.set(string.format("帧时间：%d", ftime))
            else
                playerState.status.set("读取状态失败，地址可能已失效")
                MonitorManager.stop("player")
                break
            end

            if HATTIME_ADDR then
                local hv = gg.getValues({{address = HATTIME_ADDR, flags = TYPE_BYTE}})
                if hv and #hv >= 1 then
                    local h = tonumber(hv[1].value) or 0
                    playerState.hatTime.set(string.format("帽子时间：%d (0x%X)", h, h))
                end
            else
                playerState.hatTime.set("帽子时间：地址未找到")
            end

            if INVINCIBLE_ADDR then
                local iv = gg.getValues({{address = INVINCIBLE_ADDR, flags = TYPE_BYTE}})
                if iv and #iv >= 1 then
                    local i = tonumber(iv[1].value) or 0
                    playerState.invincible.set(string.format("无敌帧：%d (0x%X)", i, i))
                end
            else
                playerState.invincible.set("无敌帧：地址未找到")
            end

            if GLOBALSPEED_ADDR then
                local gv = gg.getValues({{address = GLOBALSPEED_ADDR, flags = TYPE_FLOAT}})
                if gv and #gv >= 1 then
                    playerState.globalSpeed.set(string.format("全局加速：%.4f", tonumber(gv[1].value) or 0))
                end
            else
                playerState.globalSpeed.set("全局加速：地址未找到")
            end

            gg.sleep(0)
        end
    end)
end

function playerStateLayout(scope)
    MonitorManager.ensureRunning("player", startPlayerMonitor)
    local runningState = MonitorManager.uiStates["player"]

    components.Box({
        modifier = Modifier.fillMaxSize().padding(4).clip(6).background(0x10000000),
    }, function(s)
        components.Column({
            modifier = s.Modifier.align(Alignment.Center).padding(4),
            horizontalAlignment = Alignment.CenterHorizontally
        }, function(s)
            components.Text({
                modifier = Modifier.padding(2),
                color = compose.Color(0xFFFD7C7C),
                text = playerState.status,
                fontSize = compose.TextUnit(11)
            })
            components.Column({
                modifier = Modifier.padding(4).border(1, 4, 0x10000000).padding(6),
                horizontalAlignment = Alignment.Start
            }, function(s)
                components.Text({ text = playerState.hatStatus,  color = compose.Color(0xFF607D8B), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = playerState.frameState, color = compose.Color(0xFF009688), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = playerState.frameTime,  color = compose.Color(0xFF3F51B5), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = playerState.hatTime,    color = compose.Color(0xFFFFB300), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = playerState.invincible, color = compose.Color(0xFF00E676), fontSize = compose.TextUnit(11) })
                components.Spacer({ modifier = Modifier.height(2) })
                components.Text({ text = playerState.globalSpeed, color = compose.Color(0xFF00E5FF), fontSize = compose.TextUnit(11) })
            end)
            components.Spacer({ modifier = Modifier.height(4) })
            components.Button({
                shape = compose.Shape(4),
                onClick = function()
                    toggleMonitor("player", startPlayerMonitor, playerState.status, "状态监控")
                end
            }, function(s)
                components.Text({
                    text = "启用/停止状态监控",
                    color = compose.Color(0xFFFFFFFF),
                    fontSize = compose.TextUnit(13),
                })
            end)
        end)
    end)
end

function initAllMonitorStates(scope)
    if not coordinateState.x then
        coordinateState.x      = scope.state("坐标X：0")
        coordinateState.y      = scope.state("坐标Y：0")
        coordinateState.z      = scope.state("坐标Z：0")
        coordinateState.status = scope.state("点击下方按钮启动监控")
    end
    if not marioState.lives then
        marioState.lives           = scope.state("生命：0")
        marioState.health          = scope.state("血量：0")
        marioState.action          = scope.state("动作：0")
        marioState.speed           = scope.state("速度：0")
        marioState.slideSpeed      = scope.state("滑动速度：0")

        marioState.facingDirection  = scope.state("面朝方向：0")
        marioState.facingDirection2 = scope.state("面朝方向2：0")
        marioState.status          = scope.state("点击下方按钮启动监控")
    end
    if not levelState.levelId then
        levelState.levelId    = scope.state("关卡编号：0")
        levelState.stars      = scope.state("星星：0")
        levelState.coins      = scope.state("金币：0")
        levelState.levelName  = scope.state("关卡名字：0")
        levelState.exitScreen = scope.state("退出界面：0")
        levelState.area       = scope.state("区域：0")
        levelState.status     = scope.state("点击下方按钮启动监控")
    end
    if not environmentState.waterLevel then
        environmentState.waterLevel   = scope.state("水面高度：0")
        environmentState.groundHeight = scope.state("地面高度：0")
        environmentState.fallHeight   = scope.state("摔落高度：0")
        environmentState.status       = scope.state("点击下方按钮启动监控")
    end
    if not enemyState.kingBobomb then
        enemyState.kingBobomb = scope.state("炸弹王生命：0")
        enemyState.bowser     = scope.state("库巴生命：0")
        enemyState.status     = scope.state("点击下方按钮启动监控")
    end
    if not playerState.hatStatus then
        playerState.hatStatus  = scope.state("帽子状态：0")
        playerState.frameState = scope.state("帧状态：0")
        playerState.frameTime  = scope.state("帧时间：0")
        playerState.hatTime    = scope.state("帽子时间：0")
        playerState.invincible = scope.state("无敌帧：0")
        playerState.globalSpeed = scope.state("全局加速：0")
        playerState.status     = scope.state("点击下方按钮启动监控")
    end
end

WindowManager_LayoutParams = luajava.bindClass("android.view.WindowManager$LayoutParams")
PixelFormat = luajava.bindClass("android.graphics.PixelFormat")
miniParams = WindowManager_LayoutParams(dpToPx(38), dpToPx(38), getTypePhone(), 8 | 256, PixelFormat.TRANSLUCENT)

window = gg.composeBlurWindow2({
    content = function(scope)
        appScope = scope
        targetState = scope.state(1)
        initAllMonitorStates(scope)
        MonitorManager.initUIStates(scope)

        components.Column({
            modifier = Modifier.fillMaxSize().pointerInput(Gestures)
        }, function(scope)
            topBar(scope)
            _tabBar(scope)
            components.AnimatedContent({
                targetState = targetState,
            }, function(contentScope, index)
                if index == 1 then
                    settingLayout(contentScope)
                elseif index == 2 then
                    coordinateLayout(contentScope)
                elseif index == 3 then
                    marioLayout(contentScope)
                elseif index == 4 then
                    levelLayout(contentScope)
                elseif index == 5 then
                    environmentLayout(contentScope)
                elseif index == 6 then
                    enemyLayout(contentScope)
                elseif index == 7 then
                    playerStateLayout(contentScope)
                end
            end)
        end)
    end,
    canceled = false,
    miniWindow = {
        params = miniParams,
        content = function(scope, w)
            components.AsyncImage({
                modifier = Modifier.fillMaxSize().clip(50).background(0xFF000000)
                    .pointerInput({
                        detectDragGestures = {
                            onDrag = function(x, y)
                                miniParams.x = miniParams.x + x
                                miniParams.y = miniParams.y + y
                                w.updateViewLayout(miniParams)
                            end
                        }
                    })
                    .clickable(function()
                        w.hide()
                        window.show()
                    end),
                model = "https://q.qlogo.cn/headimg_dl?dst_uin=1062620173&spec=640&img_type=jpg"
            })
        end
    }
})