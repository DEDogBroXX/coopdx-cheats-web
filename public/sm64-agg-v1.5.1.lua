-- basicLua

gg.setProcessInfo("超级马力欧64CoopDX")

START_TIME      = os.date("%Y-%m-%d %H:%M:%S")

function timeStr() return os.date("%Y-%m-%d %H:%M:%S") end
function T(msg) gg.toast(msg) end

function parseNum(s)
    if s == nil then return nil end
    if type(s) == "number" then return s end
    return tonumber(tostring(s))
end

local function wrapWord(v)
    if type(v) ~= "number" then return 0 end
    if v ~= v then return 0 end
    v = math.floor(v)
    v = v % 65536
    if v > 32767 then v = v - 65536 end
    return v
end

local _bssStart, _bssEnd = nil, nil

local function getBssRange()
    if _bssStart then return _bssStart, _bssEnd end
    local ok, ranges = pcall(gg.getRangesList)
    if not ok or not ranges then return nil end
    for _, r in ipairs(ranges) do
        local name  = tostring(r.name or "")
        local iname = tostring(r.internalName or "")
        if string.find(name, "base.apk:bss", 1, true) or string.find(iname, "base.apk:bss", 1, true) then
            _bssStart = r.start; _bssEnd = r["end"]; return _bssStart, _bssEnd
        end
    end
    for _, r in ipairs(ranges) do
        local name  = tostring(r.name or "")
        local iname = tostring(r.internalName or "")
        if string.find(name, "bss", 1, true) or string.find(iname, "bss", 1, true) then
            _bssStart = r.start; _bssEnd = r["end"]; return _bssStart, _bssEnd
        end
    end
    return nil
end

function findBssAddr(offset)
    local start, finish = getBssRange()
    if not start then return nil end
    local c = start + offset
    if c >= start and c < finish then return c end
    return nil
end

function readVal(addr, flag)
    if not addr then return 0 end
    local ok, v = pcall(gg.getValues, {{address = addr, flags = flag}})
    if ok and v and v[1] then return v[1].value end
    return 0
end

function readPointer(addr)
    if not addr then return nil end
    local ok, v = pcall(gg.getValues, {{address = addr, flags = gg.TYPE_QWORD}})
    if ok and v and v[1] then
        local p = tonumber(v[1].value) or 0
        if p ~= 0 then return p end
    end
    ok, v = pcall(gg.getValues, {{address = addr, flags = gg.TYPE_DWORD}})
    if ok and v and v[1] then
        return tonumber(v[1].value) or 0
    end
    return 0
end

function writeVal(addr, flag, value, freeze, name)
    if not addr then return end
    pcall(gg.setValues, {{address = addr, flags = flag, value = value, freeze = freeze == true}})
    if freeze and name then
        local rm = {}
        for _, item in ipairs(gg.getListItems() or {}) do
            if item.name == name then table.insert(rm, item) end
        end
        if #rm > 0 then pcall(gg.removeListItems, rm) end
        pcall(gg.addListItems, {{address = addr, flags = flag, value = value, freeze = true, name = name}})
    end
end

function clearLock(name)
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        if item.name == name then table.insert(rm, item) end
    end
    if #rm > 0 then pcall(gg.removeListItems, rm) end
end

function hasLock(name)
    for _, item in ipairs(gg.getListItems() or {}) do
        if item.name == name then return true end
    end
    return false
end

function clearAllLocks()
    local items = gg.getListItems()
    if items and #items > 0 then
        gg.removeListItems(items)
        T("✅ 已关闭所有锁定（" .. #items .. " 项）")
    else
        T("当前没有锁定项")
    end
end

MARIO_STATE_OFFSET = 0x62AD0

PLAYER_BASE   = 0x62c94
PLAYER_STRIDE = 0x160
PLAYER_MAX    = 15

roomPlayerCount = 15

MY_X, MY_Y, MY_Z = 0x62b34, 0x62b38, 0x62b3c

ROOF_HEIGHT  = 100
ROOFFIX_NAME = "rooffix_head"
SINGLE_ROOF_NAME = "single_roof_freeze"
singleRoofIdx = 0

EXIT_UI_BASE_OFFSET  = 0x49ee2ce
EXIT_UI_STRIDE       = 0x7FC
EXIT_UI_PLAYER_COUNT = 15

followRunning  = false
followTarget   = 0
loopFollowMode = true
killLoopFollowMode = true
followKillMode = false

loopFollowDuration = 0
loopFollowTickMs   = 0
loopFollowDoubleWrite = true

killLoopFollowDuration = 0
killLoopFollowTickMs   = 0
killLoopFollowDoubleWrite = true

singleFollowDuration = 0
singleFollowTickMs   = 0
singleFollowDoubleWrite = true

HAT_TIME_OFFSET   = 0x62AE4
HAT_TIME_VALUE    = 9178
HAT_TIME_NAME     = "无限帽子时间"
INVINCIBLE_OFFSET = 0x62AE6
INVINCIBLE_VALUE  = 9178
INVINCIBLE_NAME   = "永久无敌"
PARTICLE_OFFSET = 0x62BBC
PARTICLE_VALUE  = 4294967295
PARTICLE_NAME   = "所有粒子特效"

CHAR_NAME_OFFSET   = 0x496b1ec
CHAR_SWITCH_OFFSET = 0x49edc58

CHAR_NAME_LOCK     = "角色_名字"
CHAR_SWITCH_LOCK   = "角色_切换"

charLoopOn     = false
charLoopIndex  = 0
charLoopTickMs = 200
charLoopDoubleWrite = true

COLOR_OFFSETS_RAW = [[
677f8
677f9
677fa
677fc
677fd
677fe
67810
67811
67812
67814
67815
67816
67828
67829
6782a
6782c
6782d
6782e
67840
67841
67842
67844
67845
67846
67858
67859
6785a
6785c
6785d
6785e
67870
67871
67872
67874
67875
67876
67888
67889
6788a
6788c
6788d
6788e
678a0
678a1
678a2
678a4
678a5
678a6
49b2760
49b2761
49b2762
49b2764
49b2765
49b2766
49b2774
49b2775
49b2776
49b2778
49b2779
49b277a
49b277c
49b277d
49b277e
49b278c
49b278d
49b278e
49b2790
49b2791
49b2792
49b2794
49b2795
49b2796
49b27a4
49b27a5
49b27a6
49b27a8
49b27a9
49b27aa
49b27ac
49b27ad
49b27ae
49b27bc
49b27bd
49b27be
49b27c0
49b27c1
49b27c2
49b27c4
49b27c5
49b27c6
49b27d4
49b27d5
49b27d6
49b27d8
49b27d9
49b27da
49b27dc
49b27dd
49b27de
49b27ec
49b27ed
49b27ee
49b27f0
49b27f1
49b27f2
49b27f4
49b27f5
49b27f6
49b2804
49b2805
49b2806
49b2808
49b2809
49b280a
49b280c
49b280d
49b280e
49b281c
49b281d
49b281e
49b7be8
49b7bec
49b7bf0
49edae8
49edae9
49edaea
49edaeb
49edaec
49edaed
49edaee
49edaef
49edaf0
49edaf1
49edaf2
49edaf3
49edaf4
49edaf5
49edaf6
49edaf7
49edaf8
49edaf9
49edafa
49edafb
49edafc
49edafd
49edafe
49edaff
49edc59
49edc5a
49edc5b
49edc5c
49edc5d
49edc5e
49edc5f
49edc60
49edc61
49edc62
49edc63
49edc64
49edc65
49edc66
49edc67
49edc68
49edc69
49edc6a
49edc6b
49edc6c
49edc6d
49edc6e
49edc6f
49edc70
]]

COLOR_OFFSETS = {}
for line in COLOR_OFFSETS_RAW:gmatch("[^\r\n]+") do
    local hex = line:match("^%s*([0-9a-fA-F]+)")
    if hex then
        table.insert(COLOR_OFFSETS, tonumber(hex, 16))
    end
end

colorRandomLoopOn = false
colorSameLoopOn   = false
colorRandomTickMs = 200
colorSameTickMs   = 200
colorRandomDoubleWrite = true
colorSameDoubleWrite   = true
colorSameValue    = 0

ACTION_VALUE  = 8390825
ACTION_OFFSET = 0x62afc
ACTION_NAME   = "马里奥动作锁定"
WATER_ACTION_VALUE  = 805315809
WATER_ACTION_NAME   = "水中动作锁定"
FRAME_VALUE   = 1
FRAME_OFFSET  = 0x62b0a
FRAME_NAME    = "帧状态锁定"
INFHP_OFFSET  = 0x62ADB
INFHP_VALUE   = 8
INFHP_NAME    = "无限血量"
INFLIFE_OFFSET = 0x62AD8
INFLIFE_VALUE = 99
INFLIFE_NAME  = "无限生命"
NOFALL_OFFSET = 0x62B64
NOFALL_VALUE  = -3.4e38
NOFALL_NAME   = "无坠落伤害"

CUSTOM_LOCK_NAMES = {
    "自定义_坐标X", "自定义_坐标Y", "自定义_坐标Z",
    "自定义_马里奥血量", "自定义_马里奥生命", "自定义_马里奥动作",
    "自定义_速度", "自定义_滑动速度",
    "自定义_面朝方向", "自定义_面朝方向2",
    "自定义_帽子时间", "自定义_无敌帧",
    "自定义_关卡编号", "自定义_关卡名字", "自定义_退出界面",
    "自定义_星星", "自定义_金币",
    "自定义_水面高度", "自定义_地面高度", "自定义_摔落高度",
    "自定义_炸弹王生命", "自定义_库巴生命",
    "自定义_帧状态", "自定义_帧时间", "自定义_帽子状态", "自定义_区域",
    "自定义_全局加速",
}

GENERAL_LOCK_NAMES = {
    "通用_金币", "通用_马里奥生命", "通用_速度",
    "通用_库巴生命", "通用_炸弹王生命",
    "通用_无限血量", "通用_无坠落伤害",
    "通用_钢铁状态", "通用_飞行状态", "通用_隐身状态",
    "通用_棍母状态", "通用_三帽合一", "通用_重置所有状态",
    "通用_永久无敌", "通用_无限帽子时间","通用_所有粒子特效",
}

local function getCurrentSleepMs()
    local intervals = {}
    for _, k in ipairs(FACE_ROTATE_KEYS) do
        local r = FACE_ROTATE[k]
        if r.on and r.tickMs then
            table.insert(intervals, r.tickMs)
        end
    end
    if followRunning then
        if followKillMode then
            table.insert(intervals, killLoopFollowTickMs)
        elseif loopFollowMode then
            table.insert(intervals, loopFollowTickMs)
        else
            table.insert(intervals, singleFollowTickMs)
        end
    end
    if charLoopOn then table.insert(intervals, charLoopTickMs) end
    if colorRandomLoopOn then table.insert(intervals, colorRandomTickMs) end
    if colorSameLoopOn then table.insert(intervals, colorSameTickMs) end
    if #intervals == 0 then return 8 end
    local min = intervals[1]
    for _, v in ipairs(intervals) do
        if v < min then min = v end
    end
    return math.floor(min)
end

function getSelfXYZ()
    local ax = findBssAddr(MY_X)
    local ay = findBssAddr(MY_Y)
    local az = findBssAddr(MY_Z)
    if not ax or not ay or not az then return nil end
    local ok, v = pcall(gg.getValues, {
        {address = ax, flags = gg.TYPE_FLOAT},
        {address = ay, flags = gg.TYPE_FLOAT},
        {address = az, flags = gg.TYPE_FLOAT},
    })
    if not ok or not v or #v < 3 then return nil end
    return tonumber(v[1].value) or 0, tonumber(v[2].value) or 0, tonumber(v[3].value) or 0
end

function getPlayerCoords(i)
    if type(i) ~= "number" or i < 1 or i > PLAYER_MAX then return nil end
    local base = PLAYER_BASE + (i - 1) * PLAYER_STRIDE
    local ax = findBssAddr(base); local ay = findBssAddr(base + 4); local az = findBssAddr(base + 8)
    if not ax or not ay or not az then return nil end
    local ok, v = pcall(gg.getValues, {
        {address = ax, flags = gg.TYPE_FLOAT},
        {address = ay, flags = gg.TYPE_FLOAT},
        {address = az, flags = gg.TYPE_FLOAT},
    })
    if not ok or not v or #v < 3 then return nil end
    return { ax = ax, ay = ay, az = az,
             x = tonumber(v[1].value) or 0, y = tonumber(v[2].value) or 0, z = tonumber(v[3].value) or 0 }
end

function isPlayerActive(i)
    local c = getPlayerCoords(i)
    if not c then return false end
    return not (c.x == 0 and c.y == 0 and c.z == 0)
end

function findNextActivePlayer(from)
    local n = roomPlayerCount
    if n <= 0 then return 0 end
    if n > PLAYER_MAX then n = PLAYER_MAX end
    for step = 1, n do
        local idx = ((from - 1 + step) % n) + 1
        if isPlayerActive(idx) then return idx end
    end
    return 0
end

KILL_HP_OFFSETS = {
    0x62C3B, 0x62D9B, 0x62EFB, 0x6305B, 0x631BB,
    0x6331B, 0x6347B, 0x635DB, 0x6373B, 0x6389B,
    0x639FB, 0x63B5B, 0x63CBB, 0x63E1B, 0x63F7B,
}

function getKillTargetHP(idx)
    local off = KILL_HP_OFFSETS[idx]
    if not off then return nil end
    local addr = findBssAddr(off)
    if not addr then return nil end
    local v = readVal(addr, gg.TYPE_BYTE)
    if type(v) == "number" then return v end
    return nil
end

function findNextKillTarget(from)
    local n = roomPlayerCount
    if n <= 0 then return 0 end
    if n > PLAYER_MAX then n = PLAYER_MAX end
    for step = 1, n do
        local idx = ((from - 1 + step) % n) + 1
        if isPlayerActive(idx) then
            local hp = getKillTargetHP(idx)
            if hp and hp > 0 then return idx end
        end
    end
    return 0
end

function startKillLoopFollow()
    if followRunning then stopFollow() end
    followKillMode = true
    followRunning = true
    followTarget = findNextKillTarget(0)
    if followTarget == 0 then followTarget = 1 end
    ensureMainThread()
    T("▶️ 轮杀跟随已启动")
end

function getExitUIAddr(playerIdx)
    if type(playerIdx) ~= "number" then return nil end
    if playerIdx < 1 or playerIdx > EXIT_UI_PLAYER_COUNT then return nil end
    local offset = EXIT_UI_BASE_OFFSET + (playerIdx - 1) * EXIT_UI_STRIDE
    return findBssAddr(offset)
end

function readExitUI(playerIdx)
    local addr = getExitUIAddr(playerIdx)
    if not addr then return nil end
    local v = readVal(addr, gg.TYPE_BYTE)
    if type(v) ~= "number" then return nil end
    if v > 127 then v = v - 256 end
    return v
end

function viewAllExitUI()
    local lines = {}
    for i = 1, EXIT_UI_PLAYER_COUNT do
        local v = readExitUI(i)
        if v == nil then
            table.insert(lines, string.format("P%d: 读取失败", i))
        else
            table.insert(lines, string.format("P%d: %d", i, v))
        end
    end
    gg.alert("当前所有玩家退出界面数值（不含自己）：\n\n" .. table.concat(lines, "\n"))
end

function batchEditExitUI()
    local res = gg.prompt(
        {"退出界面数值（BYTE 类型，范围 -128 ~ 255）", "锁定"},
        {"0", false},
        {"text", "checkbox"}
    )
    if res == nil then return end
    if res[1] == nil or res[1] == "" then T("❌ 请输入数值"); return end
    local n = parseNum(res[1])
    if n == nil then T("❌ 数字无效"); return end
    n = math.floor(n)
    if n < -128 or n > 255 then T("❌ 范围应为 -128 ~ 255"); return end
    local storeVal = n
    if storeVal > 127 then storeVal = storeVal - 256 end

    local freeze = res[2] == true
    clearLock("批量_退出界面")

    local items = {}
    for i = 1, EXIT_UI_PLAYER_COUNT do
        local addr = getExitUIAddr(i)
        if addr then
            items[#items+1] = {
                address = addr, flags = gg.TYPE_BYTE, value = storeVal,
                freeze = freeze, name = "批量_退出界面",
            }
        end
    end
    if #items == 0 then T("❌ 找不到地址"); return end
    pcall(gg.setValues, items)
    if freeze then pcall(gg.addListItems, items) end
    T(string.format("✅ 已修改全部玩家退出界面为 %d%s", n, freeze and "（锁定）" or ""))
end

function editSingleExitUI()
    while true do
        local choices = {}
        for i = 1, EXIT_UI_PLAYER_COUNT do
            local v = readExitUI(i)
            if v == nil then
                table.insert(choices, string.format("❓ P%d：读取失败", i))
            else
                table.insert(choices, string.format("P%d  当前：%d", i, v))
            end
        end
        table.insert(choices, "❌ 返回")
        local backIdx = #choices

        local res = gg.choice(choices, nil, "🎯 单个玩家修改退出界面（不含自己）")
        if res == nil or res == backIdx then return end

        local playerIdx = res
        local r2 = gg.prompt(
            {string.format("P%d 退出界面数值（BYTE 类型，-128 ~ 255）", playerIdx), "锁定"},
            {"0", false}, {"text", "checkbox"}
        )
        if r2 == nil then
        elseif r2[1] == nil or r2[1] == "" then
            T("❌ 请输入数值")
        else
            local n = parseNum(r2[1])
            if n == nil then
                T("❌ 数字无效")
            else
                n = math.floor(n)
                if n < -128 or n > 255 then
                    T("❌ 范围应为 -128 ~ 255")
                else
                    local storeVal = n
                    if storeVal > 127 then storeVal = storeVal - 256 end
                    local freeze = r2[2] == true
                    local addr = getExitUIAddr(playerIdx)
                    if addr then
                        local name = "单个_退出界面_" .. playerIdx
                        clearLock(name)
                        writeVal(addr, gg.TYPE_BYTE, storeVal, freeze, name)
                        T(string.format("✅ P%d 已修改为 %d%s", playerIdx, n, freeze and "（锁定）" or ""))
                    else
                        T("❌ 找不到地址")
                    end
                end
            end
        end
    end
end

function clearExitUILocks()
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        local n = tostring(item.name or "")
        if n == "批量_退出界面" or string.find(n, "单个_退出界面_", 1, true) then
            table.insert(rm, item)
        end
    end
    if #rm > 0 then
        pcall(gg.removeListItems, rm)
        T("🧹 已清理 " .. #rm .. " 个退出界面锁定")
    else
        T("✅ 没有退出界面锁定")
    end
end

function startRoofFreeze()
    stopRoofFreeze()
    local sx, sy, sz = getSelfXYZ()
    if not sx then T("❌ 找不到自己坐标"); return end
    local targetY = sy + ROOF_HEIGHT
    local items = {}
    local n = roomPlayerCount
    if n > PLAYER_MAX then n = PLAYER_MAX end
    for i = 1, n do
        local base = PLAYER_BASE + (i - 1) * PLAYER_STRIDE
        local ax = findBssAddr(base); local ay = findBssAddr(base + 4); local az = findBssAddr(base + 8)
        if ax and ay and az then
            items[#items+1] = {address = ax, flags = gg.TYPE_FLOAT, value = sx,      freeze = true, name = ROOFFIX_NAME}
            items[#items+1] = {address = ay, flags = gg.TYPE_FLOAT, value = targetY, freeze = true, name = ROOFFIX_NAME}
            items[#items+1] = {address = az, flags = gg.TYPE_FLOAT, value = sz,      freeze = true, name = ROOFFIX_NAME}
        end
    end
    if #items == 0 then T("❌ 找不到玩家地址（游戏未启动？）"); return end
    pcall(gg.addListItems, items)
    T(string.format("❄️ 已冻结所有人头顶 (%.1f, %.1f, %.1f)", sx, targetY, sz))
end

function stopRoofFreeze() clearLock(ROOFFIX_NAME) end

function toggleRoofFreeze()
    if hasLock(ROOFFIX_NAME) then stopRoofFreeze(); T("⏹️ 解除")
    else startRoofFreeze() end
end

function freezeSingleToRoof(idx)
    if type(idx) ~= "number" or idx < 1 or idx > PLAYER_MAX then T("❌ 玩家编号无效"); return end
    stopSingleRoofFreeze()
    local sx, sy, sz = getSelfXYZ()
    if not sx then T("❌ 找不到自己坐标"); return end
    local targetY = sy + ROOF_HEIGHT
    local base = PLAYER_BASE + (idx - 1) * PLAYER_STRIDE
    local ax = findBssAddr(base); local ay = findBssAddr(base + 4); local az = findBssAddr(base + 8)
    if not (ax and ay and az) then T("❌ 找不到玩家地址"); return end
    pcall(gg.addListItems, {
        {address = ax, flags = gg.TYPE_FLOAT, value = sx,      freeze = true, name = SINGLE_ROOF_NAME},
        {address = ay, flags = gg.TYPE_FLOAT, value = targetY, freeze = true, name = SINGLE_ROOF_NAME},
        {address = az, flags = gg.TYPE_FLOAT, value = sz,      freeze = true, name = SINGLE_ROOF_NAME},
    })
    singleRoofIdx = idx
    T(string.format("❄️ 玩家 %d 已冻结", idx))
end

function stopSingleRoofFreeze()
    local had = hasLock(SINGLE_ROOF_NAME)
    clearLock(SINGLE_ROOF_NAME)
    singleRoofIdx = 0
    return had
end

function openSingleRoofFreezeMenu()
    while true do
        local choices = {}
        local mx, my, mz = getSelfXYZ()
        local meTxt = "❓ 坐标未知"
        if mx then meTxt = string.format("自己 %.1f,%.1f,%.1f", mx, my, mz) end
        for i = 1, roomPlayerCount do
            local c = getPlayerCoords(i)
            if c then
                local active = not (c.x == 0 and c.y == 0 and c.z == 0)
                local mark = active and "🟢" or "⚫"
                local frozen = (singleRoofIdx == i) and " ❄️" or ""
                if not active then table.insert(choices, string.format("⚫ 玩家 %d 离线", i))
                else table.insert(choices, string.format("%s 玩家 %d (%.1f,%.1f,%.1f)%s", mark, i, c.x, c.y, c.z, frozen)) end
            else table.insert(choices, string.format("❓ 玩家 %d 读取失败", i)) end
        end
        local statusTxt = singleRoofIdx > 0 and ("冻结 玩家 " .. singleRoofIdx) or "无冻结"
        table.insert(choices, "🔄 刷新")
        table.insert(choices, "❄️ 解除冻结")
        table.insert(choices, "❌ 返回")
        local refreshIdx = #choices - 2; local unfreezeIdx = #choices - 1; local backIdx = #choices
        local res = gg.choice(choices, nil, "❄️ 单个玩家冻结 | " .. meTxt .. " | " .. statusTxt)
        if res == nil or res == backIdx then return end
        if res == refreshIdx then
        elseif res == unfreezeIdx then
            if stopSingleRoofFreeze() then T("⏹️ 已解除") else T("⚠️ 无冻结") end
        elseif res >= 1 and res <= roomPlayerCount then
            local i = res
            if singleRoofIdx == i then stopSingleRoofFreeze(); T("⏹️ 已解除")
            else
                if not isPlayerActive(i) then T("⚠️ 玩家 " .. i .. " 不在线")
                else freezeSingleToRoof(i) end
            end
        end
    end
end

function setRoofHeight()
    local r = gg.prompt({"头顶高度（默认 100）\n当前：" .. ROOF_HEIGHT}, {tostring(ROOF_HEIGHT)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n then ROOF_HEIGHT = n; T("✅ 已设为 " .. n) else T("❌ 数字无效") end
    end
end

FACE_FEATURES = {
    { key = "orig",  displayName = "面朝方向",  offset = 0x62b6c,  addrLabel = "0x62b6c"  },
    { key = "orig2", displayName = "面朝方向2", offset = 0x62b72,  addrLabel = "0x62b72"  },
}

FACE_ROTATE_KEYS = {"orig", "orig2"}

FACE_ROTATE = {
    orig  = { on = false, current = -32768, min = -32768, max = 32767, step = 10000, tickMs = 0 },
    orig2 = { on = false, current = -32768, min = -32768, max = 32767, step = 10000, tickMs = 0 },
}

mainThreadRunning = false

function hasAnyFaceRotating()
    for _, k in ipairs(FACE_ROTATE_KEYS) do
        if FACE_ROTATE[k].on then return true end
    end
    return false
end

function clearAllFaceLocks()
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        local n = tostring(item.name or "")
        if string.find(n, "face_rotate_", 1, true) or
           string.find(n, "_face_loop", 1, true) or
           string.find(n, "_face_test", 1, true) then
            table.insert(rm, item)
        end
    end
    if #rm > 0 then
        pcall(gg.removeListItems, rm)
        T("🧹 已清理 " .. #rm .. " 个面朝残留")
    else
        T("✅ 没有面朝残留")
    end
end

function ensureMainThread()
    if mainThreadRunning then return end
    mainThreadRunning = true

    local Thread = luajava.bindClass("java.lang.Thread")
    local ok, proxy = pcall(function()
        return luajava.createProxy("java.lang.Runnable", {
            run = function()
                local myX = findBssAddr(MY_X)
                local myY = findBssAddr(MY_Y)
                local myZ = findBssAddr(MY_Z)

                local pAddr = {}
                for i = 1, PLAYER_MAX do
                    local base = PLAYER_BASE + (i - 1) * PLAYER_STRIDE
                    pAddr[i] = {
                        x = findBssAddr(base),
                        y = findBssAddr(base + 4),
                        z = findBssAddr(base + 8),
                    }
                end

                local faceAddr = {}
                for _, k in ipairs(FACE_ROTATE_KEYS) do
                    for _, f in ipairs(FACE_FEATURES) do
                        if f.key == k then faceAddr[k] = findBssAddr(f.offset); break end
                    end
                end

                local charNameAddr   = findBssAddr(CHAR_NAME_OFFSET)
                local charSwitchAddr = findBssAddr(CHAR_SWITCH_OFFSET)

                local colorAddrs = {}
                for _, off in ipairs(COLOR_OFFSETS) do
                    local a = findBssAddr(off)
                    if a then table.insert(colorAddrs, a) end
                end

                local elapsed     = 0
                local charElapsed = 0
                local colorRandomElapsed = 0
                local colorSameElapsed = 0
                local lastItems = {}

                while followRunning or hasAnyFaceRotating() or charLoopOn or colorRandomLoopOn or colorSameLoopOn do
                    if followRunning and followTarget == 0 then
                        if followKillMode then
                            followTarget = findNextKillTarget(0)
                        else
                            followTarget = findNextActivePlayer(0)
                        end
                        if followTarget == 0 then
                            gg.sleep(200); elapsed = 0
                        end
                    end

                    local writes = {}
                    local newItems = {}

                    if followRunning and followTarget > 0 and followTarget <= roomPlayerCount then
                        local skipMove = false
                        local currentDoubleWrite = false
                        local currentDuration = 0
                        local currentStepMs = 0

                        if followKillMode then
                            currentDoubleWrite = killLoopFollowDoubleWrite
                            currentDuration = killLoopFollowDuration
                            currentStepMs = killLoopFollowTickMs
                        elseif loopFollowMode then
                            currentDoubleWrite = loopFollowDoubleWrite
                            currentDuration = loopFollowDuration
                            currentStepMs = loopFollowTickMs
                        else
                            currentDoubleWrite = singleFollowDoubleWrite
                            currentDuration = singleFollowDuration
                            currentStepMs = singleFollowTickMs
                        end

                        if followKillMode then
                            local hp = getKillTargetHP(followTarget)
                            if hp == nil or hp <= 0 then
                                if killLoopFollowMode then
                                    local nextTarget = findNextKillTarget(followTarget)
                                    if nextTarget == 0 then
                                        followTarget = 0
                                    else
                                        followTarget = nextTarget
                                    end
                                    elapsed = 0
                                    skipMove = true
                                end
                            end
                        end

                        if not skipMove then
                            local t = pAddr[followTarget]
                            if t and t.x and t.y and t.z and myX and myY and myZ then
                                local ok2, vals = pcall(gg.getValues, {
                                    {address = t.x, flags = gg.TYPE_FLOAT},
                                    {address = t.y, flags = gg.TYPE_FLOAT},
                                    {address = t.z, flags = gg.TYPE_FLOAT},
                                })
                                if ok2 and vals and #vals >= 3 then
                                    local px = tonumber(vals[1].value) or 0
                                    local py = tonumber(vals[2].value) or 0
                                    local pz = tonumber(vals[3].value) or 0
                                    writes[#writes+1] = {address = myX, flags = gg.TYPE_FLOAT, value = px}
                                    writes[#writes+1] = {address = myY, flags = gg.TYPE_FLOAT, value = py}
                                    writes[#writes+1] = {address = myZ, flags = gg.TYPE_FLOAT, value = pz}
                                    if currentDoubleWrite then
                                        writes[#writes+1] = {address = myX, flags = gg.TYPE_FLOAT, value = px}
                                        writes[#writes+1] = {address = myY, flags = gg.TYPE_FLOAT, value = py}
                                        writes[#writes+1] = {address = myZ, flags = gg.TYPE_FLOAT, value = pz}
                                    end
                                end
                            end
                        end

                        if loopFollowMode and not followKillMode then
                            elapsed = elapsed + currentStepMs
                            if elapsed >= currentDuration then
                                elapsed = 0
                                followTarget = findNextActivePlayer(followTarget)
                            end
                        end
                    end

                    for _, k in ipairs(FACE_ROTATE_KEYS) do
                        local r = FACE_ROTATE[k]
                        if r.on and faceAddr[k] then
                            r.current = r.current + r.step
                            if r.current > r.max then r.current = r.min end
                            local wv = wrapWord(r.current)
                            writes[#writes+1] = {address = faceAddr[k], flags = gg.TYPE_WORD, value = wv}
                            newItems[#newItems+1] = {
                                address = faceAddr[k], flags = gg.TYPE_WORD,
                                value = wv, freeze = true, name = "face_rotate_" .. k,
                            }
                        end
                    end

                    if charLoopOn and charNameAddr and charSwitchAddr then
                        charElapsed = charElapsed + getCurrentSleepMs()
                        if charElapsed >= charLoopTickMs then
                            charElapsed = 0
                            charLoopIndex = (charLoopIndex + 1) % 5
                            writes[#writes+1] = {address = charNameAddr,   flags = gg.TYPE_DWORD, value = charLoopIndex}
                            writes[#writes+1] = {address = charSwitchAddr, flags = gg.TYPE_BYTE,  value = charLoopIndex}
                            if charLoopDoubleWrite then
                                writes[#writes+1] = {address = charNameAddr,   flags = gg.TYPE_DWORD, value = charLoopIndex}
                                writes[#writes+1] = {address = charSwitchAddr, flags = gg.TYPE_BYTE,  value = charLoopIndex}
                            end
                        end
                    end

                    if colorRandomLoopOn and #colorAddrs > 0 then
                        colorRandomElapsed = colorRandomElapsed + getCurrentSleepMs()
                        if colorRandomElapsed >= colorRandomTickMs then
                            colorRandomElapsed = 0
                            for _, a in ipairs(colorAddrs) do
                                local v = math.random(0, 255)
                                writes[#writes+1] = { address = a, flags = gg.TYPE_BYTE, value = v }
                                if colorRandomDoubleWrite then
                                    writes[#writes+1] = { address = a, flags = gg.TYPE_BYTE, value = v }
                                end
                            end
                        end
                    end

                    if colorSameLoopOn and #colorAddrs > 0 then
                        colorSameElapsed = colorSameElapsed + getCurrentSleepMs()
                        if colorSameElapsed >= colorSameTickMs then
                            colorSameElapsed = 0
                            colorSameValue = math.random(0, 255)
                            for _, a in ipairs(colorAddrs) do
                                writes[#writes+1] = { address = a, flags = gg.TYPE_BYTE, value = colorSameValue }
                                if colorSameDoubleWrite then
                                    writes[#writes+1] = { address = a, flags = gg.TYPE_BYTE, value = colorSameValue }
                                end
                            end
                        end
                    end

                    if #writes > 0 then pcall(gg.setValues, writes) end
                    if #lastItems > 0 then pcall(gg.removeListItems, lastItems) end
                    if #newItems > 0 then pcall(gg.addListItems, newItems) end
                    lastItems = newItems

                    gg.sleep(getCurrentSleepMs())
                end

                if #lastItems > 0 then pcall(gg.removeListItems, lastItems) end
                mainThreadRunning = false
            end
        })
    end)

    if not ok then
        mainThreadRunning = false
        T("启动主线程失败：" .. tostring(proxy))
        return
    end

    local th = Thread(proxy)
    th:start()
end

function startFollowThread()
    if followRunning then return end
    followKillMode = false
    followRunning = true
    if followTarget == 0 then followTarget = findNextActivePlayer(0) end
    ensureMainThread()
    T("▶️ 跟随已启动")
end

function stopFollow()
    followRunning = false
    followTarget  = 0
    followKillMode = false
end

function formatDuration(ms)
    if ms < 1000 then return ms .. "ms" end
    local s = ms / 1000
    if s < 60 then return string.format("%.2f秒", s) end
    local m = s / 60
    if m < 60 then return string.format("%.2f分", m) end
    local h = m / 60
    if h < 24 then return string.format("%.2f时", h) end
    return string.format("%.2f天", h / 24)
end

function setLoopFollowTickMs()
    local r = gg.prompt({"循环跟随主间隔（毫秒）\n当前：" .. loopFollowTickMs .. "ms"},
        {tostring(loopFollowTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        loopFollowTickMs = math.floor(n)
        T("✅ 循环跟随间隔已设为 " .. loopFollowTickMs .. "ms")
    end
end

function setKillLoopFollowTickMs()
    local r = gg.prompt({"轮杀跟随主间隔（毫秒）\n当前：" .. killLoopFollowTickMs .. "ms"},
        {tostring(killLoopFollowTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        killLoopFollowTickMs = math.floor(n)
        T("✅ 轮杀跟随间隔已设为 " .. killLoopFollowTickMs .. "ms")
    end
end

function setSingleFollowTickMs()
    local r = gg.prompt({"单人跟随主间隔（毫秒）\n当前：" .. singleFollowTickMs .. "ms"},
        {tostring(singleFollowTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        singleFollowTickMs = math.floor(n)
        T("✅ 单人跟随间隔已设为 " .. singleFollowTickMs .. "ms")
    end
end

function setFaceRotateTickMs(key)
    local r = FACE_ROTATE[key]
    if not r then return end
    local res = gg.prompt({"旋转主间隔（毫秒）\n当前：" .. r.tickMs .. "ms"},
        {tostring(r.tickMs)}, {"text"})
    if res and res[1] and res[1] ~= "" then
        local n = parseNum(res[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        r.tickMs = math.floor(n)
        T("✅ 间隔已设为 " .. r.tickMs .. "ms")
    end
end

function toggleLoopDoubleWrite()
    loopFollowDoubleWrite = not loopFollowDoubleWrite
    T(loopFollowDoubleWrite and "✅ 循环跟随双写模式" or "✅ 循环跟随单写模式")
end

function toggleKillLoopDoubleWrite()
    killLoopFollowDoubleWrite = not killLoopFollowDoubleWrite
    T(killLoopFollowDoubleWrite and "✅ 轮杀跟随双写模式" or "✅ 轮杀跟随单写模式")
end

function toggleSingleDoubleWrite()
    singleFollowDoubleWrite = not singleFollowDoubleWrite
    T(singleFollowDoubleWrite and "✅ 单人跟随双写模式" or "✅ 单人跟随单写模式")
end

function teleportToPlayer(idx)
    local c = getPlayerCoords(idx)
    if not c then T("❌ 读不到玩家 " .. idx .. " 坐标") return end
    if c.x == 0 and c.y == 0 and c.z == 0 then T("⚠️ 玩家 " .. idx .. " 不在线"); return end
    local myX = findBssAddr(MY_X); local myY = findBssAddr(MY_Y); local myZ = findBssAddr(MY_Z)
    if not (myX and myY and myZ) then T("❌ 找不到自己坐标地址"); return end
    pcall(gg.setValues, {
        {address = myX, flags = gg.TYPE_FLOAT, value = c.x},
        {address = myY, flags = gg.TYPE_FLOAT, value = c.y},
        {address = myZ, flags = gg.TYPE_FLOAT, value = c.z},
    })
    T(string.format("🎯 传送到玩家 %d", idx))
end

function openTeleportMenu()
    while true do
        local choices = {}
        local mx, my, mz = getSelfXYZ()
        local meTxt = "坐标未知"
        if mx then meTxt = string.format("自己 %.1f,%.1f,%.1f", mx, my, mz) end
        for i = 1, roomPlayerCount do
            local c = getPlayerCoords(i)
            if c then
                if c.x == 0 and c.y == 0 and c.z == 0 then table.insert(choices, string.format("⚫ 玩家 %d 离线", i))
                else table.insert(choices, string.format("🟢 玩家 %d (%.1f,%.1f,%.1f)", i, c.x, c.y, c.z)) end
            else table.insert(choices, string.format("❓ 玩家 %d 读取失败", i)) end
        end
        table.insert(choices, "🔄 刷新"); table.insert(choices, "❌ 返回")
        local refreshIdx = #choices - 1; local backIdx = #choices
        local res = gg.choice(choices, nil, "🎯 传送 | " .. meTxt)
        if res == nil or res == backIdx then return end
        if res == refreshIdx then
        elseif res >= 1 and res <= roomPlayerCount then teleportToPlayer(res) end
    end
end

function lockOne(offset, flag, value, name)
    local addr = findBssAddr(offset)
    if not addr then return false end
    clearLock(name)
    pcall(gg.setValues, {{address = addr, flags = flag, value = value}})
    pcall(gg.addListItems, {{address = addr, flags = flag, value = value, freeze = true, name = name}})
    return true
end

function oneClickOpenAll()
    if hasLock(INFHP_NAME) or hasLock(ACTION_NAME) then
        clearLock(INFHP_NAME); clearLock(INFLIFE_NAME); clearLock(NOFALL_NAME)
        clearLock(ACTION_NAME); clearLock(FRAME_NAME); clearLock(WATER_ACTION_NAME)
        T("✅ 已关闭全部锁定")
    else
        local ok1 = lockOne(INFHP_OFFSET,   gg.TYPE_BYTE,  INFHP_VALUE,   INFHP_NAME)
        local ok2 = lockOne(INFLIFE_OFFSET, gg.TYPE_BYTE,  INFLIFE_VALUE, INFLIFE_NAME)
        local ok3 = lockOne(NOFALL_OFFSET,  gg.TYPE_FLOAT, NOFALL_VALUE,  NOFALL_NAME)
        local ok4 = lockOne(ACTION_OFFSET,  gg.TYPE_DWORD, ACTION_VALUE,  ACTION_NAME)
        local ok5 = lockOne(FRAME_OFFSET,   gg.TYPE_BYTE,  FRAME_VALUE,   FRAME_NAME)
        if ok1 and ok2 and ok3 and ok4 and ok5 then T("🚀 已开启全部锁定") else T("⚠️ 部分地址未找到") end
    end
end

function oneClickOpenWaterAll()
    if hasLock(WATER_ACTION_NAME) then
        clearLock(INFHP_NAME); clearLock(NOFALL_NAME); clearLock(INFLIFE_NAME); clearLock(WATER_ACTION_NAME)
        T("✅ 已关闭水中锁定")
    else
        local ok1 = lockOne(INFHP_OFFSET,   gg.TYPE_BYTE,  INFHP_VALUE,        INFHP_NAME)
        local ok2 = lockOne(NOFALL_OFFSET,  gg.TYPE_FLOAT, NOFALL_VALUE,       NOFALL_NAME)
        local ok3 = lockOne(INFLIFE_OFFSET, gg.TYPE_BYTE,  INFLIFE_VALUE,      INFLIFE_NAME)
        local ok4 = lockOne(ACTION_OFFSET,  gg.TYPE_DWORD, WATER_ACTION_VALUE, WATER_ACTION_NAME)
        if ok1 and ok2 and ok3 and ok4 then T("🌊 水中全锁定已开启") else T("⚠️ 部分地址未找到") end
    end
end

function quickOpenCustom(actionVal, actionName, includeFrame)
    if hasLock(actionName) then
        clearLock(INFHP_NAME); clearLock(NOFALL_NAME); clearLock(INFLIFE_NAME)
        clearLock(actionName)
        if includeFrame then clearLock(FRAME_NAME) end
        T("✅ " .. actionName .. " 已关闭")
    else
        local ok1 = lockOne(INFHP_OFFSET,   gg.TYPE_BYTE,  INFHP_VALUE,        INFHP_NAME)
        local ok2 = lockOne(NOFALL_OFFSET,  gg.TYPE_FLOAT, NOFALL_VALUE,       NOFALL_NAME)
        local ok3 = lockOne(INFLIFE_OFFSET, gg.TYPE_BYTE,  INFLIFE_VALUE,      INFLIFE_NAME)
        local ok4 = lockOne(ACTION_OFFSET,  gg.TYPE_DWORD, actionVal,          actionName)
        local ok5 = true
        if includeFrame then ok5 = lockOne(FRAME_OFFSET, gg.TYPE_BYTE, FRAME_VALUE, FRAME_NAME) end
        if ok1 and ok2 and ok3 and ok4 and ok5 then T("✅ " .. actionName .. " 已开启") else T("⚠️ 部分地址未找到") end
    end
end

function quickOpenStickMomParticle()
    local nameHat  = "通用_棍母状态"
    local namePart = "通用_所有粒子特效"
    if hasLock(nameHat) or hasLock(namePart) then
        clearLock(nameHat)
        clearLock(namePart)
        T("✅ 棍母状态 + 所有粒子特效 已关闭")
    else
        local ok1 = lockOne(0x62B0C,        gg.TYPE_BYTE,  -128,             nameHat)
        local ok2 = lockOne(PARTICLE_OFFSET, gg.TYPE_DWORD, PARTICLE_VALUE,   namePart)
        if ok1 and ok2 then
            T("✅ 棍母状态 + 所有粒子特效 已开启")
        else
            T("⚠️ 部分地址未找到（游戏未启动？）")
        end
    end
end

function oneClickCloseAll()
    clearLock(INFHP_NAME); clearLock(INFLIFE_NAME); clearLock(NOFALL_NAME)
    clearLock(ACTION_NAME); clearLock(FRAME_NAME); clearLock(WATER_ACTION_NAME)
    clearLock("快捷动作3"); clearLock("快捷动作4"); clearLock("快捷动作5")
    clearLock("快捷动作6"); clearLock("快捷动作7"); clearLock("快捷动作8"); clearLock("快捷动作9")
    clearLock("快捷动作10")
    clearLock("快捷开启11")
    T("✅ 已关闭全部锁定")
end

function clearCustomLocks()
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        for _, n in ipairs(CUSTOM_LOCK_NAMES) do
            if item.name == n then table.insert(rm, item); break end
        end
    end
    if #rm > 0 then pcall(gg.removeListItems, rm); T("✅ 已关闭自定义修改锁定（" .. #rm .. " 项）")
    else T("当前没有自定义修改锁定") end
end

function clearGeneralLocks()
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        for _, n in ipairs(GENERAL_LOCK_NAMES) do
            if item.name == n then table.insert(rm, item); break end
        end
    end
    if #rm > 0 then pcall(gg.removeListItems, rm); T("✅ 已关闭通用辅助锁定（" .. #rm .. " 项）")
    else T("当前没有通用辅助锁定") end
end

function setRoomPlayerCount()
    local r = gg.prompt({"房间人数（1 ~ " .. PLAYER_MAX .. "）\n当前：" .. roomPlayerCount},
        {tostring(roomPlayerCount)}, {"number"})
    if r and r[1] then
        local n = tonumber(r[1])
        if n and n >= 1 and n <= PLAYER_MAX then roomPlayerCount = math.floor(n); T("✅ 房间人数：" .. roomPlayerCount)
        else T("❌ 请输入 1 ~ " .. PLAYER_MAX) end
    end
end

function readFaceFeature(f)
    local addr = findBssAddr(f.offset)
    if not addr then T("❌ 找不到地址（游戏未启动？）"); return end
    local raw = readVal(addr, gg.TYPE_WORD)
    local signed = raw
    if type(raw) == "number" and raw > 32767 then signed = raw - 65536 end
    gg.alert("【" .. f.displayName .. "】当前值\n\n无符号：" .. tostring(raw) ..
             "\n有符号：" .. tostring(signed) .. "\n地址：" .. f.addrLabel)
end

function testFaceFeatureFreeze(f)
    local addr = findBssAddr(f.offset)
    if not addr then T("❌ 找不到地址（游戏未启动？）"); return end
    local r = gg.prompt({"【" .. f.displayName .. "】冻结值\n（任意整数）"}, {"0"}, {"text"})
    if not r or not r[1] or r[1] == "" then return end
    local n = parseNum(r[1])
    if n == nil then T("❌ 数字无效"); return end
    local wrapped = wrapWord(n)
    clearLock(f.key .. "_face_test")
    pcall(gg.addListItems, {{
        address = addr, flags = gg.TYPE_WORD,
        value = wrapped, freeze = true, name = f.key .. "_face_test",
    }})
    T("🔒 已冻结为 " .. wrapped)
end

function clearFaceFeatureFreeze(f)
    clearLock(f.key .. "_face_test")
    clearLock("face_rotate_" .. f.key)
    T("🔓 已解除【" .. f.displayName .. "】冻结")
end

function quickFaceInfiniteRotate(key)
    local r = FACE_ROTATE[key]
    if not r then T("❌ 未知面朝方向"); return end
    if r.on then
        r.on = false
        local name = ""
        for _, f in ipairs(FACE_FEATURES) do if f.key == key then name = f.displayName; break end end
        T("⏹️ 【" .. name .. "】已停止")
    else
        r.on = true
        r.current = r.min
        local name = ""
        for _, f in ipairs(FACE_FEATURES) do if f.key == key then name = f.displayName; break end end
        ensureMainThread()
        T("▶️ 【" .. name .. "】无限旋转已启动")
    end
end

function openFaceFeatureMenu(f)
    local key = f.key
    while true do
        local r = FACE_ROTATE[key]
        local statusTxt = r.on and "🔴运行中" or "⚪已停止"
        local action = r.on and "⏹️ 停止循环" or "▶️ 开始循环"
        local res = gg.choice({
            action, "📖 读取当前值", "🔒 冻结测试", "🔓 解除所有冻结",
            "⚙️ 设置范围（当前 " .. r.min .. " ~ " .. r.max .. "）",
            "📏 设置步长（当前 " .. r.step .. "）",
            "⚡ 设置旋转主间隔（当前 " .. r.tickMs .. "ms）", "❌ 返回"
        }, nil, "🎯 " .. f.displayName .. " | " .. f.addrLabel .. " | " .. statusTxt ..
                "\n范围 " .. r.min .. "~" .. r.max .. " | 步长 " .. r.step)
        if res == nil or res == 8 then return end
        if res == 1 then quickFaceInfiniteRotate(key)
        elseif res == 2 then readFaceFeature(f)
        elseif res == 3 then testFaceFeatureFreeze(f)
        elseif res == 4 then
            clearLock(key .. "_face_test"); clearLock("face_rotate_" .. key); T("🔓 已解除")
        elseif res == 5 then
            local rr = gg.prompt({"最小值", "最大值"}, {tostring(r.min), tostring(r.max)}, {"text", "text"})
            if rr and rr[1] and rr[2] then
                local mn = parseNum(rr[1]); local mx = parseNum(rr[2])
                if mn and mx and mn <= mx then r.min = math.floor(mn); r.max = math.floor(mx); T("✅ 范围已更新")
                else T("❌ 输入无效") end
            end
        elseif res == 6 then
            local rr = gg.prompt({"步长（> 0）"}, {tostring(r.step)}, {"text"})
            if rr and rr[1] and rr[1] ~= "" then
                local n = parseNum(rr[1])
                if n and n > 0 then r.step = math.floor(n); T("✅ 步长已更新") else T("❌ 步长必须 > 0") end
            end
        elseif res == 7 then setFaceRotateTickMs(key) end
    end
end

function editCharName()
    local addr = findBssAddr(CHAR_NAME_OFFSET)
    if not addr then T("❌ 找不到角色名字地址（游戏未启动？）"); return end
    local cur = readVal(addr, gg.TYPE_DWORD)
    local res = gg.prompt({
        string.format("角色名字（DWORD）\n偏移：0x%X\n地址：0x%X", CHAR_NAME_OFFSET, addr),
        "锁定"
    }, {tostring(cur), hasLock(CHAR_NAME_LOCK)}, {"text", "checkbox"})
    if res == nil then return end
    if res[1] == nil or res[1] == "" then T("❌ 请输入数值"); return end
    local n = parseNum(res[1])
    if n == nil then T("❌ 数字无效"); return end
    n = math.floor(n) % 4294967296
    local freeze = res[2] == true
    clearLock(CHAR_NAME_LOCK)
    writeVal(addr, gg.TYPE_DWORD, n, freeze, CHAR_NAME_LOCK)
    T("✅ 角色名字已修改" .. (freeze and "（锁定）" or ""))
end

function editCharSwitch()
    local addr = findBssAddr(CHAR_SWITCH_OFFSET)
    if not addr then T("❌ 找不到角色切换地址（游戏未启动？）"); return end
    local cur = readVal(addr, gg.TYPE_BYTE)
    if type(cur) == "number" and cur > 127 then cur = cur - 256 end
    local res = gg.prompt({
        string.format("角色切换（BYTE）\n偏移：0x%X\n地址：0x%X", CHAR_SWITCH_OFFSET, addr),
        "锁定"
    }, {tostring(cur), hasLock(CHAR_SWITCH_LOCK)}, {"text", "checkbox"})
    if res == nil then return end
    if res[1] == nil or res[1] == "" then T("❌ 请输入数值"); return end
    local n = parseNum(res[1])
    if n == nil then T("❌ 数字无效"); return end
    n = math.floor(n) % 256
    local freeze = res[2] == true
    clearLock(CHAR_SWITCH_LOCK)
    writeVal(addr, gg.TYPE_BYTE, n, freeze, CHAR_SWITCH_LOCK)
    T("✅ 角色切换已修改" .. (freeze and "（锁定）" or ""))
end

function toggleCharLoop()
    if charLoopOn then
        charLoopOn = false
        T("⏹️ 角色循环已停止")
        return
    end
    local a1 = findBssAddr(CHAR_NAME_OFFSET)
    local a2 = findBssAddr(CHAR_SWITCH_OFFSET)
    if not a1 or not a2 then T("❌ 找不到地址（游戏未启动？）"); return end
    
    clearLock(CHAR_NAME_LOCK)
    clearLock(CHAR_SWITCH_LOCK)
    charLoopIndex = 0
    charLoopOn = true
    ensureMainThread()
    T("🔁 角色名字+角色切换循环已启动（0~4）")
end

function setCharLoopTickMs()
    local r = gg.prompt({"角色循环间隔（毫秒）\n当前：" .. charLoopTickMs .. "ms"},
        {tostring(charLoopTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        charLoopTickMs = math.floor(n)
        T("✅ 角色循环间隔已设为 " .. charLoopTickMs .. "ms")
    end
end

function toggleCharLoopDoubleWrite()
    charLoopDoubleWrite = not charLoopDoubleWrite
    T(charLoopDoubleWrite and "✅ 角色循环双写模式" or "✅ 角色循环单写模式")
end

function setColorRandomTickMs()
    local r = gg.prompt({"随机颜色循环间隔（毫秒）\n当前：" .. colorRandomTickMs .. "ms"},
        {tostring(colorRandomTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        colorRandomTickMs = math.floor(n)
        T("✅ 随机颜色循环间隔已设为 " .. colorRandomTickMs .. "ms")
    end
end

function setColorSameTickMs()
    local r = gg.prompt({"同样颜色循环间隔（毫秒）\n当前：" .. colorSameTickMs .. "ms"},
        {tostring(colorSameTickMs)}, {"text"})
    if r and r[1] and r[1] ~= "" then
        local n = parseNum(r[1])
        if n == nil then T("❌ 数字无效"); return end
        if n < 0 then n = 0 end
        if n > 60000 then n = 60000 end
        colorSameTickMs = math.floor(n)
        T("✅ 同样颜色循环间隔已设为 " .. colorSameTickMs .. "ms")
    end
end

function toggleColorRandomDoubleWrite()
    colorRandomDoubleWrite = not colorRandomDoubleWrite
    T(colorRandomDoubleWrite and "✅ 随机颜色双写模式" or "✅ 随机颜色单写模式")
end

function toggleColorSameDoubleWrite()
    colorSameDoubleWrite = not colorSameDoubleWrite
    T(colorSameDoubleWrite and "✅ 同样颜色双写模式" or "✅ 同样颜色单写模式")
end

function toggleColorRandomLoop()
    if colorRandomLoopOn then
        colorRandomLoopOn = false
        T("⏹️ 随机颜色循环已停止")
        return
    end
    if #COLOR_OFFSETS == 0 then T("❌ 没有颜色地址"); return end
    colorSameLoopOn = false
    colorRandomLoopOn = true
    ensureMainThread()
    T("🌈 随机颜色循环已启动")
end

function toggleColorSameLoop()
    if colorSameLoopOn then
        colorSameLoopOn = false
        T("⏹️ 同样颜色循环已停止")
        return
    end
    if #COLOR_OFFSETS == 0 then T("❌ 没有颜色地址"); return end
    colorRandomLoopOn = false
    colorSameLoopOn = true
    ensureMainThread()
    T("🎨 同样颜色循环已启动")
end

function stopAllColorLoop()
    colorRandomLoopOn = false
    colorSameLoopOn   = false
    T("⏹️ 颜色循环已全部停止")
end

function openLoopMenu()
    while true do
        local status  = followRunning and "🔴运行中" or "⚪已停止"
        local tgtTxt  = followTarget > 0 and ("目标" .. followTarget) or "无目标"
        local secTxt  = "停留 " .. formatDuration(loopFollowDuration)
        local modeTxt = loopFollowMode and "循环" or "单人"
        local spdTxt  = loopFollowTickMs .. "ms/" .. (loopFollowDoubleWrite and "双写" or "单写")
        local action  = followRunning and "⏹️ 停止循环跟随" or "▶️ 启动循环跟随"
        local res = gg.choice({
            action, "⚙️ 设置每人停留时间", "⚡ 设置主间隔",
            "🔁 切换 双写/单写", "🔄 切换 循环/单人 模式", "❌ 返回"
        }, nil, "🔁 循环跟随 | " .. status .. " | " .. tgtTxt .. "\n" ..
                secTxt .. " | " .. modeTxt .. " | " .. spdTxt .. " | 人数" .. roomPlayerCount)
        if res == nil or res == 6 then return end
        if res == 1 then
            if followRunning then stopFollow(); T("⏹️ 已停止") else startFollowThread() end
        elseif res == 2 then
            local r = gg.prompt({"每人停留秒数"}, {tostring(loopFollowDuration / 1000)}, {"number"})
            if r and r[1] then
                local s = tonumber(r[1])
                if s and s >= 0 then loopFollowDuration = math.floor(s * 1000); T("✅ 停留已更新") end
            end
        elseif res == 3 then setLoopFollowTickMs()
        elseif res == 4 then toggleLoopDoubleWrite()
        elseif res == 5 then loopFollowMode = not loopFollowMode; T(loopFollowMode and "🔁 循环模式" or "🎯 单人模式") end
    end
end

function openKillLoopMenu()
    while true do
        local running = followRunning and followKillMode
        local status  = running and "🔴运行中" or "⚪已停止"
        local tgtTxt  = followTarget > 0 and ("目标" .. followTarget) or "无目标"
        local secTxt  = "停留 " .. formatDuration(killLoopFollowDuration)
        local modeTxt = killLoopFollowMode and "循环" or "单人"
        local spdTxt  = killLoopFollowTickMs .. "ms/" .. (killLoopFollowDoubleWrite and "双写" or "单写")
        local action  = running and "⏹️ 停止轮杀跟随" or "▶️ 启动轮杀跟随"
        local res = gg.choice({
            action, "⚙️ 设置每人停留时间", "⚡ 设置主间隔",
            "🔁 切换 双写/单写", "🔄 切换 循环/单人 模式", "❌ 返回"
        }, nil, "🔁 轮杀跟随 | " .. status .. " | " .. tgtTxt .. "\n" ..
                secTxt .. " | " .. modeTxt .. " | " .. spdTxt .. " | 人数" .. roomPlayerCount)
        if res == nil or res == 6 then return end
        if res == 1 then
            if running then stopFollow(); T("⏹️ 已停止") else startKillLoopFollow() end
        elseif res == 2 then
            local r = gg.prompt({"每人停留秒数"}, {tostring(killLoopFollowDuration / 1000)}, {"number"})
            if r and r[1] then
                local s = tonumber(r[1])
                if s and s >= 0 then killLoopFollowDuration = math.floor(s * 1000); T("✅ 停留已更新") end
            end
        elseif res == 3 then setKillLoopFollowTickMs()
        elseif res == 4 then toggleKillLoopDoubleWrite()
        elseif res == 5 then killLoopFollowMode = not killLoopFollowMode; T(killLoopFollowMode and "🔁 循环模式" or "🎯 单人模式") end
    end
end

function openSingleFollowMenu()
    while true do
        local choices = {}
        for i = 1, roomPlayerCount do
            local c = getPlayerCoords(i)
            if c then
                local active = not (c.x == 0 and c.y == 0 and c.z == 0)
                local mark = active and "🟢" or "⚫"
                local tgt  = (followRunning and followTarget == i) and " ★" or ""
                table.insert(choices, string.format("%s 玩家%d (%.1f,%.1f)%s", mark, i, c.x, c.z, tgt))
            else table.insert(choices, string.format("❓ 玩家 %d 读取失败", i)) end
        end
        local dwTxt = singleFollowDoubleWrite and "双写" or "单写"
        table.insert(choices, "🔄 刷新")
        table.insert(choices, "⚡ 主间隔（" .. singleFollowTickMs .. "ms）")
        table.insert(choices, "🔁 切换 双写/单写（当前 " .. dwTxt .. "）")
        table.insert(choices, "⏹️ 停止跟随")
        table.insert(choices, "❌ 返回")
        local refreshIdx = #choices - 4
        local tickIdx = #choices - 3
        local dwIdx = #choices - 2
        local stopIdx = #choices - 1
        local backIdx = #choices
        local res = gg.choice(choices, nil, "🎯 单人跟随 | 间隔 " .. singleFollowTickMs .. "ms | " .. dwTxt)
        if res == nil or res == backIdx then return end
        if res == refreshIdx then
        elseif res == tickIdx then setSingleFollowTickMs()
        elseif res == dwIdx then toggleSingleDoubleWrite()
        elseif res == stopIdx then stopFollow(); T("⏹️ 已停止")
        elseif res >= 1 and res <= roomPlayerCount then
            local i = res
            local c = getPlayerCoords(i)
            if not c or (c.x == 0 and c.y == 0 and c.z == 0) then T("⚠️ 玩家 " .. i .. " 坐标无效")
            else
                followKillMode = false
                loopFollowMode = false
                killLoopFollowMode = false
                followTarget = i
                if not followRunning then startFollowThread() else ensureMainThread() end
                T("🎯 跟随玩家 " .. i)
            end
        end
    end
end

function openCharLoopMenu()
    while true do
        local status = charLoopOn and "🔴运行中" or "⚪已停止"
        local dwTxt = charLoopDoubleWrite and "双写" or "单写"
        local action = charLoopOn and "⏹️ 停止循环" or "▶️ 启动循环"
        local res = gg.choice({
            action,
            "⚡ 设置间隔（当前 " .. charLoopTickMs .. "ms）",
            "🔁 切换 双写/单写（当前 " .. dwTxt .. "）",
            "❌ 返回"
        }, nil, "🔁 角色名字+切换循环 | " .. status)
        if res == nil or res == 4 then return end
        if res == 1 then
            toggleCharLoop()
        elseif res == 2 then
            setCharLoopTickMs()
        elseif res == 3 then
            toggleCharLoopDoubleWrite()
        end
    end
end

function openColorRandomMenu()
    while true do
        local status = colorRandomLoopOn and "🔴运行中" or "⚪已停止"
        local dwTxt = colorRandomDoubleWrite and "双写" or "单写"
        local action = colorRandomLoopOn and "⏹️ 停止循环" or "▶️ 启动循环"
        local res = gg.choice({
            action,
            "⚡ 设置间隔（当前 " .. colorRandomTickMs .. "ms）",
            "🔁 切换 双写/单写（当前 " .. dwTxt .. "）",
            "❌ 返回"
        }, nil, "🌈 循环随机颜色 | " .. status)
        if res == nil or res == 4 then return end
        if res == 1 then
            toggleColorRandomLoop()
        elseif res == 2 then
            setColorRandomTickMs()
        elseif res == 3 then
            toggleColorRandomDoubleWrite()
        end
    end
end

function openColorSameMenu()
    while true do
        local status = colorSameLoopOn and "🔴运行中" or "⚪已停止"
        local dwTxt = colorSameDoubleWrite and "双写" or "单写"
        local action = colorSameLoopOn and "⏹️ 停止循环" or "▶️ 启动循环"
        local res = gg.choice({
            action,
            "⚡ 设置间隔（当前 " .. colorSameTickMs .. "ms）",
            "🔁 切换 双写/单写（当前 " .. dwTxt .. "）",
            "❌ 返回"
        }, nil, "🎨 循环同样颜色 | " .. status)
        if res == nil or res == 4 then return end
        if res == 1 then
            toggleColorSameLoop()
        elseif res == 2 then
            setColorSameTickMs()
        elseif res == 3 then
            toggleColorSameDoubleWrite()
        end
    end
end

MONITOR_FIELDS = {
    {name = "坐标X", offset = 0x62b34, flag = gg.TYPE_FLOAT, fmt = "%.4f"},
    {name = "坐标Y", offset = 0x62b38, flag = gg.TYPE_FLOAT, fmt = "%.4f"},
    {name = "坐标Z", offset = 0x62b3c, flag = gg.TYPE_FLOAT, fmt = "%.4f"},
    {name = "马里奥血量", offset = 0x62adb, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "马里奥生命", offset = 0x62ad8, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "马里奥动作", offset = 0x62afc, flag = gg.TYPE_DWORD, fmt = "%d"},
    {name = "金币", offset = 0x62ad4, flag = gg.TYPE_WORD, fmt = "%d"},
    {name = "星星", offset = 0x62ad6, flag = gg.TYPE_WORD, fmt = "%d"},
    {name = "速度", offset = 0x62b60, flag = gg.TYPE_FLOAT, fmt = "%.2f"},
    {name = "滑动速度", offset = 0x62b50, flag = gg.TYPE_FLOAT, fmt = "%.2f"},
    {name = "面朝方向", offset = 0x62b6c, flag = gg.TYPE_WORD, fmt = "%d"},
    {name = "面朝方向2", offset = 0x62b72, flag = gg.TYPE_WORD, fmt = "%d"},
    {name = "帽子时间", offset = 0x62ae4, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "无敌帧", offset = 0x62ae6, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "帽子状态", offset = 0x62b0c, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "帧状态", offset = 0x62b0a, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "帧时间", offset = 0x62b08, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "关卡编号", offset = 0x49edad4, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "关卡名字", offset = 0x49edad2, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "关卡退出界面", offset = 0x60b42, flag = gg.TYPE_BYTE, fmt = "%d"},
    {name = "水面高度", offset = 0x62c2a, flag = gg.TYPE_WORD, fmt = "%d"},
    {name = "地面高度", offset = 0x62c14, flag = gg.TYPE_FLOAT, fmt = "%.2f"},
    {name = "摔落高度", offset = 0x62b64, flag = gg.TYPE_FLOAT, fmt = "%.2f"},
    {name = "炸弹王生命", offset = 0xad0ec, flag = gg.TYPE_DWORD, fmt = "%d"},
    {name = "库巴生命", offset = 0x69f6c, flag = gg.TYPE_DWORD, fmt = "%d"},
    {name = "全局加速", offset = 0x497b0cc, flag = gg.TYPE_FLOAT, fmt = "%.2f"},
    {name = "区域(Var)", offset = 0xa2ce0, flag = gg.TYPE_BYTE, fmt = "%d"},
}

MONITOR_CATEGORIES = {
    {name = "📊 全部数值", fields = "all"},
    {name = "📍 坐标", fields = {"坐标X", "坐标Y", "坐标Z"}},
    {name = "🏃 玩家", fields = {"马里奥血量", "马里奥生命", "马里奥动作", "速度", "滑动速度", "面朝方向", "面朝方向2", "帽子时间", "无敌帧", "帽子状态"}},
    {name = "🚩 关卡", fields = {"关卡编号", "关卡名字", "关卡退出界面", "星星", "金币", "区域(Var)"}},
    {name = "🌊 环境", fields = {"水面高度", "地面高度", "摔落高度"}},
    {name = "👹 敌人", fields = {"炸弹王生命", "库巴生命"}},
    {name = "🎬 其他", fields = {"帧状态", "帧时间", "全局加速"}},
}

function openCategoryMonitor(cat)
    local fields = {}
    if cat.fields == "all" then fields = MONITOR_FIELDS
    else
        for _, fname in ipairs(cat.fields) do
            for _, f in ipairs(MONITOR_FIELDS) do
                if f.name == fname then table.insert(fields, f); break end
            end
        end
    end
    while true do
        local choices = {}
        for _, f in ipairs(fields) do
            local addr = findBssAddr(f.offset); local v = 0
            if addr then
                local ok, vals = pcall(gg.getValues, {{address = addr, flags = f.flag}})
                if ok and vals and vals[1] then v = tonumber(vals[1].value) or 0 end
            end
            table.insert(choices, string.format("%s：%s", f.name, string.format(f.fmt, v)))
        end
        table.insert(choices, "🔄 刷新"); table.insert(choices, "↩️ 返回")
        local r = gg.choice(choices, nil, cat.name .. " | " .. timeStr())
        if r == nil or r == #choices then return end
    end
end

function editCoord()
    local ax = findBssAddr(0x62b34); local ay = findBssAddr(0x62b38); local az = findBssAddr(0x62b3c)
    if not ax or not ay or not az then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"X坐标", "Y坐标", "Z坐标", "锁定X", "锁定Y", "锁定Z"},
        {tostring(readVal(ax, gg.TYPE_FLOAT)), tostring(readVal(ay, gg.TYPE_FLOAT)), tostring(readVal(az, gg.TYPE_FLOAT)), false, false, false},
        {"text", "text", "text", "checkbox", "checkbox", "checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n = parseNum(res[1]); if n then writeVal(ax, gg.TYPE_FLOAT, n, res[4], "自定义_坐标X") end end
    if res[2] ~= nil and res[2] ~= "" then local n = parseNum(res[2]); if n then writeVal(ay, gg.TYPE_FLOAT, n, res[5], "自定义_坐标Y") end end
    if res[3] ~= nil and res[3] ~= "" then local n = parseNum(res[3]); if n then writeVal(az, gg.TYPE_FLOAT, n, res[6], "自定义_坐标Z") end end
    T("✅ 坐标已更新")
end

function editPlayer()
    local aHP = findBssAddr(0x62adb); local aLive = findBssAddr(0x62ad8); local aAct = findBssAddr(0x62afc)
    local aSpeed = findBssAddr(0x62b60); local aSlide = findBssAddr(0x62b50)
    local aFace = findBssAddr(0x62b6c); local aFace2 = findBssAddr(0x62b72)
    local aHatTime = findBssAddr(HAT_TIME_OFFSET)
    local aInvincible = findBssAddr(INVINCIBLE_OFFSET)
    if not aHP then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"马里奥血量", "马里奥生命", "马里奥动作", "速度", "滑动速度", "面朝方向", "面朝方向2",
         "帽子时间", "无敌帧",
         "锁血量", "锁生命", "锁动作", "锁速度", "锁滑动速度", "锁面朝", "锁面朝2",
         "锁帽子时间", "锁无敌帧"},
        {tostring(readVal(aHP, gg.TYPE_BYTE)), tostring(readVal(aLive, gg.TYPE_BYTE)), tostring(readVal(aAct, gg.TYPE_DWORD)),
         tostring(readVal(aSpeed, gg.TYPE_FLOAT)), tostring(readVal(aSlide, gg.TYPE_FLOAT)),
         tostring(readVal(aFace, gg.TYPE_WORD)), tostring(readVal(aFace2, gg.TYPE_WORD)),
         tostring(readVal(aHatTime, gg.TYPE_BYTE)), tostring(readVal(aInvincible, gg.TYPE_BYTE)),
         false,false,false,false,false,false,false,false,false},
        {"text","text","text","text","text","text","text","text","text",
         "checkbox","checkbox","checkbox","checkbox","checkbox","checkbox","checkbox","checkbox","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n=parseNum(res[1]); if n then writeVal(aHP, gg.TYPE_BYTE, n, res[10], "自定义_马里奥血量") end end
    if res[2] ~= nil and res[2] ~= "" then local n=parseNum(res[2]); if n then writeVal(aLive, gg.TYPE_BYTE, n, res[11], "自定义_马里奥生命") end end
    if res[3] ~= nil and res[3] ~= "" then local n=parseNum(res[3]); if n then writeVal(aAct, gg.TYPE_DWORD, n, res[12], "自定义_马里奥动作") end end
    if res[4] ~= nil and res[4] ~= "" then local n=parseNum(res[4]); if n then writeVal(aSpeed, gg.TYPE_FLOAT, n, res[13], "自定义_速度") end end
    if res[5] ~= nil and res[5] ~= "" then local n=parseNum(res[5]); if n then writeVal(aSlide, gg.TYPE_FLOAT, n, res[14], "自定义_滑动速度") end end
    if res[6] ~= nil and res[6] ~= "" then local n=parseNum(res[6]); if n then writeVal(aFace, gg.TYPE_WORD, wrapWord(n), res[15], "自定义_面朝方向") end end
    if res[7] ~= nil and res[7] ~= "" then local n=parseNum(res[7]); if n then writeVal(aFace2, gg.TYPE_WORD, wrapWord(n), res[16], "自定义_面朝方向2") end end
    if res[8] ~= nil and res[8] ~= "" then local n=parseNum(res[8]); if n then writeVal(aHatTime, gg.TYPE_BYTE, n, res[17], "自定义_帽子时间") end end
    if res[9] ~= nil and res[9] ~= "" then local n=parseNum(res[9]); if n then writeVal(aInvincible, gg.TYPE_BYTE, n, res[18], "自定义_无敌帧") end end
    T("✅ 玩家属性已更新")
end

function editLevel()
    local aId = findBssAddr(0x49edad4); local aName = findBssAddr(0x49edad2); local aExit = findBssAddr(0x60b42)
    local aStar = findBssAddr(0x62ad6); local aCoin = findBssAddr(0x62ad4)
    if not aId then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"关卡编号","关卡名字","退出界面","星星","金币","锁编号","锁名字","锁退出界面","锁星星","锁金币"},
        {tostring(readVal(aId, gg.TYPE_BYTE)), tostring(readVal(aName, gg.TYPE_BYTE)), tostring(readVal(aExit, gg.TYPE_BYTE)),
         tostring(readVal(aStar, gg.TYPE_WORD)), tostring(readVal(aCoin, gg.TYPE_WORD)), false,false,false,false,false},
        {"text","text","text","text","text","checkbox","checkbox","checkbox","checkbox","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n=parseNum(res[1]); if n then writeVal(aId, gg.TYPE_BYTE, n, res[6], "自定义_关卡编号") end end
    if res[2] ~= nil and res[2] ~= "" then local n=parseNum(res[2]); if n then writeVal(aName, gg.TYPE_BYTE, n, res[7], "自定义_关卡名字") end end
    if res[3] ~= nil and res[3] ~= "" then local n=parseNum(res[3]); if n then writeVal(aExit, gg.TYPE_BYTE, n, res[8], "自定义_退出界面") end end
    if res[4] ~= nil and res[4] ~= "" then local n=parseNum(res[4]); if n then writeVal(aStar, gg.TYPE_WORD, n, res[9], "自定义_星星") end end
    if res[5] ~= nil and res[5] ~= "" then local n=parseNum(res[5]); if n then writeVal(aCoin, gg.TYPE_WORD, n, res[10], "自定义_金币") end end
    T("✅ 关卡信息已更新")
end

function editEnv()
    local aWater = findBssAddr(0x62c2a); local aGround = findBssAddr(0x62c14); local aFall = findBssAddr(0x62b64)
    if not aWater then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"水面高度","地面高度","摔落高度","锁水面","锁地面","锁摔落"},
        {tostring(readVal(aWater, gg.TYPE_WORD)), tostring(readVal(aGround, gg.TYPE_FLOAT)), tostring(readVal(aFall, gg.TYPE_FLOAT)), false,false,false},
        {"text","text","text","checkbox","checkbox","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n=parseNum(res[1]); if n then writeVal(aWater, gg.TYPE_WORD, n, res[4], "自定义_水面高度") end end
    if res[2] ~= nil and res[2] ~= "" then local n=parseNum(res[2]); if n then writeVal(aGround, gg.TYPE_FLOAT, n, res[5], "自定义_地面高度") end end
    if res[3] ~= nil and res[3] ~= "" then local n=parseNum(res[3]); if n then writeVal(aFall, gg.TYPE_FLOAT, n, res[6], "自定义_摔落高度") end end
    T("✅ 环境信息已更新")
end

function editEnemy()
    local aKing = findBssAddr(0xad0ec); local aBowser = findBssAddr(0x69f6c)
    if not aKing then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"炸弹王生命","库巴生命","锁炸弹王","锁库巴"},
        {tostring(readVal(aKing, gg.TYPE_DWORD)), tostring(readVal(aBowser, gg.TYPE_DWORD)), false, false},
        {"text","text","checkbox","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n=parseNum(res[1]); if n then writeVal(aKing, gg.TYPE_DWORD, n, res[3], "自定义_炸弹王生命") end end
    if res[2] ~= nil and res[2] ~= "" then local n=parseNum(res[2]); if n then writeVal(aBowser, gg.TYPE_DWORD, n, res[4], "自定义_库巴生命") end end
    T("✅ 敌人信息已更新")
end

function editState()
    local aFrameS = findBssAddr(0x62b0a); local aFrameT = findBssAddr(0x62b08)
    local aHat = findBssAddr(0x62b0c); local aArea = findBssAddr(0xa2ce0)
    if not aFrameS then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt(
        {"帧状态","帧时间","帽子状态","区域","锁帧状态","锁帧时间","锁帽子","锁区域"},
        {tostring(readVal(aFrameS, gg.TYPE_BYTE)), tostring(readVal(aFrameT, gg.TYPE_BYTE)),
         tostring(readVal(aHat, gg.TYPE_BYTE)), tostring(readVal(aArea, gg.TYPE_BYTE)), false,false,false,false},
        {"text","text","text","text","checkbox","checkbox","checkbox","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then local n=parseNum(res[1]); if n then writeVal(aFrameS, gg.TYPE_BYTE, n, res[5], "自定义_帧状态") end end
    if res[2] ~= nil and res[2] ~= "" then local n=parseNum(res[2]); if n then writeVal(aFrameT, gg.TYPE_BYTE, n, res[6], "自定义_帧时间") end end
    if res[3] ~= nil and res[3] ~= "" then local n=parseNum(res[3]); if n then writeVal(aHat, gg.TYPE_BYTE, n, res[7], "自定义_帽子状态") end end
    if res[4] ~= nil and res[4] ~= "" then local n=parseNum(res[4]); if n then writeVal(aArea, gg.TYPE_BYTE, n, res[8], "自定义_区域") end end
    T("✅ 状态信息已更新")
end

function editSpeed()
    local a = findBssAddr(0x497b0cc)
    if not a then gg.alert("找不到地址，请进入游戏关卡") return end
    local res = gg.prompt({"全局加速","锁定"}, {tostring(readVal(a, gg.TYPE_FLOAT)), false}, {"text","checkbox"})
    if res == nil then return end
    if res[1] ~= nil and res[1] ~= "" then
        local n = parseNum(res[1])
        if n then writeVal(a, gg.TYPE_FLOAT, n, res[2], "自定义_全局加速") end
    end
    T("✅ 全局加速已更新")
end

function setCoin99() clearLock("通用_金币"); writeVal(findBssAddr(0x62AD4), gg.TYPE_WORD, 99, false, "通用_金币"); T("💰 金币 = 99") end
function setLife99() clearLock("通用_马里奥生命"); writeVal(findBssAddr(0x62AD8), gg.TYPE_BYTE, 99, false, "通用_马里奥生命"); T("❤️ 生命 = 99") end
function setSpeed100() writeVal(findBssAddr(0x62B60), gg.TYPE_FLOAT, 100, true, "通用_速度"); T("⚡ 速度 = 100（锁定）") end
function killBowser() clearLock("通用_库巴生命"); writeVal(findBssAddr(0x69F6C), gg.TYPE_DWORD, -91, false, "通用_库巴生命"); T("💀 库巴已秒杀") end
function killKingBobomb() clearLock("通用_炸弹王生命"); writeVal(findBssAddr(0xAD0EC), gg.TYPE_DWORD, -91, false, "通用_炸弹王生命"); T("💀 炸弹王已秒杀") end
function editInfHP() writeVal(findBssAddr(0x62ADB), gg.TYPE_BYTE, 8, true, "通用_无限血量"); T("💚 无限血量已开启") end
function editNoFallDamage() writeVal(findBssAddr(0x62B64), gg.TYPE_FLOAT, -3.4e38, true, "通用_无坠落伤害"); T("🪂 无坠落伤害已开启") end
function setHat(value, label) writeVal(findBssAddr(0x62B0C), gg.TYPE_BYTE, value, true, "通用_" .. label); T("❤️ " .. label .. " 已开启") end
function editIronState() setHat(21, "钢铁状态") end
function editFlyState() setHat(25, "飞行状态") end
function editInvisibleState() setHat(19, "隐身状态") end
function editStickMomState() setHat(-128, "棍母状态") end
function editThreeCaps() setHat(31, "三帽合一") end
function editResetState() setHat(17, "重置所有状态") end

function editInvincible()
    local a = findBssAddr(INVINCIBLE_OFFSET)
    if not a then gg.alert("找不到地址，请进入游戏关卡") return end
    writeVal(a, gg.TYPE_BYTE, INVINCIBLE_VALUE, true, "通用_永久无敌")
    T("💚 永久无敌已开启")
end

function editHatTime()
    local a = findBssAddr(HAT_TIME_OFFSET)
    if not a then gg.alert("找不到地址，请进入游戏关卡") return end
    writeVal(a, gg.TYPE_BYTE, HAT_TIME_VALUE, true, "通用_无限帽子时间")
    T("🎩 无限帽子时间已开启")
end

function editParticle()
    local a = findBssAddr(PARTICLE_OFFSET)
    if not a then gg.alert("找不到地址，请进入游戏关卡") return end
    writeVal(a, gg.TYPE_DWORD, PARTICLE_VALUE, true, "通用_所有粒子特效")
    T("🌰 所有粒子特效已开启")
end

function flush() gg.toast("SM64CoopDX 辅助 by 狗哥") end

MS_CAT_BASIC = {
    {name = "玩家索引", offset = 0x62AD0, type = gg.TYPE_WORD},
    {name = "输入", offset = 0x62AD2, type = gg.TYPE_WORD},
    {name = "金币", offset = 0x62AD4, type = gg.TYPE_WORD},
    {name = "星星", offset = 0x62AD6, type = gg.TYPE_WORD},
    {name = "生命", offset = 0x62AD8, type = gg.TYPE_BYTE},
    {name = "钥匙", offset = 0x62AD9, type = gg.TYPE_BYTE},
    {name = "血量", offset = 0x62ADB, type = gg.TYPE_BYTE},
    {name = "受伤计数器", offset = 0x62ADC, type = gg.TYPE_BYTE},
    {name = "治疗计数器", offset = 0x62ADD, type = gg.TYPE_BYTE},
    {name = "打鼾", offset = 0x62ADE, type = gg.TYPE_BYTE},
    {name = "冻结", offset = 0x62ADF, type = gg.TYPE_BYTE},
    {name = "帽子", offset = 0x62AE0, type = gg.TYPE_DWORD},
    {name = "帽子时间", offset = 0x62AE4, type = gg.TYPE_WORD},
    {name = "无敌帧", offset = 0x62AE6, type = gg.TYPE_WORD},
    {name = "挤压计时器", offset = 0x62AE8, type = gg.TYPE_BYTE},
    {name = "击退计时器", offset = 0x62AEA, type = gg.TYPE_BYTE},
    {name = "踢墙计时器", offset = 0x62AEB, type = gg.TYPE_BYTE},
    {name = "二段跳计时器", offset = 0x62AEC, type = gg.TYPE_BYTE},
    {name = "特殊三段跳", offset = 0x62AED, type = gg.TYPE_BYTE},
    {name = "对物体可见", offset = 0x62AEF, type = gg.TYPE_BYTE},
    {name = "对话ID", offset = 0x62AF3, type = gg.TYPE_DWORD},
    {name = "对话所需星星", offset = 0x62AF7, type = gg.TYPE_WORD},
}

MS_CAT_ACTION = {
    {name = "马里奥动作", offset = 0x62AFC, type = gg.TYPE_DWORD},
    {name = "前一动作", offset = 0x62B00, type = gg.TYPE_DWORD},
    {name = "动作参数", offset = 0x62B04, type = gg.TYPE_DWORD},
    {name = "帧时间", offset = 0x62B08, type = gg.TYPE_BYTE},
    {name = "帧状态", offset = 0x62B0A, type = gg.TYPE_BYTE},
    {name = "帽子状态", offset = 0x62B0C, type = gg.TYPE_BYTE},
    {name = "流沙深度", offset = 0x62B10, type = gg.TYPE_FLOAT},
    {name = "控制器指针", offset = 0x62B14, type = gg.TYPE_QWORD},
    {name = "身体状态指针", offset = 0x62B18, type = gg.TYPE_QWORD},
    {name = "角色指针", offset = 0x62B1C, type = gg.TYPE_QWORD},
}

MS_CAT_COORD = {
    {name = "坐标X", offset = 0x62B34, type = gg.TYPE_FLOAT},
    {name = "坐标Y", offset = 0x62B38, type = gg.TYPE_FLOAT},
    {name = "坐标Z", offset = 0x62B3C, type = gg.TYPE_FLOAT},
    {name = "非瞬时传送坐标X", offset = 0x62B40, type = gg.TYPE_FLOAT},
    {name = "非瞬时传送坐标Y", offset = 0x62B44, type = gg.TYPE_FLOAT},
    {name = "非瞬时传送坐标Z", offset = 0x62B48, type = gg.TYPE_FLOAT},
    {name = "速度X", offset = 0x62B4C, type = gg.TYPE_FLOAT},
    {name = "滑动速度", offset = 0x62B50, type = gg.TYPE_FLOAT},
    {name = "滑动速度Z", offset = 0x62B54, type = gg.TYPE_FLOAT},
    {name = "前进速度", offset = 0x62B58, type = gg.TYPE_FLOAT},
    {name = "峰值高度", offset = 0x62B5C, type = gg.TYPE_FLOAT},
    {name = "速度", offset = 0x62B60, type = gg.TYPE_FLOAT},
    {name = "摔落高度", offset = 0x62B64, type = gg.TYPE_FLOAT},
}

MS_CAT_ANGLE = {
    {name = "预期偏航角", offset = 0x62B68, type = gg.TYPE_WORD},
    {name = "面朝方向", offset = 0x62B6C, type = gg.TYPE_WORD},
    {name = "面朝方向2", offset = 0x62B72, type = gg.TYPE_WORD},
    {name = "角速度X", offset = 0x62B74, type = gg.TYPE_WORD},
    {name = "角速度Y", offset = 0x62B76, type = gg.TYPE_WORD},
    {name = "角速度Z", offset = 0x62B78, type = gg.TYPE_WORD},
    {name = "滑动偏航角", offset = 0x62B7A, type = gg.TYPE_WORD},
    {name = "旋转偏航角", offset = 0x62B7C, type = gg.TYPE_WORD},
    {name = "模型面朝", offset = 0xA2C42, type = gg.TYPE_WORD},
    {name = "肢体面朝", offset = 0xA2C48, type = gg.TYPE_WORD},
}

MS_CAT_PTR = {
    {name = "手持物体指针", offset = 0x62B80, type = gg.TYPE_QWORD},
    {name = "被手持物体指针", offset = 0x62B84, type = gg.TYPE_QWORD},
    {name = "交互物体指针", offset = 0x62B88, type = gg.TYPE_QWORD},
    {name = "骑乘物体指针", offset = 0x62B8C, type = gg.TYPE_QWORD},
    {name = "使用物体指针", offset = 0x62B90, type = gg.TYPE_QWORD},
    {name = "马里奥物体指针", offset = 0x62B94, type = gg.TYPE_QWORD},
    {name = "气泡物体指针", offset = 0x62B98, type = gg.TYPE_QWORD},
    {name = "碰撞物体交互类型", offset = 0x62B9C, type = gg.TYPE_DWORD},
    {name = "粒子标志", offset = 0x62BA0, type = gg.TYPE_DWORD},
    {name = "动画指针", offset = 0x62BA4, type = gg.TYPE_QWORD},
    {name = "墙壁指针", offset = 0x62BB8, type = gg.TYPE_QWORD},
    {name = "天花板指针", offset = 0x62BBC, type = gg.TYPE_QWORD},
    {name = "地面指针", offset = 0x62BC0, type = gg.TYPE_QWORD},
    {name = "区域指针", offset = 0x62BCC, type = gg.TYPE_QWORD},
}

MS_CAT_ENV = {
    {name = "天花板高度", offset = 0x62BD4, type = gg.TYPE_FLOAT},
    {name = "地面高度", offset = 0x62C14, type = gg.TYPE_FLOAT},
    {name = "墙壁法线X", offset = 0x62BDC, type = gg.TYPE_FLOAT},
    {name = "墙壁法线Y", offset = 0x62BE0, type = gg.TYPE_FLOAT},
    {name = "墙壁法线Z", offset = 0x62BE4, type = gg.TYPE_FLOAT},
    {name = "地面角度", offset = 0x62BEC, type = gg.TYPE_WORD},
    {name = "水面高度", offset = 0x62C2A, type = gg.TYPE_WORD},
    {name = "当前房间", offset = 0x62BF0, type = gg.TYPE_WORD},
    {name = "关卡编号", offset = 0x49EDAD4, type = gg.TYPE_BYTE},
    {name = "关卡名字", offset = 0x49EDAD2, type = gg.TYPE_BYTE},
    {name = "关卡退出界面", offset = 0x60B42, type = gg.TYPE_BYTE},
    {name = "炸弹王生命", offset = 0xAD0EC, type = gg.TYPE_DWORD},
    {name = "库巴生命", offset = 0x69F6C, type = gg.TYPE_DWORD},
    {name = "全局加速", offset = 0x497B0CC, type = gg.TYPE_FLOAT},
    {name = "区域(Var)", offset = 0xA2CE0, type = gg.TYPE_BYTE},
}

local function getMarioStatePtr()
    return findBssAddr(MARIO_STATE_OFFSET)
end

MS_CAT_MARIO_ANIM = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        return readPointer(ms + 0xF0)
    end,
    fields = {
        {name = "animDmaTable",    offset = 0x00, type = gg.TYPE_QWORD},
        {name = "currentAnimAddr", offset = 0x08, type = gg.TYPE_QWORD},
        {name = "targetAnim",      offset = 0x10, type = gg.TYPE_QWORD},
    }
}

MS_CAT_ANIMATION = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        local marioAnimPtr = readPointer(ms + 0xF0)
        if not marioAnimPtr or marioAnimPtr == 0 then return nil end
        return readPointer(marioAnimPtr + 0x10)
    end,
    fields = {
        {name = "flags",             offset = 0x00, type = gg.TYPE_WORD},
        {name = "animYTransDivisor", offset = 0x02, type = gg.TYPE_WORD},
        {name = "startFrame",        offset = 0x04, type = gg.TYPE_WORD},
        {name = "loopStart",         offset = 0x06, type = gg.TYPE_WORD},
        {name = "loopEnd",           offset = 0x08, type = gg.TYPE_WORD},
        {name = "unusedBoneCount",   offset = 0x0A, type = gg.TYPE_WORD},
        {name = "values(ptr)",       offset = 0x10, type = gg.TYPE_QWORD},
        {name = "index(ptr)",        offset = 0x18, type = gg.TYPE_QWORD},
        {name = "length",            offset = 0x20, type = gg.TYPE_DWORD},
        {name = "valuesLength",      offset = 0x24, type = gg.TYPE_DWORD},
        {name = "indexLength",       offset = 0x28, type = gg.TYPE_DWORD},
    }
}

MS_CAT_CONTROLLER = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        return readPointer(ms + 0x48)
    end,
    fields = {
        {name = "port",           offset = 0x00, type = gg.TYPE_DWORD},
        {name = "stickX",         offset = 0x04, type = gg.TYPE_FLOAT},
        {name = "stickY",         offset = 0x08, type = gg.TYPE_FLOAT},
        {name = "stickMag",       offset = 0x0C, type = gg.TYPE_FLOAT},
        {name = "rawStickX",      offset = 0x10, type = gg.TYPE_WORD},
        {name = "rawStickY",      offset = 0x12, type = gg.TYPE_WORD},
        {name = "extStickX",      offset = 0x14, type = gg.TYPE_WORD},
        {name = "extStickY",      offset = 0x16, type = gg.TYPE_WORD},
        {name = "buttonDown",     offset = 0x18, type = gg.TYPE_WORD},
        {name = "buttonPressed",  offset = 0x1A, type = gg.TYPE_WORD},
        {name = "buttonReleased", offset = 0x1C, type = gg.TYPE_WORD},
    }
}

MS_CAT_BODY_STATE = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        return readPointer(ms + 0x50)
    end,
    fields = {
        {name = "capState",              offset = 0x00, type = gg.TYPE_BYTE},
        {name = "eyeState",              offset = 0x01, type = gg.TYPE_BYTE},
        {name = "handState",             offset = 0x02, type = gg.TYPE_BYTE},
        {name = "punchState",            offset = 0x03, type = gg.TYPE_BYTE},
        {name = "modelState",            offset = 0x04, type = gg.TYPE_WORD},
        {name = "allowPartRotation",     offset = 0x06, type = gg.TYPE_BYTE},
        {name = "grabPos",               offset = 0x07, type = gg.TYPE_BYTE},
        {name = "wingFlutter",           offset = 0x08, type = gg.TYPE_BYTE},
        {name = "mirrorMario",           offset = 0x09, type = gg.TYPE_BYTE},
        {name = "headAngle.x",           offset = 0x0A, type = gg.TYPE_WORD},
        {name = "headAngle.y",           offset = 0x0C, type = gg.TYPE_WORD},
        {name = "headAngle.z",           offset = 0x0E, type = gg.TYPE_WORD},
        {name = "torsoAngle.x",          offset = 0x10, type = gg.TYPE_WORD},
        {name = "torsoAngle.y",          offset = 0x12, type = gg.TYPE_WORD},
        {name = "torsoAngle.z",          offset = 0x14, type = gg.TYPE_WORD},
        {name = "headPos.x",             offset = 0x18, type = gg.TYPE_FLOAT},
        {name = "headPos.y",             offset = 0x1C, type = gg.TYPE_FLOAT},
        {name = "headPos.z",             offset = 0x20, type = gg.TYPE_FLOAT},
        {name = "torsoPos.x",            offset = 0x24, type = gg.TYPE_FLOAT},
        {name = "torsoPos.y",            offset = 0x28, type = gg.TYPE_FLOAT},
        {name = "torsoPos.z",            offset = 0x2C, type = gg.TYPE_FLOAT},
        {name = "heldObjLastPosition.x", offset = 0x30, type = gg.TYPE_FLOAT},
        {name = "heldObjLastPosition.y", offset = 0x34, type = gg.TYPE_FLOAT},
        {name = "heldObjLastPosition.z", offset = 0x38, type = gg.TYPE_FLOAT},
        {name = "currAnimPart",          offset = 0x1B8, type = gg.TYPE_DWORD},
        {name = "updateTorsoTime",       offset = 0x1BC, type = gg.TYPE_DWORD},
        {name = "updateHeadPosTime",     offset = 0x1C0, type = gg.TYPE_DWORD},
        {name = "action",                offset = 0x1C4, type = gg.TYPE_DWORD},
        {name = "shadeR",                offset = 0x1C8, type = gg.TYPE_WORD},
        {name = "shadeG",                offset = 0x1CA, type = gg.TYPE_WORD},
        {name = "shadeB",                offset = 0x1CC, type = gg.TYPE_WORD},
        {name = "lightR",                offset = 0x1CE, type = gg.TYPE_WORD},
        {name = "lightG",                offset = 0x1D0, type = gg.TYPE_WORD},
        {name = "lightB",                offset = 0x1D2, type = gg.TYPE_WORD},
        {name = "lightingDirX",          offset = 0x1D4, type = gg.TYPE_FLOAT},
        {name = "lightingDirY",          offset = 0x1D8, type = gg.TYPE_FLOAT},
        {name = "lightingDirZ",          offset = 0x1DC, type = gg.TYPE_FLOAT},
    }
}

MS_CAT_OBJECT = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        return readPointer(ms + 0xD8)
    end,
    fields = {
        {name = "header.next",               offset = 0x138, type = gg.TYPE_QWORD},
        {name = "header.prev",               offset = 0x140, type = gg.TYPE_QWORD},
        {name = "prevObj",                   offset = 0x148, type = gg.TYPE_QWORD},
        {name = "parentObj",                 offset = 0x150, type = gg.TYPE_QWORD},
        {name = "usingObj",                  offset = 0x158, type = gg.TYPE_QWORD},
        {name = "platform",                  offset = 0x160, type = gg.TYPE_QWORD},
        {name = "collidedObj[0]",            offset = 0x168, type = gg.TYPE_QWORD},
        {name = "collidedObj[1]",            offset = 0x170, type = gg.TYPE_QWORD},
        {name = "collidedObj[2]",            offset = 0x178, type = gg.TYPE_QWORD},
        {name = "collidedObj[3]",            offset = 0x180, type = gg.TYPE_QWORD},
        {name = "collisionData",             offset = 0x188, type = gg.TYPE_QWORD},
        {name = "respawnInfo",               offset = 0x190, type = gg.TYPE_QWORD},
        {name = "areaTimerRunOnceCallback",  offset = 0x198, type = gg.TYPE_QWORD},
        {name = "behavior",                  offset = 0x1A0, type = gg.TYPE_QWORD},
        {name = "initBhvCommand",            offset = 0x1A8, type = gg.TYPE_QWORD},
        {name = "curBhvCommand",             offset = 0x1B0, type = gg.TYPE_QWORD},
        {name = "bhvStackIndex",             offset = 0x238, type = gg.TYPE_DWORD},
        {name = "bhvDelayTimer",             offset = 0x23C, type = gg.TYPE_WORD},
        {name = "activeFlags",               offset = 0x23E, type = gg.TYPE_WORD},
        {name = "collidedObjInteractTypes",  offset = 0x240, type = gg.TYPE_DWORD},
        {name = "numCollidedObjs",           offset = 0x244, type = gg.TYPE_WORD},
        {name = "respawnInfoType",           offset = 0x246, type = gg.TYPE_WORD},
        {name = "hitboxRadius",              offset = 0x248, type = gg.TYPE_FLOAT},
        {name = "hitboxHeight",              offset = 0x24C, type = gg.TYPE_FLOAT},
        {name = "hurtboxRadius",             offset = 0x250, type = gg.TYPE_FLOAT},
        {name = "hurtboxHeight",             offset = 0x254, type = gg.TYPE_FLOAT},
        {name = "hitboxDownOffset",          offset = 0x258, type = gg.TYPE_FLOAT},
        {name = "areaTimer",                 offset = 0x260, type = gg.TYPE_DWORD},
        {name = "areaTimerDuration",         offset = 0x264, type = gg.TYPE_DWORD},
        {name = "areaTimerType",             offset = 0x268, type = gg.TYPE_DWORD},
        {name = "firstSurface",              offset = 0x2B0, type = gg.TYPE_DWORD},
        {name = "numSurfaces",               offset = 0x2B4, type = gg.TYPE_DWORD},
        {name = "heldByPlayerIndex",         offset = 0x2B8, type = gg.TYPE_DWORD},
        {name = "setHome",                   offset = 0x2BC, type = gg.TYPE_BYTE},
        {name = "ctx",                       offset = 0x2BD, type = gg.TYPE_BYTE},
        {name = "allowRemoteInteractions",   offset = 0x2BE, type = gg.TYPE_BYTE},
        {name = "globalPlayerIndex",         offset = 0x2BF, type = gg.TYPE_BYTE},
        {name = "coopFlags",                 offset = 0x2C0, type = gg.TYPE_BYTE},
        {name = "hookRender",                offset = 0x2C1, type = gg.TYPE_BYTE},
    }
}

MS_CAT_GRAPH_NODE = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        return readPointer(ms + 0xD8)
    end,
    fields = {
        {name = "[Node] prev",           offset = 0x00, type = gg.TYPE_QWORD},
        {name = "[Node] next",           offset = 0x08, type = gg.TYPE_QWORD},
        {name = "[Node] parent",         offset = 0x10, type = gg.TYPE_QWORD},
        {name = "[Node] children",       offset = 0x18, type = gg.TYPE_QWORD},
        {name = "[Node] georef",         offset = 0x20, type = gg.TYPE_QWORD},
        {name = "[Node] type",           offset = 0x28, type = gg.TYPE_WORD},
        {name = "[Node] flags",          offset = 0x2A, type = gg.TYPE_WORD},
        {name = "[Node] extraFlags",     offset = 0x2C, type = gg.TYPE_BYTE},
        {name = "[Node] hookProcess",    offset = 0x2D, type = gg.TYPE_BYTE},
        {name = "sharedChild",           offset = 0x30, type = gg.TYPE_QWORD},
        {name = "unk4C",                 offset = 0x38, type = gg.TYPE_QWORD},
        {name = "throwMatrix",           offset = 0x40, type = gg.TYPE_QWORD},
        {name = "throwMatrixPrev",       offset = 0x48, type = gg.TYPE_QWORD},
        {name = "angle.x",               offset = 0x90, type = gg.TYPE_WORD},
        {name = "angle.y",               offset = 0x92, type = gg.TYPE_WORD},
        {name = "angle.z",               offset = 0x94, type = gg.TYPE_WORD},
        {name = "pos.x",                 offset = 0x9C, type = gg.TYPE_FLOAT},
        {name = "pos.y",                 offset = 0xA0, type = gg.TYPE_FLOAT},
        {name = "pos.z",                 offset = 0xA4, type = gg.TYPE_FLOAT},
        {name = "prevPos.x",             offset = 0xA8, type = gg.TYPE_FLOAT},
        {name = "prevPos.y",             offset = 0xAC, type = gg.TYPE_FLOAT},
        {name = "prevPos.z",             offset = 0xB0, type = gg.TYPE_FLOAT},
        {name = "shadowPos.x",           offset = 0xB4, type = gg.TYPE_FLOAT},
        {name = "shadowPos.y",           offset = 0xB8, type = gg.TYPE_FLOAT},
        {name = "shadowPos.z",           offset = 0xBC, type = gg.TYPE_FLOAT},
        {name = "scale.x",               offset = 0xCC, type = gg.TYPE_FLOAT},
        {name = "scale.y",               offset = 0xD0, type = gg.TYPE_FLOAT},
        {name = "scale.z",               offset = 0xD4, type = gg.TYPE_FLOAT},
        {name = "cameraToObject.x",      offset = 0xE4, type = gg.TYPE_FLOAT},
        {name = "cameraToObject.y",      offset = 0xE8, type = gg.TYPE_FLOAT},
        {name = "cameraToObject.z",      offset = 0xEC, type = gg.TYPE_FLOAT},
        {name = "prevTimestamp",         offset = 0xF0, type = gg.TYPE_DWORD},
        {name = "prevShadowPosTimestamp",offset = 0xF4, type = gg.TYPE_DWORD},
        {name = "prevScaleTimestamp",    offset = 0xF8, type = gg.TYPE_DWORD},
        {name = "prevThrowMatrixTimestamp", offset = 0xFC, type = gg.TYPE_DWORD},
        {name = "skipInterpolationTimestamp", offset = 0x100, type = gg.TYPE_DWORD},
        {name = "areaIndex",             offset = 0x130, type = gg.TYPE_BYTE},
        {name = "activeAreaIndex",       offset = 0x131, type = gg.TYPE_BYTE},
        {name = "shadowInvisible",       offset = 0x132, type = gg.TYPE_BYTE},
        {name = "disableAutomaticShadowPos", offset = 0x133, type = gg.TYPE_BYTE},
        {name = "skipInViewCheck",       offset = 0x134, type = gg.TYPE_BYTE},
        {name = "inited",                offset = 0x135, type = gg.TYPE_BYTE},
    }
}

MS_CAT_ANIM_INFO = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        local objPtr = readPointer(ms + 0xD8)
        if not objPtr or objPtr == 0 then return nil end
        return objPtr + 0x108
    end,
    fields = {
        {name = "curAnim",                offset = 0x00, type = gg.TYPE_QWORD},
        {name = "prevAnimPtr",            offset = 0x08, type = gg.TYPE_QWORD},
        {name = "animID",                 offset = 0x10, type = gg.TYPE_WORD},
        {name = "prevAnimID",             offset = 0x12, type = gg.TYPE_WORD},
        {name = "animFrame",              offset = 0x14, type = gg.TYPE_WORD},
        {name = "prevAnimFrame",          offset = 0x16, type = gg.TYPE_WORD},
        {name = "prevAnimFrameTimestamp", offset = 0x18, type = gg.TYPE_DWORD},
        {name = "animFrameAccelAssist",   offset = 0x1C, type = gg.TYPE_DWORD},
        {name = "animAccel",              offset = 0x20, type = gg.TYPE_DWORD},
        {name = "animTimer",              offset = 0x24, type = gg.TYPE_WORD},
        {name = "animYTrans",             offset = 0x26, type = gg.TYPE_WORD},
    }
}

local function makeSurfaceCat(msOffset)
    return {
        resolveBase = function()
            local ms = getMarioStatePtr()
            if not ms then return nil end
            return readPointer(ms + msOffset)
        end,
        fields = {
            {name = "type",              offset = 0x00, type = gg.TYPE_WORD},
            {name = "flags",             offset = 0x02, type = gg.TYPE_BYTE},
            {name = "room",              offset = 0x03, type = gg.TYPE_BYTE},
            {name = "poolType",          offset = 0x04, type = gg.TYPE_BYTE},
            {name = "force",             offset = 0x06, type = gg.TYPE_WORD},
            {name = "lowerY",            offset = 0x08, type = gg.TYPE_WORD},
            {name = "upperY",            offset = 0x0A, type = gg.TYPE_WORD},
            {name = "vertex1.x",         offset = 0x0C, type = gg.TYPE_WORD},
            {name = "vertex1.y",         offset = 0x0E, type = gg.TYPE_WORD},
            {name = "vertex1.z",         offset = 0x10, type = gg.TYPE_WORD},
            {name = "vertex2.x",         offset = 0x12, type = gg.TYPE_WORD},
            {name = "vertex2.y",         offset = 0x14, type = gg.TYPE_WORD},
            {name = "vertex2.z",         offset = 0x16, type = gg.TYPE_WORD},
            {name = "vertex3.x",         offset = 0x18, type = gg.TYPE_WORD},
            {name = "vertex3.y",         offset = 0x1A, type = gg.TYPE_WORD},
            {name = "vertex3.z",         offset = 0x1C, type = gg.TYPE_WORD},
            {name = "prevVertex1.x",     offset = 0x1E, type = gg.TYPE_WORD},
            {name = "prevVertex1.y",     offset = 0x20, type = gg.TYPE_WORD},
            {name = "prevVertex1.z",     offset = 0x22, type = gg.TYPE_WORD},
            {name = "prevVertex2.x",     offset = 0x24, type = gg.TYPE_WORD},
            {name = "prevVertex2.y",     offset = 0x26, type = gg.TYPE_WORD},
            {name = "prevVertex2.z",     offset = 0x28, type = gg.TYPE_WORD},
            {name = "prevVertex3.x",     offset = 0x2A, type = gg.TYPE_WORD},
            {name = "prevVertex3.y",     offset = 0x2C, type = gg.TYPE_WORD},
            {name = "prevVertex3.z",     offset = 0x2E, type = gg.TYPE_WORD},
            {name = "normal.x",          offset = 0x30, type = gg.TYPE_FLOAT},
            {name = "normal.y",          offset = 0x34, type = gg.TYPE_FLOAT},
            {name = "normal.z",          offset = 0x38, type = gg.TYPE_FLOAT},
            {name = "originOffset",      offset = 0x3C, type = gg.TYPE_FLOAT},
            {name = "modifiedTimestamp", offset = 0x40, type = gg.TYPE_DWORD},
            {name = "socId",             offset = 0x44, type = gg.TYPE_DWORD},
            {name = "object",            offset = 0x48, type = gg.TYPE_QWORD},
        }
    }
end

MS_CAT_SURFACE_WALL  = makeSurfaceCat(0x110)
MS_CAT_SURFACE_CEIL  = makeSurfaceCat(0x118)
MS_CAT_SURFACE_FLOOR = makeSurfaceCat(0x120)

MS_CAT_ANIM_DMA = {
    resolveBase = function()
        local ms = getMarioStatePtr()
        if not ms then return nil end
        local marioAnimPtr = readPointer(ms + 0xF0)
        if not marioAnimPtr or marioAnimPtr == 0 then return nil end
        return readPointer(marioAnimPtr + 0x00)
    end,
    fields = {
        {name = "count",              offset = 0x00, type = gg.TYPE_DWORD},
        {name = "srcAddr",            offset = 0x08, type = gg.TYPE_QWORD},
        {name = "anim[0].offset",     offset = 0x10, type = gg.TYPE_DWORD},
        {name = "anim[0].size",       offset = 0x14, type = gg.TYPE_DWORD},
        {name = "anim[1].offset",     offset = 0x18, type = gg.TYPE_DWORD},
        {name = "anim[1].size",       offset = 0x1C, type = gg.TYPE_DWORD},
        {name = "anim[2].offset",     offset = 0x20, type = gg.TYPE_DWORD},
        {name = "anim[2].size",       offset = 0x24, type = gg.TYPE_DWORD},
    }
}

function editMSField(f, catName)
    local addr = findBssAddr(f.offset)
    if not addr then T("❌ 找不到 bss 基址"); return end
    editMSFieldAt(addr, f, catName)
end

function editMSFieldWithBase(f, catName, getBase)
    local base = getBase()
    if not base or base == 0 then T("❌ 指针链解析失败（游戏未启动？）"); return end
    editMSFieldAt(base + f.offset, f, catName)
end

function editMSFieldAt(addr, f, catName)
    local currentVal = readVal(addr, f.type)

    local typeName = "未知"
    if f.type == gg.TYPE_BYTE then typeName = "BYTE"
    elseif f.type == gg.TYPE_WORD then typeName = "WORD"
    elseif f.type == gg.TYPE_DWORD then typeName = "DWORD"
    elseif f.type == gg.TYPE_QWORD then typeName = "QWORD(ptr)"
    elseif f.type == gg.TYPE_FLOAT then typeName = "FLOAT" end

    local lockName = "MS_" .. f.name
    local res = gg.prompt(
        {
            string.format("[%s] %s\n地址: 0x%X | 偏移: 0x%X | 类型: %s", catName, f.name, addr, f.offset, typeName),
            "锁定该数值"
        },
        { tostring(currentVal), hasLock(lockName) },
        { "text", "checkbox" }
    )

    if res == nil then return end
    local val = parseNum(res[1])
    if val == nil then T("❌ 数值无效"); return end
    local freeze = res[2] == true

    if f.type == gg.TYPE_BYTE then
        val = math.floor(val) % 256
    elseif f.type == gg.TYPE_WORD then
        val = math.floor(val) % 65536
        if val > 32767 then val = val - 65536 end
    elseif f.type == gg.TYPE_DWORD then
        val = math.floor(val)
    end

    clearLock(lockName)
    writeVal(addr, f.type, val, freeze, lockName)
    T("✅ " .. f.name .. " 已修改" .. (freeze and " (锁定)" or ""))
end

function clearMSLocks()
    local rm = {}
    for _, item in ipairs(gg.getListItems() or {}) do
        local n = tostring(item.name or "")
        if string.find(n, "^MS_") then
            table.insert(rm, item)
        end
    end
    if #rm > 0 then
        pcall(gg.removeListItems, rm)
        T("🧹 已清理 " .. #rm .. " 个 MARIOSTATE 锁定")
    else
        T("✅ 没有 MARIOSTATE 锁定")
    end
end

local function buildMSUi(fieldsOrTable, catName)
    local fields = fieldsOrTable
    local getBase = nil
    if type(fieldsOrTable) == "table" and fieldsOrTable.resolveBase then
        fields = fieldsOrTable.fields or {}
        getBase = fieldsOrTable.resolveBase
    end

    local ui = {}
    for _, f in ipairs(fields) do
        local fCopy = f
        table.insert(ui, {
            title = "🔸 " .. fCopy.name,
            subTitle = string.format("%s | 偏移 0x%X", catName, fCopy.offset),
            main = function()
                if getBase then
                    editMSFieldWithBase(fCopy, catName, getBase)
                else
                    editMSField(fCopy, catName)
                end
            end
        })
    end
    table.insert(ui, {
        title = "🧹 关闭所有 MARIOSTATE 锁定",
        subTitle = "清除 MS_* 前缀的冻结项",
        main = clearMSLocks
    })
    return gg.viewList(ui, flush)
end

local _ui_ms_basic     = buildMSUi(MS_CAT_BASIC,       "基础状态")
local _ui_ms_action    = buildMSUi(MS_CAT_ACTION,      "动作与状态")
local _ui_ms_coord     = buildMSUi(MS_CAT_COORD,       "坐标与速度")
local _ui_ms_angle     = buildMSUi(MS_CAT_ANGLE,       "角度与朝向")
local _ui_ms_ptr       = buildMSUi(MS_CAT_PTR,         "指针与对象")
local _ui_ms_env       = buildMSUi(MS_CAT_ENV,         "环境与高度")

local _ui_animation    = buildMSUi(MS_CAT_ANIMATION,    "动画数据")
local _ui_mario_anim   = buildMSUi(MS_CAT_MARIO_ANIM,   "马里奥动画对象")
local _ui_anim_dma     = buildMSUi(MS_CAT_ANIM_DMA,     "动画DMA表")
local _ui_controller   = buildMSUi(MS_CAT_CONTROLLER,   "控制器")
local _ui_body_state   = buildMSUi(MS_CAT_BODY_STATE,   "身体状态")
local _ui_object       = buildMSUi(MS_CAT_OBJECT,       "马里奥物体")
local _ui_graph_node   = buildMSUi(MS_CAT_GRAPH_NODE,   "图节点")
local _ui_anim_info    = buildMSUi(MS_CAT_ANIM_INFO,    "动画状态")
local _ui_surface_wall = buildMSUi(MS_CAT_SURFACE_WALL, "墙面")
local _ui_surface_ceil = buildMSUi(MS_CAT_SURFACE_CEIL, "天花板")
local _ui_surface_floor= buildMSUi(MS_CAT_SURFACE_FLOOR,"地面")

local tableSettingUi = {}
table.insert(tableSettingUi, {
    title = "🧹 关闭所有锁定",
    subTitle = "清除全部冻结项（含所有分类）",
    main = clearAllLocks
})
local _ui_setting = gg.viewList(tableSettingUi, flush)

tableMonitorUi = {}
for _, cat in ipairs(MONITOR_CATEGORIES) do
    table.insert(tableMonitorUi, { title = cat.name, subTitle = "点击查看", main = function() openCategoryMonitor(cat) end })
end
local _ui_monitor = gg.viewList(tableMonitorUi, flush)

tableCustomUi = {}
table.insert(tableCustomUi, {title = "📍坐标设置", subTitle = "X / Y / Z", main = editCoord})
table.insert(tableCustomUi, {title = "🏃玩家属性", subTitle = "血 / 命 / 动作 / 速度 / 2 个面朝方向 / 帽子时间 / 无敌帧", main = editPlayer})
table.insert(tableCustomUi, {title = "🚩关卡信息", subTitle = "编号 / 名字 / 退出界面 / 星星 / 金币", main = editLevel})
table.insert(tableCustomUi, {title = "🌊环境信息", subTitle = "水面 / 地面 / 摔落", main = editEnv})
table.insert(tableCustomUi, {title = "👹敌人信息", subTitle = "炸弹王 / 库巴", main = editEnemy})
table.insert(tableCustomUi, {title = "🎬状态信息", subTitle = "帧状态 / 帧时间 / 帽子 / 区域", main = editState})
table.insert(tableCustomUi, {title = "⚡全局加速", subTitle = "加速值", main = editSpeed})
table.insert(tableCustomUi, {title = "❌关闭自定义修改锁定", subTitle = "只清理自定义修改的锁定", main = clearCustomLocks})
local _ui_custom = gg.viewList(tableCustomUi, flush)

tableGeneralUi = {}
table.insert(tableGeneralUi, {title = "💰金币改成99", subTitle = "不锁定", main = setCoin99})
table.insert(tableGeneralUi, {title = "❤️生命改成99", subTitle = "不锁定", main = setLife99})
table.insert(tableGeneralUi, {title = "⚡速度100（锁定）", subTitle = "锁死 100", main = setSpeed100})
table.insert(tableGeneralUi, {title = "💀秒杀库巴", subTitle = "生命 -91", main = killBowser})
table.insert(tableGeneralUi, {title = "💀秒杀炸弹王", subTitle = "生命 -91", main = killKingBobomb})
table.insert(tableGeneralUi, {title = "💚无限血量", subTitle = "锁定血最大值", main = editInfHP})
table.insert(tableGeneralUi, {title = "🪂无坠落伤害", subTitle = "高处掉落不掉血", main = editNoFallDamage})
table.insert(tableGeneralUi, {title = "💚永久无敌", subTitle = "无敌帧锁定为9178", main = editInvincible})
table.insert(tableGeneralUi, {title = "🌰所有粒子特效", subTitle = "锁定4294967295", main = editParticle})
table.insert(tableGeneralUi, {title = "❌关闭通用辅助锁定", subTitle = "只清理通用辅助的锁定", main = clearGeneralLocks})
local _ui_general = gg.viewList(tableGeneralUi, flush)

tableHatUi = {}
table.insert(tableHatUi, {title = "🛡钢铁状态", subTitle = "无伤害", main = editIronState})
table.insert(tableHatUi, {title = "🕊飞行状态", subTitle = "自由飞行", main = editFlyState})
table.insert(tableHatUi, {title = "👻隐身状态", subTitle = "隐身攻击", main = editInvisibleState})
table.insert(tableHatUi, {title = "🪵棍母状态", subTitle = "棍状形态", main = editStickMomState})
table.insert(tableHatUi, {title = "🎩三帽合一", subTitle = "叠加", main = editThreeCaps})
table.insert(tableHatUi, {title = "🔄重置状态", subTitle = "普通马里奥", main = editResetState})
table.insert(tableHatUi, {title = "🎩无限帽子时间", subTitle = "帽子时间锁定为9178", main = editHatTime})
local _ui_hat = gg.viewList(tableHatUi, flush)

tableAttachUi = {}
table.insert(tableAttachUi, {title = "❄️ 冻结所有人头顶", subTitle = "GG 原生冻结", main = toggleRoofFreeze})
table.insert(tableAttachUi, {title = "❄️ 单个玩家冻结头顶", subTitle = "选一个玩家冻结", main = openSingleRoofFreezeMenu})
table.insert(tableAttachUi, {title = "⚙️ 设置头顶高度", subTitle = "默认 100", main = setRoofHeight})
table.insert(tableAttachUi, {title = "👥 设置房间人数", subTitle = "统一设置", main = setRoomPlayerCount})
local _ui_attach = gg.viewList(tableAttachUi, flush)

tableExitUi = {}
table.insert(tableExitUi, {title = "🚪 一键修改所有人退出界面", subTitle = "输入 -128 ~ 255，支持锁定", main = batchEditExitUI})
table.insert(tableExitUi, {title = "🚪 单个玩家修改退出界面", subTitle = "选玩家修改，支持锁定", main = editSingleExitUI})
table.insert(tableExitUi, {title = "👀 查看所有人退出界面数值", subTitle = "显示15个其他玩家（P1~P15）", main = viewAllExitUI})
table.insert(tableExitUi, {title = "🧹 清理退出界面锁定", subTitle = "清除批量/单个锁定项", main = clearExitUILocks})
table.insert(tableExitUi, {title = "👥 设置房间人数", subTitle = "与坐标固定/杀戮光环共享", main = setRoomPlayerCount})
local _ui_exit = gg.viewList(tableExitUi, flush)

tableKillAuraUi = {}
table.insert(tableKillAuraUi, {title = "🔁 循环跟随全部玩家", subTitle = "按顺序跟随", main = openLoopMenu})
table.insert(tableKillAuraUi, {title = "🔁 跟踪循环玩家(改良版)", subTitle = "轮杀：血量0切换", main = openKillLoopMenu})
table.insert(tableKillAuraUi, {title = "🎯 单人跟随", subTitle = "选玩家跟随", main = openSingleFollowMenu})
table.insert(tableKillAuraUi, {title = "📍 传送菜单", subTitle = "点谁传谁", main = openTeleportMenu})
table.insert(tableKillAuraUi, {title = "👥 设置房间人数", subTitle = "统一设置", main = setRoomPlayerCount})
local _ui_killaura = gg.viewList(tableKillAuraUi, flush)

tableQuickUi = {}
table.insert(tableQuickUi, {title = "🚀 快捷开启1 (全部)", subTitle = "点一下开启，再点一下关闭", main = oneClickOpenAll})
table.insert(tableQuickUi, {title = "🌊 快捷开启2 (水中)", subTitle = "点一下开启，再点一下关闭", main = oneClickOpenWaterAll})
table.insert(tableQuickUi, {title = "🦵 快捷开启3 (飞踢)", subTitle = "动作值 25,168,044", main = function() quickOpenCustom(25168044, "快捷动作3") end})
table.insert(tableQuickUi, {title = "🏂 快捷开启4 (滑行)", subTitle = "动作值 8,651,858", main = function() quickOpenCustom(8651858, "快捷动作4") end})
table.insert(tableQuickUi, {title = "🛹 快捷开启5 (滑铲)", subTitle = "动作值 25,168,042 + 帧状态", main = function() quickOpenCustom(25168042, "快捷动作5", true) end})
table.insert(tableQuickUi, {title = "👊 快捷开启6 (挥拳)", subTitle = "动作值 8,389,504", main = function() quickOpenCustom(8389504, "快捷动作6") end})
table.insert(tableQuickUi, {title = "💫 快捷开启7 (翻滚)", subTitle = "动作值 16,779,430", main = function() quickOpenCustom(16779430, "快捷动作7") end})
table.insert(tableQuickUi, {title = "🤸 快捷开启8 (飞扑)", subTitle = "动作值 25,692,298", main = function() quickOpenCustom(25692298, "快捷动作8") end})
table.insert(tableQuickUi, {title = "🤾 快捷开启9 (飞扑2)", subTitle = "动作值 8,914,006", main = function() quickOpenCustom(8914006, "快捷动作9") end})
table.insert(tableQuickUi, {title = "🧪 快捷开启10 (仅限OMM模组)", subTitle = "动作值 1,082,132,613", main = function() quickOpenCustom(1082132613, "快捷动作10") end})
table.insert(tableQuickUi, {title = "🪵🌰 快捷开启11 (棍母+所有粒子特效)", subTitle = "棍母状态 + 所有粒子特效，一键开关", main = quickOpenStickMomParticle})
local _ui_quick = gg.viewList(tableQuickUi, flush)

tableFaceUi = {}
for _, f in ipairs(FACE_FEATURES) do
    table.insert(tableFaceUi, { title = "🎯 " .. f.displayName, subTitle = "地址 " .. f.addrLabel, main = function() openFaceFeatureMenu(f) end })
end
table.insert(tableFaceUi, { title = "🧹 清理所有面朝残留", subTitle = "清除遗留的冻结项", main = clearAllFaceLocks })
table.insert(tableFaceUi, { title = "♾️ 面朝方向无限旋转(有点怪但能用)", subTitle = "点一下开启，再点一下关闭", main = function() quickFaceInfiniteRotate("orig") end })
table.insert(tableFaceUi, { title = "♾️ 面朝方向2无限旋转(配合杀戮光环用)", subTitle = "点一下开启，再点一下关闭", main = function() quickFaceInfiniteRotate("orig2") end })
local _ui_face = gg.viewList(tableFaceUi, flush)

tableCharUi = {}
table.insert(tableCharUi, { title = "📝 自定义修改角色名称", subTitle = "DWORD 类型 | 偏移 0x496b1ec | 支持锁定", main = editCharName })
table.insert(tableCharUi, { title = "🎭 自定义修改角色",     subTitle = "BYTE  类型 | 偏移 0x49edc58 | 支持锁定", main = editCharSwitch })

table.insert(tableCharUi, { title = "🔁 角色名字+角色切换 循环 0~4", subTitle = "点击进入设置与开关", main = openCharLoopMenu })
table.insert(tableCharUi, { title = "🌈 循环随机颜色", subTitle = "点击进入设置与开关", main = openColorRandomMenu })
table.insert(tableCharUi, { title = "🎨 循环同样颜色", subTitle = "点击进入设置与开关", main = openColorSameMenu })

table.insert(tableCharUi, { title = "⏹️ 停止所有颜色循环", subTitle = "一键停止随机/同样颜色循环", main = stopAllColorLoop })

local _ui_char = gg.viewList(tableCharUi, flush)

local w = gg.mainTabs("设置", _ui_setting.getView(), true, w)
gg.mainTabs("监控", _ui_monitor.getView(), true, w)

gg.mainTabs("基础状态",   _ui_ms_basic.getView(),  true, w)
gg.mainTabs("动作与状态", _ui_ms_action.getView(), true, w)
gg.mainTabs("坐标与速度", _ui_ms_coord.getView(),  true, w)
gg.mainTabs("角度与朝向", _ui_ms_angle.getView(),  true, w)
gg.mainTabs("指针与对象", _ui_ms_ptr.getView(),    true, w)
gg.mainTabs("环境与高度", _ui_ms_env.getView(),    true, w)

gg.mainTabs("动画数据",   _ui_animation.getView(),     true, w)
gg.mainTabs("动画对象",   _ui_mario_anim.getView(),    true, w)
gg.mainTabs("动画DMA",    _ui_anim_dma.getView(),      true, w)
gg.mainTabs("动画状态",   _ui_anim_info.getView(),     true, w)
gg.mainTabs("控制器",     _ui_controller.getView(),    true, w)
gg.mainTabs("身体状态",   _ui_body_state.getView(),    true, w)
gg.mainTabs("马里奥物体", _ui_object.getView(),        true, w)
gg.mainTabs("图节点",     _ui_graph_node.getView(),    true, w)
gg.mainTabs("墙面",       _ui_surface_wall.getView(),  true, w)
gg.mainTabs("天花板",     _ui_surface_ceil.getView(),  true, w)
gg.mainTabs("地面",       _ui_surface_floor.getView(), true, w)

gg.mainTabs("自定义修改", _ui_custom.getView(),   true, w)
gg.mainTabs("通用辅助",   _ui_general.getView(),  true, w)
gg.mainTabs("帽子状态",   _ui_hat.getView(),      true, w)
gg.mainTabs("坐标固定",   _ui_attach.getView(),   true, w)
gg.mainTabs("退出界面",   _ui_exit.getView(),     true, w)
gg.mainTabs("杀戮光环",   _ui_killaura.getView(), true, w)
gg.mainTabs("快捷开启",   _ui_quick.getView(),    true, w)
gg.mainTabs("面朝方向",   _ui_face.getView(),     true, w)
local finalWin = gg.mainTabs("角色", _ui_char.getView(), true, w)

gg.setVisible(false)
window = finalWin
window.setIcon("https://q.qlogo.cn/headimg_dl?dst_uin=1062620173&spec=640&img_type=jpg")
window.setTitle("SM64辅助")
window.setMinIcon("https://p.qlogo.cn/gh/1064318731/1064318731/640")
gg.setTabVisible(false)
gg.setTabVisible(true)

print("SM64CoopDX辅助加强版")
print("SM64CoopDX外挂群：1064318731")
print("   == SUPER MARIO CO-OP Deluxe ==")
print("    == AGG Version Lua Crack! ==")
print("灵感 & 抓静态基址 by 狗哥")
print("        -- (他先提的想法)")
print("Ui & Lua by toadXtech64 & 狗哥")
print("          --(社交媒体 toad114514 全部同名)")
print("B站账号: 狗哥又玩又爱玩 & Taod114514")
print("Enjoy!")
print("⏱️ 启动时间：" .. START_TIME)

return function() end