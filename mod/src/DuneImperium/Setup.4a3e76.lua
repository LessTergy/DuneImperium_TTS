-- Bundled by luabundle {"rootModuleName":"Setup.4a3e76.lua","version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(nil)
__bundle_register("Setup.4a3e76.lua", function(require, _LOADED, __bundle_register, __bundle_modules)
i18n = require("i18n")
require("locales")

constants = require("Constants")

wormObj = getObjectFromGUID('20b33a')

helperModule = require("HelperModule")

pos_discard = constants.pos_discard

GetDeckOrCard = helperModule.GetDeckOrCard

marker = constants.first_player_marker
position_marker = constants.first_player_positions

manigance = '2b2575'
trash = {
    ["Green"] = getObjectFromGUID("4060b5"),
    ["Blue"] = getObjectFromGUID("52a539"),
    ["Yellow"] = getObjectFromGUID("7d1e07"),
    ["Red"] = getObjectFromGUID("ea3fe1"),
    ["Everyone"] = getObjectFromGUID("ef8614")
}
hagal_rise_of_ix_2P = getObjectFromGUID("1f3751")
hagal_2P = getObjectFromGUID("43a37f")
hagal_rise_of_ix_1P = getObjectFromGUID("cb48b7")
hagal_1P = getObjectFromGUID("2d887f")
hagal_everytime_except_immortality_1P = getObjectFromGUID("d1ff61")
hagal_immortality_1P = getObjectFromGUID("9f6ea8")
hagal_rise_of_ix = getObjectFromGUID("dd0da1")
hagal_without_rise_of_ix = getObjectFromGUID("72d430")

pos_black_market = constants.pos_black_market

pos_starter_decks = {
    {-24.62, 1.80, 20.48}, {13.68, 1.74, 20.52}, {-24.41, 1.79, -1.54},
    {13.44, 1.74, -1.51}
}

dune_cards_decks_zone = {
    getObjectFromGUID("e23476"), getObjectFromGUID("355dc0"),
    getObjectFromGUID("d3521b"), getObjectFromGUID("7b2ba8")
}
zone_intrigue = 'a377d8'
zone_imperium = constants.zone_deck_imperium
epic_cards = constants.epic_cards
-- conflictZone1 = "616984"
-- conflictZone2 = "7c9ceb"
-- conflictZone3 = "f9ea6b"
trashBin = '8d39ef'
conflictDeckLocation = {-3.38, 3, -5.74}
conflict1start = {-1.15, 1.76, -5.74}
councellor_bonus_bag = getObjectFromGUID("074f6d")
FP1 = getObjectFromGUID('66444c')
FP2 = getObjectFromGUID('4e8873')
FP3 = getObjectFromGUID('a6c2e0')
FP4 = getObjectFromGUID('311255')
yellowscore = getObjectFromGUID('20bbd1')
greenscore = getObjectFromGUID('76039f')
bluescore = getObjectFromGUID('1b1e76')
redscore = getObjectFromGUID('4feaca')
tech_tiles_en = getObjectFromGUID("cb766f")
tech_tiles_fr = getObjectFromGUID("6116af")
intrigue_ix = constants.intrigue_ix
intrigue_immortality = constants.intrigue_immortality
-- imperium_deck = getObjectFromGUID('71ec7e')
imperium_deck_ix = constants.imperium_deck_ix
imperium_deck_immortality = constants.imperium_deck_immortality
-- tleilaxu_deck = constants.tleilaxu_deck
reclaimed_forces = constants.reclaimed_forces
bene_tleilax_zone = getObjectFromGUID('042b49')
atomics = {'d5ff47', '0a22ec', '700023', '7e10a9'}
experimentation_decks = {'ef9531', '45ce21', '2d935f', '8ed0cd'}
research_station_immortality = getObjectFromGUID('54413c')
intrigue_pos = {0.25, 1.79, 16.29}
imperium_pos = {-10.00, 2.03, 12.87}
hagal1P_base = "54a2cb"
hagal1P = getObjectFromGUID("6020d0")
hagal2P_base = "1dd8a5"
hagal2P = getObjectFromGUID("8f8cc1")
conflictOne = getObjectFromGUID("616984")
conflictTwo = getObjectFromGUID("7c9ceb")
conflictThree = getObjectFromGUID("f9ea6b")
epicgamebutton = getObjectFromGUID("f8480b")
pos_trash = constants.pos_trash_lower

tleilaxuTokens = constants.tleilaxuTokens
researchTokens = constants.researchTokens

cargo = constants.cargo

table_players = {
    ["Green"] = {
        "76039f", "a1a9a7", "866a9c", "8e22cc", "2b1cf8", "34281d", "d390dc",
        "2dc980", "89da7d", "d7c9ba", "a67287", "fc9c62", "126c3c", "caaba4",
        "63d39f", "658b17"
    },
    ["Blue"] = {
        "1b1e76", "f22e20", "c64616", "49afee", "46c1c6", "68e424", "0e6e41",
        "2a88a6", "4069d8", "426a23", "f60d9c", "694553", "b71dd9", "121bb6",
        "96607f", "292658"
    },
    ["Yellow"] = {
        "20bbd1", "c2dd31", "ef9008", "734b6e", "fd7fc7", "8fa76f", "77d7c8",
        "a3729e", "9d0075", "489871", "b5d32e", "7c5b7b", "6af67a", "99a860",
        "d20bcf", "8988cf"
    },
    ["Red"] = {
        "4feaca", "2d1d17", "1fb4ed", "465c38", "0fa955", "e9096d", "088f51",
        "713eae", "be464e", "acfcef", "1bbf1c", "26904f", "8ea4af", "e0ed4b",
        "2bfc39", "39e0f3"
    }
}
hand_players = {
    ["Green"] = getObjectFromGUID("482f72"),
    ["Blue"] = getObjectFromGUID("e50f77"),
    ["Yellow"] = getObjectFromGUID("050f39"),
    ["Red"] = getObjectFromGUID("8a9816")
}
pion_reput = {
    ["Emperor"] = {
        ["Red"] = getObjectFromGUID('acfcef'),
        ["Blue"] = getObjectFromGUID('426a23'),
        ["Green"] = getObjectFromGUID('d7c9ba'),
        ["Yellow"] = getObjectFromGUID('489871')
    },
    ["Guild"] = {
        ["Red"] = getObjectFromGUID('be464e'),
        ["Blue"] = getObjectFromGUID('4069d8'),
        ["Green"] = getObjectFromGUID('89da7d'),
        ["Yellow"] = getObjectFromGUID('9d0075')
    },
    ["Bene"] = {
        ["Red"] = getObjectFromGUID('713eae'),
        ["Blue"] = getObjectFromGUID('2a88a6'),
        ["Green"] = getObjectFromGUID('2dc980'),
        ["Yellow"] = getObjectFromGUID('a3729e')
    },
    ["Fremen"] = {
        ["Red"] = getObjectFromGUID('088f51'),
        ["Blue"] = getObjectFromGUID('0e6e41'),
        ["Green"] = getObjectFromGUID('d390dc'),
        ["Yellow"] = getObjectFromGUID('77d7c8')
    }
}

leaderRandomizer = getObjectFromGUID("cf6ca1")
baseGameManualPosition = {-7.677, 0, -14.917}
-- parameter to set
waitTimeUntilBanDelete = 5 -- How many seconds banned leaders are shown to black, and other player must wait
numberOfBan = 6 -- default number of ban
leaderPickOrder = "4321"
--
leaderChoices = {} -- Table key:player color, value: GUID of leader picked : to adjust initial leader starting ressources when hidden pick is over
playerOrderToPickHidingStates = {} -- Sequence of value to assign to hidingState in global: anti-clokwise starting from player before first player
hiddenPicksOrderSet = false
leadersBanned = false

minimum_value_ban = 1 -- for number of ban buttons: value when Rise of Ix is by default on
maximum_value_ban = 10
-----------------End section------------------------

-------- Initialize Parameter ---------

button_offset_y = 0 -- Set number. Value greater than or equal to 0. Defaults to 0.10.
button_width = 2000 -- Set number. Defaults to 450.
button_height = 300 -- Set number. Defaults to 300.
button_color = {0.25, 0.25, 0.25} -- Set number {Red,Green,Blue}. Value bitween 0.00 to 1.00. Defaults to {1.00,1.00,1.00] ("White").
text_color = {1.00, 1.00, 1.00} -- Set number {Red,Green,Blue}. Value bitween 0.00 to 1.00. Defaults to {0.25,0.25,0.25] ("Black").
text_size = 200 -- Set number. Defaults to 100.

function onLoad(saved_data)

    self.interactable = false
    yellowscore.interactable = false
    greenscore.interactable = false
    bluescore.interactable = false
    redscore.interactable = false
    councellor_bonus_bag.interactable = false
    wormObj.setVar("gameStartTime",
                   os.date("!%m/%d/%Y %H:%M:%S", os.time(os.date("!*t"))))

    for _, obj in pairs(getObjectFromGUID("e88cd0").getObjects()) do
        obj.setInvisibleTo({
            "Red", "Blue", "Green", "Yellow", "White", "Grey", "Brown", "Pink",
            "Purple", "Orange"
        })
    end

    setupDone = false

    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        setupDone = loaded_data[1]
        submitGame = loaded_data[2]
        score_board = loaded_data[3]
        numPlayers = loaded_data[4]
        hotseat_mode = loaded_data[5]
        rise_of_ix = loaded_data[6]
        immortality = loaded_data[7]
        fpColor = loaded_data[8]
        leaderPickOrder = loaded_data[9]
    end

    if setupDone then

        local seated_players = getPlayersBasedOnHotseat()

        for _, color in pairs(seated_players) do
            for _, faction in pairs(pion_reput) do
                faction[color].setLock(true)
                faction[color].interactable = false
            end

            if immortality == 1 then
                tleilaxuTokens[color].interactable = false
                researchTokens[color].interactable = false
            end
            if rise_of_ix == 1 then cargo[color].interactable = false end
        end
    end

    if not setupDone or numPlayers > 2 then
        for _, obj in pairs(getObjectFromGUID("0e6313").getObjects()) do
            if obj.hasTag("AutomataStuff") then
                obj.setInvisibleTo({
                    "Red", "Blue", "Green", "Yellow", "White", "Grey", "Brown",
                    "Pink", "Purple", "Orange"
                })
            end
        end
    end

    if submitGame == 1 then
        wormObj.call("firstStep")
        wormObj.setVar("first_player", fpColor)
        wormObj.setVar("leaderPickOrder", leaderPickOrder)
    end

    if score_board == 1 then
        Wait.time(function() wormObj.call("setOpenScoreBoard") end, 3)
    end

    if not setupDone then
        clock_mode = 0
        submitGame = 0
        redAsFirstPlayer = 0
        wormObj.setVar("red_go_first", false)
        score_board = 0
        epic_mode = 0
        rise_of_ix = 1
        wormObj.setVar("rise_of_ix", true)
        immortality = 1
        wormObj.setVar("immortality", true)
        goTo11 = 1
        blitz = 0
        black_market = 0
        hiddenPicks = 0 -- New: if hidden pick is by default on or off

        -----------------Hidden Picks Var section------------------------
        leaders = constants.leaders

        -- leaders will be manipulated a lot: storing GUID only is a must
        leadersGUID = {
            leaders.yuna.GUID, leaders.hundro.GUID, leaders.memnon.GUID,
            leaders.ariana.GUID, leaders.ilesa.GUID, leaders.armand.GUID,
            leaders.paul.GUID, leaders.leto.GUID, leaders.tessia.GUID,
            leaders.rhombur.GUID, leaders.rabban.GUID, leaders.vladimir.GUID,
            leaders.ilban.GUID, leaders.helena.GUID
        }

        leaderPositions = {}

        -- initial positions of leaders on the table starting with top left Yuna, from left to right -- used to replace leaders on the table after moving them
        for i, leaderGuid in ipairs(leadersGUID) do
            leaderPositions[i] = getObjectFromGUID(leaderGuid).getPosition()
        end

        UI.show("setupPanel")
    end
end

function updateSave()
    local data_to_save = {
        setupDone, submitGame, score_board, numPlayers, hotseat_mode,
        rise_of_ix, immortality, fpColor, leaderPickOrder
    }
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function setPickOrder(player, option, id)
    broadcastToAll(player.steam_name .. " selected leader order: " .. option, undefined)
    leaderPickOrder = option
    wormObj.setVar("leaderPickOrder", leaderPickOrder)
    updateSave()
end

function setNumberOfBans(player, value, id)
    numberOfBan = tonumber(value)
    UI.setAttribute("displayNumberOfBans", "text",
                    "Leaders removed: " .. numberOfBan)
end

function toggleSubmitGame(player, status, id)
    if status == "True" then
        submitGame = 1
    else
        submitGame = 0
    end
end

function toggleStreamerMode(player, status, id)
    if status == "True" then
        score_board = 1
    else
        score_board = 0
    end
end

function toggleClockMode(player, status, id)
    if status == "True" then
        clock_mode = 1
    else
        clock_mode = 0
    end
end

function toggleEpicMode(player, status, id)
    if status == "True" then
        epic_mode = 1
        rise_of_ix = 1
        UI.setAttribute("riseOfIx", "isOn", "True")
        blitz = 0
        UI.setAttribute("blitz", "isOn", "false")
    else
        epic_mode = 0
    end
end

function toggleRiseOfIx(player, status, id)
    if status == "True" then
        rise_of_ix = 1
        wormObj.setVar("rise_of_ix", true)
        minimum_value_ban = 1 -- New: adjust number of ban since there is less leaders in base game
        maximum_value_ban = 10 -- New
        numberOfBan = math.ceil(2 * numberOfBan) -- New
        UI.setAttributes("numberOfBans", {
            minValue = minimum_value_ban,
            maxValue = maximum_value_ban,
            value = numberOfBan
        })
        UI.setAttribute("displayNumberOfBans", "text",
                        "Leaders removed: " .. numberOfBan)
    else
        rise_of_ix = 0
        wormObj.setVar("rise_of_ix", false)
        epic_mode = 0
        UI.setAttribute("epicMode", "isOn", "False")
        minimum_value_ban = 1 -- New
        maximum_value_ban = 4 -- New
        numberOfBan = math.floor(numberOfBan / 2.6) + 1 -- janky formula: conversion between # of ban base game vs rise of ix
        UI.setAttributes("numberOfBans", {
            minValue = minimum_value_ban,
            maxValue = maximum_value_ban,
            value = numberOfBan
        })
        UI.setAttribute("displayNumberOfBans", "text",
                        "Leaders removed: " .. numberOfBan)
    end
end

function toggleImmortality(player, status, id)
    if status == "True" then
        immortality = 1
        wormObj.setVar("immortality", true)
    else
        immortality = 0
        wormObj.setVar("immortality", false)
        goTo11 = 0
        UI.setAttribute("goTo11", "isOn", "False")
    end
end

function toggleGoTo11(player, status, id)
    if status == "True" then
        goTo11 = 1
        immortality = 1
        UI.setAttribute("immortality", "isOn", "True")
    else
        goTo11 = 0
    end
end

function toggleRedGoFirst(player, status, id)
    if status == "True" then
        redAsFirstPlayer = 1
        wormObj.setVar("red_go_first", true)
    else
        redAsFirstPlayer = 0
        wormObj.setVar("red_go_first", false)
    end
end

function toggleBlitz(player, status, id)
    if status == "True" then
        blitz = 1
        epic_mode = 0
        UI.setAttribute("epicMode", "isOn", "False")
    else
        blitz = 0
    end
end

function toggleBlackMarket(player, status, id)
    if status == "True" then
        black_market = 1
    else
        black_market = 0
    end
end

function toggleHiddenPicks(player, status, id)
    if status == "True" then
        hiddenPicks = 1
        UI.show("hiddenPicksOptions")
    else
        hiddenPicks = 0
        UI.hide("hiddenPicksOptions")
    end
end

--- Randomize players relocated here ---- 
isShufflePlayersExecuted = false

function shufflePlayers(player, value, id)

    if isShufflePlayersExecuted == true then 
        print("Shuffle was already pressed")
        return 
    end

    if Player[player.color].admin == false then 
        print("Player is not admin")
        return 
    end

    local randomizedColorList = {}
    local playerList = {}

    for key, player in ipairs(Player.getPlayers()) do
        table.insert(randomizedColorList, player.color)
        player.changeColor("Grey")
        table.insert(playerList, player)
    end

    -- Randomize the playerList
    local randomizedPlayerList = {}
    while #playerList > 0 do
        local index = math.random(1, #playerList)
        local player = table.remove(playerList, index)
        table.insert(randomizedPlayerList, player)
    end

    -- Assign colors to players\
    for i, player in ipairs(randomizedPlayerList) do
        local color = randomizedColorList[i]
        player.changeColor(color)
    end

    isShufflePlayersExecuted = true  

    UI.hide("shufflePlayers") 
end

--------------------------------

numPlayers = nil
hotseat_mode = false

function Presetup(player, value, id)
    local color = player.color
    local players = getSeatedPlayers()
    for _, color in pairs(players) do
        if color ~= "Red" and color ~= "Green" and color ~= "Blue" and color ~=
            "Yellow" then
            broadcastToAll(i18n("notSeated"), "White")
            return 1
        end
    end
    if #players == 1 then

        Player[color].showOptionsDialog(i18n("soloHotseat"),
                                        {"Solo", "Hotseat"}, "Solo",
                                        function(text, index, player_color)
            if text == "Hotseat" then
                hotseat_mode = true
                numPlayers = 4
                local hotseatBag = getObjectFromGUID("f65268")
                local hotseat = {
                    ["Red"] = {pos = {-28.6, 1.73, 17.32}},
                    ["Green"] = {pos = {28.6, 1.73, 17.32}},
                    ["Blue"] = {pos = {-28.6, 1.73, -4.90}},
                    ["Yellow"] = {pos = {28.6, 1.73, -4.90}}
                }

                for color, params in pairs(hotseat) do
                    local params1 = {}
                    params1.position = hotseat[color].pos
                    params1.rotation = {0, 0, 0}
                    params1.callback_function = function(obj)
                        obj.lock()
                    end
                    hotseatBag.takeObject(params1)
                end

            elseif text == "Solo" then
                numPlayers = 1
            end
            updateSave()
            Setup()
        end)
    else
        numPlayers = #players
        updateSave()
        Setup()
    end
end

function Setup()
    Global.call("resetRound")

    if clock_mode == 1 and numPlayers > 2 then
        broadcastToAll(i18n("clockModeActivated"), "Pink")

    elseif clock_mode == 1 and numPlayers < 3 then
        broadcastToAll(i18n("noClockMode"), "Orange")
        return 1
    end

    if submitGame == 1 and redAsFirstPlayer == 1 and numPlayers < 4 then
        broadcastToAll(i18n("noRedAsFirst"), "Orange")
        return 1
    end

    if numPlayers < 3 and blitz == 1 then
        broadcastToAll(i18n("notBlitz"), "Orange")
        return 1
    end
    UI.hide("setupPanel")

    if immortality == 0 and epic_mode == 0 then
        for i, zone in ipairs(dune_cards_decks_zone) do
            for _, obj in ipairs(zone.getObjects()) do
                if obj.type == "Deck" or obj.type == "Card" then
                    obj.flip()
                    obj.setPositionSmooth(pos_starter_decks[i], false, false)
                end
            end
        end
    end
    -- Setup Hagal
    local pos_hagal = {10.85, 3, 45.99}
    if numPlayers < 3 then
        for _, obj in pairs(getObjectFromGUID("0e6313").getObjects()) do
            obj.setInvisibleTo({})
        end
    end
    if numPlayers == 2 then
        hagal_2P.setPosition(pos_hagal)
        hagal_everytime_except_immortality_1P.setPosition(pos_hagal)
        if rise_of_ix == 0 then
            hagal_without_rise_of_ix.setPosition(pos_hagal)
        else
            hagal_rise_of_ix.setPosition(pos_hagal)
            hagal_rise_of_ix_2P.setPosition(pos_hagal)
        end
    elseif numPlayers == 1 then
        hagal_1P.setPosition(pos_hagal)
        if immortality == 1 then
            hagal_immortality_1P.setPosition(pos_hagal)
        else
            hagal_everytime_except_immortality_1P.setPosition(pos_hagal)
        end
        if rise_of_ix == 0 then
            hagal_without_rise_of_ix.setPosition(pos_hagal)
        else
            hagal_rise_of_ix.setPosition(pos_hagal)
            hagal_rise_of_ix_1P.setPosition(pos_hagal)
        end
    end

    if rise_of_ix == 0 then RemoveIxContent() end

    if rise_of_ix == 1 then
        getObjectFromGUID(intrigue_ix).setPosition(intrigue_pos)
        getObjectFromGUID(imperium_deck_ix).setPosition(imperium_pos)
        Wait.time(movetechdecks, 1)
    end

    if immortality == 0 then
        getObjectFromGUID(imperium_deck_immortality).destruct()
        getObjectFromGUID(intrigue_immortality).destruct()
        GetDeckOrCard(constants.zone_deck_tleilaxu).destruct()
        getObjectFromGUID(reclaimed_forces).destruct()

        for _, obj in ipairs(bene_tleilax_zone.getObjects()) do
            if obj.hasTag("BT Board") then obj.destruct() end
        end
        for _, ref in ipairs(atomics) do
            getObjectFromGUID(ref).destruct()
        end
        for _, ref in ipairs(experimentation_decks) do
            getObjectFromGUID(ref).destruct()
        end
        research_station_immortality.destruct()
        -- destroy acquire buttons of tleilaxu row
        getObjectFromGUID(constants.buy7_guid).destruct()
        getObjectFromGUID(constants.buy8_guid).destruct()
    end

    if immortality == 1 then
        getObjectFromGUID(intrigue_immortality).setPosition(intrigue_pos)
        getObjectFromGUID(imperium_deck_immortality).setPosition(imperium_pos)
        local deck = GetDeckOrCard(constants.zone_deck_tleilaxu)
        deck.shuffle()
        Wait.time(function()
            local params1 = {}
            params1.position = constants.tleilaxuRow[1].pos
            params1.rotation = {0.00, 180.00, 0.00}
            deck.takeObject(params1)
        end, 0.35)
        Wait.time(function()
            local params2 = {}
            params2.position = constants.tleilaxuRow[2].pos
            params2.rotation = {0.00, 180.00, 0.00}
            deck.takeObject(params2)
        end, 0.7)

        for _, zone in ipairs(dune_cards_decks_zone) do
            for _, obj in ipairs(zone.getObjects()) do
                if obj.type == "Deck" or obj.type == "Card" then
                    obj.destruct()
                end
            end
        end

        for i, ref in ipairs(experimentation_decks) do
            local deck = getObjectFromGUID(ref)
            deck.flip()
            deck.setPositionSmooth(pos_starter_decks[i], false, false)
        end

        research_station_immortality.setPosition({-0.09, 1.58, 2.10})
        research_station_immortality.setLock(true)
        -- Need to keep immo station interactable else the GET button of the normal station under will mess with the GET button of the new station
        -- research_station_immortality.interactable = false

    end

    if blitz == 0 and epic_mode == 0 then setupConflits(4, 5, 1) end

    if epic_mode == 0 then
        for _, ref in ipairs(epic_cards) do
            getObjectFromGUID(ref).destruct()
        end
    end

    if epic_mode == 1 then setupEpic() end

    if blitz == 1 then BlitzSetup() end

    if hiddenPicks == 1 then
        if numPlayers > 2 then -- setPlayerHiddenLeaderPickOrder have not been generalized enough to allow 2 player bans

            if rise_of_ix == 0 then

                leadersGUID = {
                    leaders.memnon.GUID, leaders.ariana.GUID, leaders.paul.GUID,
                    leaders.leto.GUID, leaders.rabban.GUID,
                    leaders.vladimir.GUID, leaders.ilban.GUID,
                    leaders.helena.GUID
                }

                leaderPositions = {}

                for i, leaderGuid in ipairs(leadersGUID) do
                    leaderPositions[i] =
                        getObjectFromGUID(leaderGuid).getPosition()
                end
            end

            Wait.time(moveAllLeadersToRandomizer, 1) -- move leader to randomizer for dramatic effect
            Wait.time(banRandomLeaders, 4) -- show, pause, then remove from game random leaders
            Wait.condition(replaceLeaders, -- remaining leader are replaced at the table in random order
                           function()
                return hiddenPicksOrderSet and leadersBanned
            end)
        else
            broadcastToAll(i18n("notHiddenPicks"), "White")
        end
    else
        if submitGame == 1 then wormObj.call("firstStep") end
    end

    if score_board == 1 then
        Wait.time(function() wormObj.call("setOpenScoreBoard") end, 3)
    end

    Wait.time(Commune, 3)
end

function Commune()

    destructMissingPlayers()
    GetDeckOrCard(zone_intrigue).shuffle()
    GetDeckOrCard(zone_imperium).shuffle()
    GetDeckOrCard('6d8a2e').shuffle()
    GetDeckOrCard('e6cfee').shuffle()
    GetDeckOrCard('907f66').shuffle()
    GetDeckOrCard('4f08fc').shuffle()
    Wait.time(ImperiumDeal, 0.5)
    Wait.time(function() getObjectFromGUID("cb0478").call("ConflictButton") end,
              3)
    Wait.time(startPickPlayer, 2)
    Wait.time(function()
        setupDone = true
        updateSave()
    end, 5)
end

function startPickPlayer()
    getObjectFromGUID("d84873").setInvisibleTo({})

    startLuaCoroutine(self, 'pick_a_player')
end

function pick_a_player()
    local fullPlayerList = Player.getPlayers()
    local count = 0
    local playerList = {}
    if hotseat_mode then
        playerList = {
            {color = "Blue"}, {color = "Red"}, {color = "Green"},
            {color = "Yellow"}
        }
        count = 4
    else
        for _, player in pairs(fullPlayerList) do
            if player.color == "Blue" or player.color == "Red" or player.color ==
                "Green" or player.color == "Yellow" then
                count = count + 1
                table.insert(playerList, player)
            end
        end
    end

    if count == 0 then
        broadcastToAll(i18n("noPlayers"))
        getObjectFromGUID("d84873").editButton({click_function = 'start'})

    elseif count == 1 then
        broadcastToAll(i18n("useDices"))
        marker.unlock()
        getObjectFromGUID("d84873").destruct()

    else
        local randomNumber = 0
        local firstPlayer = {}
        fpColor = ""

        if count == 4 and redAsFirstPlayer == 1 and submitGame == 1 then
            fpColor = "Red"
        else
            randomNumber = math.random(count)
            for i = 1, 10 do -- Animation débile avec 2 boucles XD 
                for index, player in ipairs(playerList) do
                    getObjectFromGUID("d84873").editButton({
                        color = player.color
                    })
                    wait(3)
                end
            end

            firstPlayer = playerList[randomNumber]
            fpColor = firstPlayer.color
        end
        wormObj.setVar("first_player", fpColor)
        updateSave()

        broadcastToAll(i18n('firstPlayerBeginning') .. fpColor .. '!', fpColor)
        if hotseat_mode then Player.getPlayers()[1].changeColor(fpColor) end

        -----------------New section------------------------
        if hiddenPicks == 1 then -- New: First player info necessary to determine leader picks player order
            local colorToPass = {fpColor}
            setPlayerHiddenLeaderPickOrder(colorToPass)
        end
        -----------------End section------------------------
        if not hotseat_mode then
            Turns.enable = true
            Turns.pass_turns = false
            Turns.turn_color = fpColor
        end
        Global.call("resetRound")
        marker.setPositionSmooth(position_marker[fpColor], false, false)
        getObjectFromGUID("d84873").destruct()
    end
    return 1 -- return pour la coroutine
end

function wait(numFrames) for i = 1, numFrames, 1 do coroutine.yield(0) end end

-----------------Setup New functions------------------------

-- called from First Player Picker when set up button is clicked: to find player leader pick order from first player and number of player
function setPlayerHiddenLeaderPickOrder(colorPassed)
    local firstPlayerColor = colorPassed[1]
    local arrayOfColor = {"Green", "Red", "Blue", "Yellow"}
    local arrayOfHidingStates = {1, 2, 3, 4} -- all possible hiding states value during pick phase: see Global
    if numPlayers == 4 then
        local indexFirstToPick = (findAnElementIndexInArray(firstPlayerColor,
                                                            arrayOfColor) %
                                     numPlayers) + 1
        local indexSecoundToPick = (indexFirstToPick % numPlayers) + 1
        local indexThirdToPick = (indexSecoundToPick % numPlayers) + 1
        local indexFourthToPick = (indexThirdToPick % numPlayers) + 1

        -- Indices mapping
        local indices = {
            indexFirstToPick, indexSecoundToPick, indexThirdToPick,
            indexFourthToPick
        }
        -- order of picking where 1 is last to pick, last number is the first to pick.
        local order = {
            5 - tonumber(leaderPickOrder:sub(1, 1)),
            5 - tonumber(leaderPickOrder:sub(2, 2)),
            5 - tonumber(leaderPickOrder:sub(3, 3)),
            5 - tonumber(leaderPickOrder:sub(4, 4))
        }

        for _, position in ipairs(order) do
            table.insert(playerOrderToPickHidingStates, indices[position])
        end
        hiddenPicksOrderSet = true
    elseif numPlayers == 3 then
        local missingColor = findMissingElements(arrayOfColor,
                                                 getPlayersBasedOnHotseat())[1]
        for i, color in ipairs(arrayOfColor) do
            if color == missingColor then
                table.remove(arrayOfHidingStates, i)
                table.remove(arrayOfColor, i)
            end
        end
        local indexFirstToPick = (findAnElementIndexInArray(firstPlayerColor,
                                                            arrayOfColor) %
                                     numPlayers) + 1
        for hiddingState in
            cyclicIterator(indexFirstToPick, arrayOfHidingStates) do
            table.insert(playerOrderToPickHidingStates, hiddingState)
        end
        hiddenPicksOrderSet = true
    end
end

function moveAllLeadersToRandomizer()
    local t = 0 -- similar to the function setting up tech on the board
    for _, leaderGUID in ipairs(leadersGUID) do
        Wait.time(function()
            leaderRandomizer.putObject(getObjectFromGUID(leaderGUID))
        end, t)
        t = t + 0.18
    end
    hidingStateToPass = {5} -- make leaders invisible to all but Black
    Global.call("setHidingState", hidingStateToPass)
end

function banRandomLeaders()
    broadcastToAll(i18n("hiddenPicksRemoving"):format(numberOfBan), "Orange")
    leaderRandomizer.shuffle()
    local leaderToDeleteTable = {} -- temp storing leader to move after banned showned leader are "destroyed"
    for i = 1, numberOfBan do
        local leaderToDelete = leaderRandomizer.takeObject({
            position = leaderPositions[i],
            rotation = {0, 180, 0},
            smooth = true
        })
        table.insert(leaderToDeleteTable, leaderToDelete)
        removeAnElementInArray(leaderToDelete.guid, leadersGUID) -- update available leader pool
    end

    for i = 1, numberOfBan do -- at first I tried to destroy leader, big mistake as it would make all my leader array nil
        destroyObject(leaderToDeleteTable[i]) -- then i tried storing only guid in leaders, still had errors. Then tried to move them in
        -- fakeDestroy(leaderToDeleteTable[i]) -- trash bag: turns out object in bags loses their GUID.Then, I tried to stack banned leader
    end -- and make them invisible, but black would still see them. Best solution was to stack them
    leadersBanned = true

    --[[Wait.time(function()
        for i = 1, numberOfBan do -- at first I tried to destroy leader, big mistake as it would make all my leader array nil
            destroyObject(leaderToDeleteTable[i])         --then i tried storing only guid in leaders, still had errors. Then tried to move them in
            -- fakeDestroy(leaderToDeleteTable[i]) -- trash bag: turns out object in bags loses their GUID.Then, I tried to stack banned leader
        end -- and make them invisible, but black would still see them. Best solution was to stack them
        leadersBanned = true
    end, -- inside the boardgame manual and lock them. Only asset thick enough to hide tiles. I call
              waitTimeUntilBanDelete -- this the "Hidden Assets" method :) Leader are sill loaded in memory, and GUID still exist.
    )]]
end

--[[function fakeDestroy(objectToDestroy)
    objectToDestroy.clearButtons()
    objectToDestroy.setPosition(baseGameManualPosition)
    objectToDestroy.locked = true
end]]

function replaceLeaders() -- called after ban phase and after player pick a leader
    local numberOfLeaderPicked = getLengthTable(leaderChoices)
    if numberOfLeaderPicked < numPlayers then -- increment hiding state from one
        hidingStateToPass = {
            playerOrderToPickHidingStates[numberOfLeaderPicked + 1]
        }
        Global.call("setHidingState", hidingStateToPass)
        local hidingStateToColorTable = {
            [1] = "Green",
            [2] = "Red",
            [3] = "Blue",
            [4] = "Yellow"
        }
        local color =
            hidingStateToColorTable[playerOrderToPickHidingStates[numberOfLeaderPicked +
                1]]
        Turns.turn_color = color
        broadcastToAll(i18n(color:lower()) .. i18n("hiddenPickingLeader"), color)
    else
        hidingStateToPass = {6} -- no more player to choose
        Global.call("setHidingState", hidingStateToPass)
        broadcastToAll(i18n("hiddenPickOver"))
        Turns.turn_color = fpColor
        if submitGame == 1 then wormObj.call("firstStep") end
    end
    leaderRandomizer.shuffle()
    for i = 1, #leadersGUID do
        leaderRandomizer.takeObject({
            position = leaderPositions[i],
            rotation = {0, 180, 0},
            smooth = true
        })
    end

end

function updateLeaderChoices(varPassed) -- called from the ClaimLeader in all standards Leaders: keep in memory leader picked
    removeAnElementInArray(varPassed.leaderSelectedGUID, leadersGUID) -- update available leader pool
    for _, leaderGUID in ipairs(leadersGUID) do -- put in randomizer+replace on the table between every leader picks: players still see cursor when other players pick
        leaderRandomizer.putObject(getObjectFromGUID(leaderGUID))
    end
    leaderChoices[varPassed.playerColor] = varPassed.leaderSelectedGUID -- update leader choices
    replaceLeaders()
    if numPlayers == getLengthTable(leaderChoices) then -- when all player picked: claim chosen Leader if it was a normal game (without hiddenPicks)+make them now visible
        hiddenPicks = 0
        for color, leaderChoiceGUID in pairs(leaderChoices) do
            varToPass = {GO = leaderChoiceGUID, color = color}
            getObjectFromGUID(leaderChoiceGUID).call("claimLeaderCall",
                                                     varToPass)
        end
    end
end

----------Utiliy functions--------------

function getLengthTable(table) -- determine size of an unordered table (#Table always give 0)
    length = 0
    for _, element in pairs(table) do length = length + 1 end
    return length
end

function findAnElementIndexInArray(element, arrayOfElements) -- return index (or nil) of an element in an array (with distinct value)
    local elementOrder = {}
    for i, v in ipairs(arrayOfElements) do elementOrder[v] = i end
    return elementOrder[element]
end

function cyclicIterator(first, Array) -- iterator that cycles through an entire array starting from any index
    i = -1
    return function() -- see closure + make your own iterator
        i = i + 1
        if i < #Array then
            return Array[(i + first - 1) % (#Array) + 1]
        else
            return nil
        end
    end
end

function findMissingElements(Array, ArrayWithMissingElement) -- used to compare find missing player color in 3 player game
    local A = {}
    local MissingElements = {}
    for _, element in ipairs(ArrayWithMissingElement) do A[element] = true end
    for _, element in ipairs(Array) do
        if A[element] == nil then table.insert(MissingElements, element) end
    end
    return MissingElements
end

function removeAnElementInArray(elementToDelete, arrayOfElements)
    for i, element in ipairs(arrayOfElements) do
        if element == elementToDelete then
            table.remove(arrayOfElements, i)
            return arrayOfElements
        end
    end
end
-----------------End section------------------------

function BlitzSetup()
    setupConflits(4, 3, 0)
    Wait.time(function()
        GetDeckOrCard(zone_intrigue).shuffle()
        GetDeckOrCard(zone_imperium).shuffle()

        getObjectFromGUID("e597dc").call("incrementVal")
        getObjectFromGUID("e597dc").call("incrementVal")
        getObjectFromGUID("c5c4ef").call("incrementVal")
        getObjectFromGUID("c5c4ef").call("incrementVal")
        getObjectFromGUID("fa5236").call("incrementVal")
        getObjectFromGUID("fa5236").call("incrementVal")
        getObjectFromGUID("576ccd").call("incrementVal")
        getObjectFromGUID("576ccd").call("incrementVal")

        local players = getPlayersBasedOnHotseat()

        for _, col in pairs(players) do

            GetDeckOrCard(zone_intrigue).deal(1, col)

            t = 0.1
            for i = 1, 7, 1 do
                Wait.time(function()
                    GetDeckOrCard(zone_imperium).deal(1, col)
                end, t)
                t = t + 0.1
            end

            for i = 1, 11, 1 do
                Wait.time(function() trash[col].deal(1, col) end, 1.6)
            end
        end
    end, 2)
end

function RemoveIxContent()
    -- supprimer et remplacer
    conflictThree.takeObject({position = pos_trash, index = 4})
    conflictTwo.takeObject({position = pos_trash, index = 10})
    conflictOne.takeObject({position = pos_trash, index = 4})
    conflictOne.takeObject({position = pos_trash, index = 4})

    Wait.time(function()
        getObjectFromGUID(intrigue_ix).destruct()
        getObjectFromGUID(imperium_deck_ix).destruct()

        getObjectFromGUID(leaders.yuna.GUID).destruct()
        getObjectFromGUID(leaders.hundro.GUID).destruct()
        getObjectFromGUID(leaders.ilesa.GUID).destruct()
        getObjectFromGUID(leaders.armand.GUID).destruct()
        getObjectFromGUID(leaders.tessia.GUID).destruct()
        getObjectFromGUID(leaders.rhombur.GUID).destruct()

        -- snoopers
        getObjectFromGUID("a58ce8").destruct()
        getObjectFromGUID("857f74").destruct()
        getObjectFromGUID("bed196").destruct()
        getObjectFromGUID("b10897").destruct()

        getObjectFromGUID("a8f306").destruct()
        getObjectFromGUID("1a3c82").destruct()
        getObjectFromGUID("a15087").destruct()
        getObjectFromGUID("734250").destruct()
        getObjectFromGUID("82789e").destruct()
        getObjectFromGUID("60f208").destruct()
        getObjectFromGUID("5469fb").destruct()
        getObjectFromGUID("71a414").destruct()
        getObjectFromGUID("3371d8").destruct()
        getObjectFromGUID("4575f3").destruct()
        getObjectFromGUID("7b3fa2").destruct()
        getObjectFromGUID("73a68f").destruct()
        getObjectFromGUID("366237").destruct()
        tech_tiles_en.destruct()
        tech_tiles_fr.destruct()
        getObjectFromGUID("d75455").destruct()

        getObjectFromGUID("e9096d").destruct()
        getObjectFromGUID("68e424").destruct()
        getObjectFromGUID("34281d").destruct()
        getObjectFromGUID("8fa76f").destruct()

        getObjectFromGUID("a139cd").setState(2)

    end, 0.1)

end

function setupConflits(a, b, c)
    conflictThree.shuffle()
    conflictTwo.shuffle()
    conflictOne.shuffle()
    nb_conflit_iii = GetDeckOrCard("07e239").getQuantity()
    if a < nb_conflit_iii then
        for i = 1, a do
            conflictThree.takeObject({
                position = {conflictDeckLocation[1], 2, conflictDeckLocation[3]}
            })
        end
        destroyObject(conflictThree.remainder)
    end
    if blitz == 1 then
        Wait.time(function()
            trash["Everyone"].takeObject({
                position = {
                    conflictDeckLocation[1], 2.3, conflictDeckLocation[3]
                },
                rotation = {0, 180, 180},
                smooth = false,
                guid = manigance
            })
        end, 0.9)
    end
    Wait.time(function()
        conflictTwo.shuffle()
        for i = 1, b do
            conflictTwo.takeObject({
                position = {
                    conflictDeckLocation[1], 2.6, conflictDeckLocation[3]
                }
            })
        end
        destroyObject(conflictTwo)
    end, 1)
    Wait.time(function()
        conflictOne.shuffle()
        if c ~= 0 then
            for i = 1, c do
                conflictOne.takeObject({
                    position = {
                        conflictDeckLocation[1], 3.2, conflictDeckLocation[3]
                    }
                })
            end
        end
        destroyObject(conflictOne)
    end, 2)
end

function setupEpic()
    setupConflits(5, 5, 0)
    replaceEpic()
end

function replaceEpic()

    if immortality == 0 then
        for i, zone in ipairs(dune_cards_decks_zone) do
            for _, obj in ipairs(zone.getObjects()) do
                if obj.type == "Deck" then
                    obj.takeObject({
                        position = pos_starter_decks[i],
                        smooth = false,
                        flip = true
                    })
                end
            end
        end

        -- Delete the only Dune card left wich is not a container anymore so could not delete it above

        Wait.time(function()
            for i, zone in ipairs(dune_cards_decks_zone) do
                for _, obj in ipairs(zone.getObjects()) do
                    if obj.type == "Card" then obj.destruct() end
                end
            end
        end, 0.5)

        for i, ref in ipairs(epic_cards) do
            local card = getObjectFromGUID(ref)
            card.flip()
            card.setPosition(pos_starter_decks[i])
        end
    else
        local i = 1
        for k, pos in pairs(pos_discard) do
            local card = getObjectFromGUID(epic_cards[i])
            card.setPosition(pos)
            card.setInvisibleTo({})
            i = i + 1
        end
    end

    Wait.time(movetroops, 2)
    Wait.time(function()
        GetDeckOrCard(zone_intrigue).shuffle()
        GetDeckOrCard(zone_intrigue).deal(1)
    end, 5)
end

function movetroops()

    redtroop1 = getObjectFromGUID("1bbf1c")
    redtroop2 = getObjectFromGUID("26904f")
    greentroop1 = getObjectFromGUID("a67287")
    greentroop2 = getObjectFromGUID("fc9c62")
    yellowtroop1 = getObjectFromGUID("b5d32e")
    yellowtroop2 = getObjectFromGUID("7c5b7b")
    bluetroop1 = getObjectFromGUID("f60d9c")
    bluetroop2 = getObjectFromGUID("694553")
    redtroop1.setPositionSmooth({1.28, 1.75, -3.42}, false, false)
    redtroop1.setRotation({0, 0, 0})
    redtroop2.setPositionSmooth({1.73, 1.75, -3.42}, false, false)
    redtroop2.setRotation({0, 0, 0})
    greentroop1.setPositionSmooth({7.91, 1.74, -3.42}, false, false)
    greentroop1.setRotation({0, 0, 0})
    greentroop2.setPositionSmooth({8.36, 1.74, -3.42}, false, false)
    greentroop2.setRotation({0, 0, 0})
    bluetroop1.setPositionSmooth({1.28, 1.75, -6.15}, false, false)
    bluetroop1.setRotation({0, 0, 0})
    bluetroop2.setPositionSmooth({1.73, 1.75, -6.15}, false, false)
    bluetroop2.setRotation({0, 0, 0})
    yellowtroop1.setPositionSmooth({7.91, 1.74, -6.15}, false, false)
    yellowtroop1.setRotation({0, 0, 0})
    yellowtroop2.setPositionSmooth({8.36, 1.74, -6.15}, false, false)
    yellowtroop2.setRotation({0, 0, 0})
end

function movetechdecks()
    local techs = nil
    if Global.getVar("locale") == 'en' then
        techs = tech_tiles_en
    elseif Global.getVar("locale") == 'fr' then
        techs = tech_tiles_fr
    end
    techs.randomize()
    local count = 0

    Wait.time(function()

        local pos1 = {9.26, 3, 16.87}
        local pos2 = {9.26, 3, 14.84}
        local pos3 = {9.26, 3, 12.78}

        count = count + 1

        if count < 6 then

            techs.takeObject({position = pos1, rotation = {0, 180, 180}})
            techs.takeObject({position = pos2, rotation = {0, 180, 180}})
            techs.takeObject({position = pos3, rotation = {0, 180, 180}})

        end

        if count == 6 then
            techs.takeObject({position = pos1, rotation = {0, 180, 0}})
            techs.takeObject({position = pos2, rotation = {0, 180, 0}})
            techs.takeObject({position = pos3, rotation = {0, 180, 0}})
            destroyObject(tech_tiles_en)
            destroyObject(tech_tiles_fr)

        end
    end, 0.25, 6)

end

function ImperiumDeal()
    local deck_imperium = GetDeckOrCard(zone_imperium)
    deck_imperium.shuffle()
    Wait.time(function()
        local params1 = {}
        params1.position = {-7.35, 2, 12.87}
        params1.rotation = {0.00, 180.00, 0.00}
        deck_imperium.takeObject(params1)
    end, 0.35)
    Wait.time(function()
        local params2 = {}
        params2.position = {-4.83, 2, 12.87}
        params2.rotation = {0.00, 180.00, 0.00}
        deck_imperium.takeObject(params2)
    end, 0.7)
    Wait.time(function()
        local params3 = {}
        params3.position = {-2.30, 2, 12.87}
        params3.rotation = {0.00, 180.00, 0.00}
        deck_imperium.takeObject(params3)
    end, 1.05)
    Wait.time(function()
        local params4 = {}
        params4.position = {0.29, 2, 12.87}
        params4.rotation = {0.00, 180.00, 0.00}
        deck_imperium.takeObject(params4)
    end, 1.4)
    Wait.time(function()
        local params5 = {}
        params5.position = {2.74, 2, 12.87}
        params5.rotation = {0.00, 180.00, 0.00}
        deck_imperium.takeObject(params5)
    end, 1.75)
    if black_market == 1 then
        getObjectFromGUID("ab7ac5").setPosition({-6.23, 1.50, 24.45})
        getObjectFromGUID("ab7ac5").setRotation({0, 180, 0})
        Wait.time(function()
            local params5 = {}
            params5.position = pos_black_market[1]
            params5.rotation = {0.00, 180.00, 0.00}
            deck_imperium.takeObject(params5)
        end, 2.1)
        Wait.time(function()
            local params5 = {}
            params5.position = pos_black_market[2]
            params5.rotation = {0.00, 180.00, 0.00}
            deck_imperium.takeObject(params5)
        end, 2.45)
        Wait.time(function()
            local params5 = {}
            params5.position = pos_black_market[3]
            params5.rotation = {0.00, 180.00, 0.00}
            deck_imperium.takeObject(params5)
        end, 2.8)
    end
end

function destructMissingPlayers()
    local seated_players = getPlayersBasedOnHotseat()

    for _, color in pairs(seated_players) do
        for _, faction in pairs(pion_reput) do
            faction[color].setLock(true)
            faction[color].interactable = false
        end

        if immortality == 1 then
            tleilaxuTokens[color].interactable = false
            researchTokens[color].interactable = false
        end
        if rise_of_ix == 1 then cargo[color].interactable = false end
    end

    if numPlayers < 4 or (goTo11 == 1 and immortality == 1) then
        destroyObject(FP1)
        destroyObject(FP2)
        destroyObject(FP3)
        destroyObject(FP4)
        yellowscore.setPositionSmooth({10.35, 2, -10.08})
        greenscore.setPositionSmooth({10.35, 3, -10.08})
        bluescore.setPositionSmooth({10.35, 5, -10.08})
        redscore.setPositionSmooth({10.35, 4, -10.08})
    end
    for color, _ in pairs(hand_players) do
        if hasValue(seated_players, color) == false then
            hand_players[color].destruct()
        end
    end
    Wait.time(function()
        for color, _ in pairs(table_players) do
            if hasValue(seated_players, color) == false then
                local objects = table_players[color]
                for i, obj in ipairs(objects) do
                    local obj1 = getObjectFromGUID(obj)
                    if obj1 ~= nil then
                        obj1.setPosition({0, 200, -50})
                        obj1.setLock(true)
                    end
                end
                break
            end
        end
    end, 2)
end

function hasValue(tab, val)
    for index, value in ipairs(tab) do if value == val then return index end end
    return false
end

function updateScores() if score_board == 1 then wormObj.call("updateScores") end end

function getPlayersBasedOnHotseat()
    local players = nil

    if hotseat_mode then
        players = {'Red', 'Blue', 'Green', 'Yellow'}
    else
        players = getSeatedPlayers()
    end

    return players
end

end)
__bundle_register("HelperModule", function(require, _LOADED, __bundle_register, __bundle_modules)
local helperModule = {}

constants = require("Constants")

drawDeckZone = constants.drawDeckZone

discardZone = constants.discardZone

drawSpot = constants.drawSpot

function helperModule.DrawOne(_, color)
    local starterDeck = helperModule.GetDeckOrCard(drawDeckZone[color])
    local discardFound = false

    if starterDeck ~= nil then
        starterDeck.deal(1, color)
    else
        discardFound = helperModule.ResetDiscard(_, color)
        if discardFound then
            Wait.time(function()
                local drawDeck = helperModule.GetDeckOrCard(drawDeckZone[color])
                drawDeck.deal(1, color)
            end, 1.5)
        else
            broadcastToColor("Missing one card to draw because your discard is empty", color, color)        
        end
    end
    return discardFound
end

function helperModule.ResetDiscard(_, color)
    discardArea = helperModule.GetDeckOrCard(discardZone[color])
    local discardFound = true
    if discardArea ~= nil then
        discardArea.setRotationSmooth({0, 180, 180}, false, false)
        discardArea.shuffle()
        discardArea.setPositionSmooth(drawSpot[color], false, true)
        Wait.time(function()
            helperModule.GetDeckOrCard(drawDeckZone[color]).shuffle()
        end, 0.5)
    else
        discardFound = false
    end

    return discardFound

end

function helperModule.GetDeckOrCard(zoneGUID)
    for _, obj in ipairs(getObjectFromGUID(zoneGUID).getObjects()) do
        if obj.type == "Card" or obj.type == "Deck" then return obj end
    end
    return nil
end

function helperModule.isDeckContainsEnough(color, numberToDraw)

    local starterDeck = helperModule.GetDeckOrCard(drawDeckZone[color])

    local enoughCards = true

    if starterDeck == nil then
        enoughCards = false
    else
        local countCheck = starterDeck.getQuantity()
        local typeCheck = starterDeck.type

        if typeCheck == "Card" then countCheck = 1 end

        if countCheck < numberToDraw then enoughCards = false end
    end

    return enoughCards
end

function helperModule.countRound()
    local conflictCardZone = getObjectFromGUID('07e239')
    local conflictCards = conflictCardZone.getObjects()[1]
    local round = 10
    if conflictCards ~= nil then
        if conflictCards.tag == 'Deck' then
            local cards = conflictCards.getObjects()
            return round - #cards
        elseif conflictCards.tag == 'Card' then
            return round - 1
        end
    end
end

return helperModule

end)
__bundle_register("Constants", function(require, _LOADED, __bundle_register, __bundle_modules)
local constants = {}

constants.setupObj = getObjectFromGUID("4a3e76")


constants.imperium_deck_ix = "58c4c3"
constants.imperium_deck_immortality = "88b666"
constants.tleilaxu_deck = "dcad54"
constants.reclaimed_forces = "3c772c"
constants.intrigue_immortality = "a5dbab"
constants.intrigue_ix = "afa5e5"
constants.intrigue_base = "77d25d"
constants.epic_cards = {'7ae7f5', 'fbaf9f', '497c84', '30b760'}

constants.vp_zone = {
    ["Red"] = getObjectFromGUID('5b9a53'),
    ["Blue"] = getObjectFromGUID('376f34'),
    ["Green"] = getObjectFromGUID('0e374f'),
    ["Yellow"] = getObjectFromGUID('b25c3c')
}

constants.leaderPos = {
    ["Yellow"] = {18.89, 2, -1.60},
    ["Green"] = {19.10, 2, 20.58},
    ["Blue"] = {-18.98, 2, -1.60},
    ["Red"] = {-19.23, 2, 20.35}
}

constants.leaders = {
    yuna = {GUID = "0b6322"},
    hundro = {GUID = "6e3714"},
    memnon = {GUID = "d9daed"},
    ariana = {GUID = "4d862a"},
    ilesa = {GUID = "158da6"},
    armand = {GUID = "796f0a"},
    paul = {GUID = "2df658"},
    leto = {GUID = "9b6cdc"},
    tessia = {GUID = "1839fa"},
    rhombur = {GUID = "691ca6"},
    rabban = {GUID = "4cf050"},
    vladimir = {GUID = "98cae8"},
    ilban = {GUID = "78551e"},
    helena = {GUID = "5a8a9a"},

    -- fan made
    vorian = {GUID = "0cffc9"},
    butler = {GUID = "c34187"},
    scytale = {GUID = "14dbb8"},
    wensicia = {GUID = "5d90ae"},
    irulan = {GUID = "514559"},
    norma = {GUID = "80b577"},
    miles = {GUID = "7bdba3"},
    feyd = {GUID = "84581f"},
    esmar = {GUID = "ec4142"},
    metulli = {GUID = "5133d2"},
    margot = {GUID = "a35523"},
    memnon2 = {GUID = "f3082c"},
    hasimir = {GUID = "bff714"},
    otto = {GUID = "97564a"},
    abulurd = {GUID = "4f8d56"},
    rhombur2 = {GUID = "835042"},
    farok = {GUID = "73e664"},
    darwi = {GUID = "2bf676"},
    xavier = {GUID = "83b4e1"},
    whitmore = {GUID = "c4d7e4"}

}

constants.ressources = { -- 1 : épices, 2 : solaris, 3 : eau, 4 : troupes, 5 : cartes, 6 : zone leader, 7 : swordmaster, 8 : zone swordmaster, 9 : conseiller, 10 : zone conseiller, 11 : zone bonus conseiller, 12 : zone conseiller vanilla
    ["Red"] = {getObjectFromGUID("3074d4"),getObjectFromGUID("576ccd"),getObjectFromGUID("692c4d"),getObjectFromGUID("8ea4af"),getObjectFromGUID("3a9e65"),getObjectFromGUID("66cdbb"),getObjectFromGUID("ed3490"),{-18.85, 1.71, 22.89},getObjectFromGUID("f19a48"),{-0.83, 3, 9.52},{-28.10, 2, 6.11},{-1.04, 3, 9.59}},
    ["Blue"] = {getObjectFromGUID("9cc286"),getObjectFromGUID("fa5236"),getObjectFromGUID("0afaeb"),getObjectFromGUID("b71dd9"),getObjectFromGUID("a0bb82"),getObjectFromGUID("681774"),getObjectFromGUID("a78ad7"),{-18.94, 1.71, 1.15},getObjectFromGUID("f5b14a"),{-1.57, 3, 9.52},{-28.25, 2, -15.73},{-1.76, 3, 9.59}},
    ["Green"] = {getObjectFromGUID("22478f"),getObjectFromGUID("e597dc"),getObjectFromGUID("fa9522"),getObjectFromGUID("126c3c"),getObjectFromGUID("c7fb9b"),getObjectFromGUID("cf1486"),getObjectFromGUID("fb1629"),{19.06, 1.66, 22.89},getObjectFromGUID("a0028d"),{0.82, 3, 9.52},{28.22, 2, 6.12},{0.63, 3, 9.59}},
    ["Yellow"] = {getObjectFromGUID("78fb8a"),getObjectFromGUID("c5c4ef"),getObjectFromGUID("f217d0"),getObjectFromGUID("6af67a"),getObjectFromGUID("17a08e"),getObjectFromGUID("a677e0"),getObjectFromGUID("635c49"),{18.85, 1.65, 1.15},getObjectFromGUID("1be491"),{1.55, 3, 9.52},{28.23, 2, -15.97},{1.35, 3, 9.59}}
}

constants.pos_discard = {
    ["Red"] = {-13.77, 3, 20.45},
    ["Blue"] = {-13.65, 3, -1.50},
    ["Green"] = {24.48, 3, 20.51},
    ["Yellow"] = {24.25, 3, -1.50}
}

constants.drawDeckZone = {
    ["Red"] = "4f08fc",
    ["Blue"] = "907f66",
    ["Green"] = "6d8a2e",
    ["Yellow"] = "e6cfee"
}

constants.drawSpot = {
    ["Red"] = {-24.65, 2.2, 20.36}, --location of draw snap
    ["Blue"] = {-24.38, 2.2, -1.50},
    ["Green"] = {13.68, 2.2, 20.52},
    ["Yellow"] = {13.54, 2.2, -1.50},
}
constants.discardZone = {
    ["Red"] = "e07493", --scripting zone for discard for red
    ["Blue"] = "26bf8b",
    ["Green"] = "2298aa",
    ["Yellow"] = "6bb3b6",
}
constants.zone_player = {
    ["Red"] = getObjectFromGUID('9555b8'), -- big scripting zone englobing all player space. Don't have the play card area.
    ["Blue"] = getObjectFromGUID('2d3346'),
    ["Green"] = getObjectFromGUID('546163'),
    ["Yellow"] = getObjectFromGUID('3d705e')
}

constants.playCardsZones = {
    ["Yellow"] = "ae1ef8",
    ["Green"] = "890115",
    ["Red"] = "cd9716",
    ["Blue"] = "f20a74"
}

constants.pos_black_market = {{-7.61, 2, 24.5}, {-5.05, 2, 24.5}, {-2.49, 2, 24.5}}

constants.pos_trash_upper = {-4.27, 5, 34.54}

constants.pos_trash_lower = {-1.92, 2, -19.65}

constants.first_player_marker = getObjectFromGUID("1f5576")

constants.first_player_positions =  {
    ["Red"] = {-13.73, 1.71, 23.79},
    ["Blue"] = {-13.79, 1.70, 1.92},
    ["Green"] = {13.71, 1.67, 24.20},
    ["Yellow"] = {13.49, 1.66, 1.92}
  }

constants.zone_deck_imperium = '8bd982'
constants.zone_deck_tleilaxu = '14b2ca'

constants.imperiumRow = {
    {zoneGuid = '3de1d0', pos = {-7.25, 2, 12.87}},
    {zoneGuid = '356e2c', pos = {-4.75, 2, 12.87}},
    {zoneGuid = '7edbb3', pos = {-2.25, 2, 12.87}},
    {zoneGuid = '641974', pos = {0.25, 2, 12.87}},
    {zoneGuid = 'c6dbed', pos = {2.75, 2, 12.87}}
}

constants.tleilaxuRow = {
    {zoneGuid = 'e5ba35', pos = {-7.59, 2, 20.04}},
    {zoneGuid = '1e5a32', pos = {-5.04, 2, 20.04}}
}

constants.buy7_guid = '439df9'
constants.buy8_guid = '363f98'

constants.zone_black_market = {"323acb","e96c10","93de6d"}

constants.reserve_troop_zone = {
    ["Red"] = getObjectFromGUID('ab8fdf'), -- inside reserve bowl: seems bit small
    ["Blue"] = getObjectFromGUID('2a520c'),
    ["Green"] = getObjectFromGUID('bdfade'),
    ["Yellow"] = getObjectFromGUID('ffbd81')
}

constants.pos_supply_bowls = {
    ["Red"] = {-24.63, 4.73, 23.89},
    ["Blue"] = {-24.26, 4.67, 1.96},
    ["Green"] = {24.77, 4.69, 23.89},
    ["Yellow"] = {24.45, 4.57, 1.98}
}

constants.pos_vp = {
    ["Red"] = {
        {-28.54, 2.5, 20.23}, {-28.57, 2.5, 21.26}, {-28.56, 2.5, 22.26},
        {-28.56, 2.5, 23.26}, {-28.56, 2.5, 24.28}, {-28.57, 2.5, 25.25},
        {-27.64, 2.5, 20.23}, {-27.62, 2.5, 21.26}, {-27.61, 2.5, 22.26},
        {-27.64, 2.5, 23.26}, {-27.61, 2.5, 24.28}, {-27.61, 2.5, 25.25},
        {-27.61, 4, 25.25}
    },
    ["Blue"] = {
        {-28.52, 2.5, -1.92}, {-28.54, 2.5, -0.89}, {-28.54, 2.5, 0.11},
        {-28.56, 2.5, 1.12}, {-28.54, 2.5, 2.14}, {-28.54, 2.5, 3.11},
        {-27.62, 2.5, -1.92}, {-27.6, 2.5, -0.89}, {-27.59, 2.5, 0.11},
        {-27.61, 2.5, 1.12}, {-27.59, 2.5, 2.14}, {-27.59, 2.5, 3.11},
        {-27.59, 4, 3.11}
    },
    ["Green"] = {
        {27.67, 2.5, 20.14}, {27.65, 2.5, 21.17}, {27.65, 2.5, 22.17},
        {27.65, 2.5, 23.18}, {27.65, 2.5, 24.19}, {27.65, 2.5, 25.16},
        {28.57, 2.5, 20.14}, {28.59, 2.5, 21.17}, {28.6, 2.5, 22.17},
        {28.58, 2.5, 23.18}, {28.6, 2.5, 24.19}, {28.6, 2.5, 25.16},
        {28.6, 4, 25.16}
    },
    ["Yellow"] = {
        {27.62, 2.5, -2.10}, {27.6, 2.5, -1.08}, {27.61, 2.5, -0.07},
        {27.6, 2.5, 0.93}, {27.61, 2.5, 1.95}, {27.6, 2.5, 2.92},
        {28.53, 2.5, -2.10}, {28.55, 2.5, -1.08}, {28.55, 2.5, -0.07},
        {28.53, 2.5, 0.93}, {28.56, 2.5, 1.95}, {28.56, 2.5, 2.92},
        {28.56, 4, 2.92}
    }
}

constants.tleilaxuTokens = {
    ["Red"] = getObjectFromGUID("2bfc39"),
    ["Blue"] = getObjectFromGUID("96607f"),
    ["Green"] = getObjectFromGUID("63d39f"),
    ["Yellow"] = getObjectFromGUID("d20bcf")
}

constants.researchTokens = {
    ["Red"] = getObjectFromGUID("39e0f3"),
    ["Blue"] = getObjectFromGUID("292658"),
    ["Green"] = getObjectFromGUID("658b17"),
    ["Yellow"] = getObjectFromGUID("8988cf")
}

constants.cargo = {
    ["Yellow"] = getObjectFromGUID("8fa76f"),
    ["Green"] = getObjectFromGUID("34281d"),
    ["Blue"] = getObjectFromGUID("68e424"),
    ["Red"] = getObjectFromGUID("e9096d")
}

constants.API_ENDPOINT_WEB = "https://webhook.site/e8e22e34-bb9c-47d8-947c-062ae020359d"
constants.API_ENDPOINT_BASE_URL = "http://dunerank.servehttp.com:8080"
constants.API_GAME_SUBMIT = "/game/submit"
constants.API_GAME_TOKEN = "/game/request-game-token?steamName="

constants.PLAYER_COLORS = {"Red", "Green", "Yellow", "Blue"}
constants.COLOR_ORDER = {
    Red = {"1", "2", "3", "4"},
    Green = {"2", "3", "4", "1"},
    Yellow = {"3", "4", "1", "2"},
    Blue = {"4", "1", "2", "3"}
}

return constants

end)
__bundle_register("locales", function(require, _LOADED, __bundle_register, __bundle_modules)
local i18n = require("i18n") -- remove this line if on the same file as before

i18n.locales.en = {
    et = " and",
    noTouch = "Don't touch this button!",
    noAgent = "You didn't send any Agent!",
    noWater = "You don't have enough Water.",
    drawOneCard = " draws a card.",
    imperialBasin = "%s has collected %s Spices in the Imperial Basin",
    imperialBasinDraw = "%s draws 1 card from the Imperial Basin.",
    haggaBasin = "%s has collected %s Spices for 1 Water in the Hagga Basin",
    haggaBasinDraw = "%s draws 1 card from the Hagga Basin.",
    greatFlat = "%s has collected %s Spices for 2 Waters on the Great Flat",
    greatFlatDraw = "%s draws 1 card from the Great Flat.",
    stillSuits = "%s got a Water from Stillsuits.",
    hardyWarriors = "%s got 2 Troops for a Water with the Hardy Warriors.",
    secrets = "%s got an Intrigue from Secrets.",
    noSpice = "You don't have enough Spice.",
    selectiveBreeding = "%s paid 2 Spices to do a Selective Breeding.",
    foldspace = "%s acquired a Foldspace card.",
    heighliner = "%s got 5 Troops and 2 Waters for 6 Spices with the Heighliner.",
    wealth = " %s got %s Solaris from Wealth.",
    conspire = "%s Conspires and got 2 Troops, %s Solaris and an Intrigue for 4 Spices.",
    reputUp = "%s increased their %s Faction Reputation.",
    reputMax = "Max Reputation attained.",
    reputDown = "%s decreased their %s Faction Reputation.",
    reputMin = "Reputation cannot be reduced more!",
    fremen = "Fremen",
    beneGesserit = "Bene Gesserit",
    emperor = "Emperor",
    spacingGuild = "Spacing Guild",
    loseAlliance = "%s lose the %s Alliance cause of their Reputation going down.",
    tiedAlliance = "2 or more players are tied for the %s Alliance. Choose a tied player to give your Alliance to.",
    recoverAlliance = "%s recover the %s Alliance.",
    sietchTabr = "%s got a Water and a Troop at Sietch Tabr.",
    researchStation = "%s draws %s cards for 2 Waters at the Research Station",
    researchStationPayOnly = "%s pays 2 Waters at the Research Station",
    researchStationDraw = "%s draws %s cards from the Research Station",
    advanceResearch = " and advance 1 time on the Research Track",
    researchMaxed = " cause Research is maxed out",
    carthag = "%s got an Intrigue and a Troop at Carthag.",
    arrakeen = "%s got a Troop and draws a Card at Arrakeen.",
    arrakeenTroopOnly = "%s got a Troop at Arrakeen.",
    arrakeenDraw = "%s draws a Card at Arrakeen.",
    noSolari = "You don't have enough Solari.",
    ilbanDraw = "%s draws a card for paying Solaris on a green space.",
    swordMaster = "%s got the Swordmaster for %s Solaris",
    mentatPayment = " pay %s Solaris",
    mentatToken = " to gain the Mentat",
    mentatAlreadyTaken = "The Mentat is already taken, do you still want to use this Space to just draw cards ?",    
    mentatIlbanDraw = " draws 2 cards.",
    highCouncil = "%s obtained a seat on the High Council for %s Solaris",
    secureContract = "%s Secures a Contract and get 3 Solaris.",
    sellMelange = "%s sold %s Spices to get %s Solaris.",
    rallyTroops = "%s Rallies 4 troops for %s Solaris",
    oratory = "%s got a Troop and a Persuasion at the Hall of Oratory.",
    dreadBuy = "%s acquired a Dreadnought for %s Solaris and can buy a Tech.",
    smugglingUp = "%s got %s from Smuggling and advances their Cargo.",
    smugglingDown = "%s got %s from Smuggling and brought their Cargo to the base.",
    shippingSolari = "%s chose to get %s Solaris through the Shipping Track.",
    shippingSpice = "%s chose to get 2 Spices through the Shipping Track.",
    shippingTroops = "%s recruited 2 Troops through the Shipping Track.",
    troopTransport = "%s recruited 3 Troops with the Troop Transports Technology and can deploy them immediately.",
    dividends = "Each other player earns 1 Solari from their CHOAM shares.",
    fremenBonus = "%s got a Water thanks to their good reputation with the Fremens.",
    beneBonus = "%s got an Intrigue thanks to their good reputation with the Bene Gesserit.",
    spaceBonus = "%s got %s Solaris thanks to their good reputation with the Spacing Guild.",
    emperorBonus = "%s got 2 Troops thanks to their good reputation with the Emperor.",
    flagBasin = " got 1 Spice for occupying the Imperial Basin.",
    flagArrakeen = " got %s Solari for occupying Arrakeen.",
    flagCarthag = " got %s Solari for occupying Carthag.",
    fenrig = " draws an additional Intrigue and must trash an Intrigue.",
    isDecidingToDraw = "%s is deciding wether to draw cards right away or not cause their discard will be reshuffled.",
    warningBeforeDraw = "Warning: Your discard will be reshuffled. Do you want to draw %s %s right away ? (You will have to draw manually if you cancel)",
    dialogCardAbove = "Do you want to put the card on top of your deck ? (Ok = yes, Cancel = No)",
    toolTipDecreaseRep = "Decrease Reputation",
    toolTipIncreaseRep = "Increase Reputation",
    revealButton = "Reveal Turn",
    resetDiscardButton = "Reset Discard",
    drawFiveButton = "+ Draw 5 Cards +",
    drawOneButton = "Draw 1 Card",
    passButton = "Pass\nRound",
    revealNotTurn = "You can't Reveal while it's not your turn.",
    fightWarning = "LET'S FIGHT !",
    defenseTroop = "%s gets a Defense Troop in the Conflict.",
    playerActing = " (action done by %s Player)",    
    yellow = "Yellow",
    blue = "Blue",
    red = "Red",
    green = "Green",
    spice = "Spice",
    solari= "Solari",
    water = "Water",
    spices = "Spices",
    solaris= "Solaris",
    waters = "Waters",
    spentManually = "%s spent %s %s manually.",
    receiveManually = "%s received %s %s manually.",
    acquireButton = "Acquire",
    noFoldspaceLeft = "Spacing guild is out of spice to sniff for folding space!",
    noLiaisonLeft = "No more hooded friends for you!",
    noTSMFLeft = "No more worms for you!",
    drawIntrigueButton = "Draw",
    addTroopBigButton = "Add a\ntroop in\ngarrison",
    addTroopSmallButton = "+1 troop",
    addTroop = "%s add a troop in Garrison",
    troop = " Troop",
    troops = " Troops",
    atomics = "Atomics",
    atomicsConfirm = "Nuke them from orbit ?!!!!",
    yes = "Yes",
    no = "No",
    atomicsUsed = " used their Atomics, it was the only way to be sure !!",
    researchUpButtonTooltip = "Advance up-right on Research",
    researchDownButtonTooltip = "Advance down-right on Research",
    researchBackToolTip = "Back up on Research Track",
    researchIncreased = "%s advanced on the Research Track.",
    researchDecreased = "%s rollBacked on the Research Track.",
    researchTopMost = "Cannot Move Up, you are at a topmost Hex.",
    researchBottomMost = "Cannot Move Down, you are at a bottommost Hex.",
    researchEnd = "Cannot Advance any more, you are at a Max research !!",
    researchStartingPos = "Cannot Rollback any more, you are at a starting position !!",
    researchSpecimen = "%s get a Specimen from the Research Track.",
    researchSpecimenBeetle = "%s get a Specimen and advance on the the Tleilaxu Track thanks to the Research Track.",
    researchSpecimenTrash = "%s get a Specimen and can Trash one card thanks to the Research Track.",
    researchBeetle =  "%s advance on the the Tleilaxu Track thanks to the Research Track.",
    researchIncome = "%s gain %s from the Research Track.",
    researchFaction = "%s gain 1 Faction Influence of their choice thanks to the Research Track.",
    researchTrashIntrigue = "%s can Trash one Intrigue to get another Intrigue and draw an Imperium card thanks to the Research Track.",
    researchAgain = "%s get another Research thanks to the Research Track.",
    confirmSolarisToBeetles = "Do you want to pay 7 Solaris to Advance Twice on the Tleilaxu Track ?",
    researchSolarisToBeetles = "%s paid 7 Solaris on the Research Track to Advance twice on the Tleilaxu Track.",
    addSpecimen = "+1 Specimen",
    spentSpecimen = "-1 Specimen",
    tleilaxuButtonTooltip = "Advance on Tleilaxu Track",
    tleilaxuBackTooltip = "Back up on the Tleilaxu Track",
    tleilaxuIncreased = "%s advanced on the Tleilaxu Track.",
    tleilaxuDecreased = "%s backed up on the Tleilaxu Track.",
    tleilaxuMax = "You already maxed out the Tleilaxu Track.",
    rollbackWarning = "This feature is only for emergency rollback due to mistake (You cannot go back in immortality rules). Do you really mean to do this ?",
    specimenAdded = "%s added a Specimen",
    specimenLimitWarning = "You cannot place more than 6 specimens with the automated script cause of the limited space on the board !!",
    addSpecimenManually = "Place your specimen manually !!",
    specimenRemoved = "%s removed a Specimen",
    tleilaxuIntrigue = "%s draw an Intrigue thanks to the Tleilaxu Track.",
    tleilaxuVP = "%s got a VP from the Tleilaxu Track.",
    tleilaxuSpice = "%s has collected 2 Spices from the Tleilaxu Track.",
    spiceGreatFlat = "A Bonus Spice appeared on THE GREAT FLAT.",
    spiceHaggaBasin = "A Bonus Spice appeared in the HAGGA BASIN.",
    spiceImperialBasin = "A Bonus Spice appeared in the IMPERIAL BASIN.",
    nextRound = "-------------- NEXT ROUND ----------------",
    holtzmanEngine = " draws a card thanks to the Holtzman Engine",
    shuttleFleet = " get 2 Solaris thanks to the Shuttle Fleet",
    holtzmanEffect = " draws a card thanks to their Holtzman Effect",
    drawFive = "Draw 5 Cards",
    playersTurn = "PLAYERS TURN",
    firstPlayer = 'The First Player is now ',
    willBe = "%s will be %s !",
    cantClaimLeader = "You can't claim Leader until you're seated!",
    claimLeaderButton = "Claim Leader",
    drawIntrigue = " draws an Intrigue card",
    revealFirstConflictButton = "Reveal\nFirst\nConflict",
    revealFirstConflictTooltip = "Reveal after everyone has chosen a Leader",
    chooseLeaderFirst = "Choose Leaders Before Revealing !",
    noPlayers = "There is no seated players.",
    useDices = "Use another way to determine the First Player.\n(There is some dices on the board)",
    firstPlayerBeginning = 'The First Player will be ',
    hiddenPicksTooltip = "Pick secretly a Leader (NO FAN MADE)",
    scoreBoardTooltip = "Visible only to the Black viewer",
    hiddenPicksNumberBanishedTooltip = "Number of Leaders randomly banished",
    notSeated = "Some players have unauthorized colors,\nplease sit at the table or become spectators.",
    notBlitz = "Not enough players to play Blitz",
    notHiddenPicks = "Not enough players to play with hidden picks",
    hiddenPicksRemoving = "Currently randomly removing %s leaders from the game!",
    hiddenPickingLeader = " is currently picking their leader.",
    hiddenPickOver = "Pick phase is over. Good luck, have fun!",
    notReputation = "You don't have the required reputation.",
    acquiredTleilaxu = "%s Acquired a Tleilaxu card for %s %s.",
    notEnoughSpecimen = "You don't have enough Specimens.",
    reclaimedForcesTroops = " spent 3 Specimens to get 2 Troops in Garrison.",
    reclaimedForcesScarab = " spent 3 Specimens to advance on the Tleilaxu Track.",
    reclaimedForcesTroopsWarning = "Do you really want to spend 3 Specimens to add Troops in Garrison ?",
    reclaimedForcesScarabWarning = "Do you really want to spend 3 Specimens to advance on the Tleilaxu Track ?",
    revealWarning = "Do you really want to Reveal ? You still have an Agent.",
    nope = "You can't do this.",
    commercialUpUp = " advances their freighter twice on the commercial track.",
    commercialUpDown = " advances their freighter on the commercial track and recall it at home.",
    commercialDownUp = " brought their cargo back to base and then drove it away.",
    commercialUp = " advances their freighter on the commercial track.",
    commercialDown = " brought their cargo back to base.",
    revealEarlyConfirm = "Reveal Hand ?",
    soloHotseat = "Do you want to play Solo or Hotseat ?",
    card = "card",
    cards = "cards",
    specimen = "Specimen",
    specimens = "Specimens",
    agentTurn = "Agent Turn",
    putTechHere = "Tech Board\n(put Tech tiles here)",
    selectSound = "Select Combat Sound",
    soundOn = "Sound [✓]",
    soundOff = "Sound [   ]",
    prescienceButton = "Prescience",
    prescienceTooltip = "Look at top card of deck easily with this",
    prescienceUsed = "%s used their Prescience to look into the future.",
    prescienceVoid = "All you see is the void. (Deck empty actually)",
    prescienceManual = "You need to peek manually (ALT + SHIFT) because there is only one card in your deck.",
    addNegotiator = "+1 Negotiator",
    spendNegotiator = "-1 Negotiator",
    negotiatorAdded = "%s added a Negotiator",
    negotiatorRemoved = "%s removed a Negotiator",
    negotiatorLimitWarning = "You cannot place more than 4 Negotiators with the automated script cause of the limited space on the board !!",
    addNegotiatorManually = "Place your Negotiator manually !!",
    noClockMode = "Need 3 players at least for Clock Mode !",
    clockModeActivated = "Clock Mode activated, Clocks will appear after First Conflict is Revealed.",
    noRedAsFirst = "Need 4 players to set up Red as first player without random pick."
}

i18n.locales.fr = {
    et = " et",
    noTouch = "Ne touchez pas à ce bouton!",
    noAgent = "Vous n'avez pas envoyé d'Agent!",
    noWater = "Vous n'avez pas assez d'Eau.",
    drawOneCard = " pioche une carte.",
    imperialBasin = "%s a collecté %s Épices dans le Bassin Impérial",
    imperialBasinDraw = "%s pioche 1 carte depuis le Bassin Impérial.",
    haggaBasin = "%s a collecté %s Épices pour 1 Eau dans le Bassin d'Hagga",
    haggaBasinDraw = "%s pioche 1 carte depuis le Bassin d'Hagga.",
    greatFlat = "%s a collecté %s Épices pour 2 Eaux sur la Grande Étendue",
    greatFlatDraw = "%s pioche 1 carte depuis la Grande Étendue.",
    stillSuits = "%s reçoit une Eau des Distilles.",
    hardyWarriors = "%s a obtenu 2 Troupes pour une Eau avec les Guerriers Endurcis.",
    secrets = "%s a obtenu une carte Intrigue grâce aux Secrets.",
    noSpice = "Vous n'avez pas assez d'Épice.",
    selectiveBreeding = "%s a payé 2 Épices pour faire une Reproduction sélective.",
    foldspace = "%s a acquis une carte Espace Plissé.",
    heighliner = "%s a obtenu 5 Troupes et 2 Eaux pour 6 Épices avec le Long Courrier.",
    wealth = "%s a obtenu %s Solaris grâce à la Richesse.",
    conspire = "%s Conspire et obtient 2 Troupes, %s Solaris et une Intrigue pour 4 Épices.",
    reputUp = "%s a augmenté sa Réputation avec la Faction %s.",
    reputMax = "Réputation maximale atteinte.",
    reputDown = "%s a diminué sa Réputation avec la Faction %s.",
    reputMin = "La réputation ne peut être réduite plus bas!",
    fremen = "Fremen",
    beneGesserit = "Bene Gesserit",
    emperor = "Empereur",
    spacingGuild = "Guilde Spatiale",
    loseAlliance = "%s perd l'Alliance %s à cause de sa Réputation qui baisse.",
    tiedAlliance = "2 joueurs ou plus sont à égalité pour l'Alliance %s. Choisissez un joueur à égalité pour lui donner votre Alliance.",
    recoverAlliance = "%s récupère l'Alliance %s.",
    sietchTabr = "%s a obtenu une Eau et une Troupe au Sietch Tabr.",
    researchStation = "%s pioche %s cartes pour 2 Eaux à la Station de Recherche",
    researchStationPayOnly = "%s paye 2 Eaux à la Station de Recherche",
    researchStationDraw = "%s pioche %s cartes depuis la Station de Recherche",
    advanceResearch = " et avance 1 fois sur la Piste Recherche",
    researchMaxed = " car la Recherche est au maximum",
    carthag = "%s a obtenu une Intrigue et une Troupe à Carthag.",
    arrakeen = "%s a reçu une troupe et pioche une carte à Arrakeen.",
    arrakeenTroopOnly = "%s a reçu une troupe à Arrakeen.",
    arrakeenDraw = "%s pioche une carte à Arrakeen.",
    noSolari = "Vous n'avez pas assez de Solari.",
    ilbanDraw = "%s pioche une carte pour avoir payé des Solaris sur une case verte.",
    swordMaster = "%s a obtenu le Maître d'Armes pour %s Solaris",
    mentatPayment = " paye %s Solaris",
    mentatToken = " pour obtenir le Mentat",    
    mentatAlreadyTaken = "Le Mentat est déjà pris, voulez-vous malgré tout utiliser cette case pour juste piocher des cartes ?",  
    mentatIlbanDraw = " pioche 2 cartes.",
    highCouncil = "%s a obtenu un siège au Haut Conseil pour %s Solaris",
    secureContract = "%s Sécurise un Contrat et obtient 3 Solaris.",
    sellMelange = "%s a vendu %s Épices pour obtenir %s Solaris.",
    rallyTroops = "%s Rallie 4 troupes pour %s Solaris",
    oratory = "%s a obtenu une Troupe et une Persuasion à la Salle de l'Oratoire.",
    dreadBuy = "%s a acquis un Cuirassé pour %s Solaris et peut acheter une Technologie.",
    smugglingUp = "%s a obtenu %s de la Contrebande et avance son Cargo.",
    smugglingDown = "%s a obtenu %s de la Contrebande et rappelle son Cargo à la base.",
    shippingSolari = "%s a choisi de gagner %s Solaris via la Piste Commerciale.",
    shippingSpice = "%s a choisi de gagner 2 Épices via la Piste Commerciale.",
    shippingTroops = "%s a recruté 2 Troupes via la Piste Commerciale.",
    troopTransport = "%s a recruté 3 Troupes grâce à la Technologie Transport de Troupes et peut les déployer immédiatement.",
    dividends = "Chaque autre joueur gagne 1 Solari grâce à leurs parts de la CHOAM.",
    fremenBonus = "%s a obtenu une Eau grâce à sa bonne réputation auprès des Fremens.",
    beneBonus = "%s a obtenu une Intrigue grâce à sa bonne réputation auprès du Bene Gesserit.",
    spaceBonus = "%s a obtenu %s Solaris grâce à sa bonne réputation auprès de la Guilde Spatiale.",
    emperorBonus = "%s a obtenu 2 Troupes grâce à sa bonne réputation auprès de l'Empereur.",
    flagBasin = " a obtenu 1 Épice pour avoir occupé le Bassin Impérial.",
    flagArrakeen = " a obtenu %s Solari pour l'occupation d'Arrakeen.",
    flagCarthag = " a obtenu %s Solari pour l'occupation de Carthag.",
    fenrig = " pioche une Intrigue supplémentaire et doit détruire une Intrigue.",
    isDecidingToDraw = "%s est en train de décider de piocher des cartes tout de suite ou non car sa défausse va être remélangée.",
    warningBeforeDraw = "Attention : Votre défausse va être remélangée. Voulez-vous piocher %s %s tout de suite ? (Vous devrez piocher manuellement si vous annulez)",
    dialogCardAbove = "Voulez-vous mettre la carte sur le dessus de votre paquet ? (Ok = oui, Cancel = non)",
    toolTipDecreaseRep = "Diminuer la Réputation",
    toolTipIncreaseRep = "Augmenter la Réputation",
    revealButton = "Révélation",
    resetDiscardButton = "Reset Défausse",
    drawFiveButton = "+ Piocher 5 Cartes +",
    drawOneButton = "Piocher 1 Carte",
    passButton = "Fin de\nManche",
    revealNotTurn = "Vous ne pouvez pas Révéler en dehors de votre tour.",
    fightWarning = "LA BAGARRE !",
    defenseTroop = "%s obtient une Troupe de défense dans le Conflit.",
    playerActing = " (action effectuée par le joueur %s)",
    yellow = "Jaune",
    blue = "Bleu",
    red = "Rouge",
    green = "Vert",
    spice = "Épice",
    solari= "Solari",
    water = "Eau",
    spices = "Épices",
    solaris = "Solaris",
    waters = "Eaux",
    spentManually = "%s dépense %s %s manuellement.",
    receiveManually = "%s reçoit %s %s manuellement.",
    acquireButton = "Acquérir",
    noFoldspaceLeft = "La Guilde Spatiale n'a plus d'épices à renifler pour plier l'Espace !",   
    noLiaisonLeft = "Plus d'amis encapuchonnés pour vous!",
    noTSMFLeft = "Plus de vers de terre pour vous!",
    drawIntrigueButton = "Piocher",
    addTroopBigButton = "Ajoute\nune troupe\nen garnison",
    addTroopSmallButton = "+1 troupe",
    addTroop = "%s ajoute une troupe en Garnison",
    troop = " Troupe",
    troops = " Troupes",
    atomics = "Atomiser",
    atomicsConfirm = "Confirmer l'Atomisation",
    yes = "Oui",
    no = "Non",
    atomicsUsed = " a utilisé ses Atomiques pour éradiquer l'Impérium d'un coup.",
    researchUpButtonTooltip = "Avancer vers le haut sur la Recherche",
    researchDownButtonTooltip = "Avancer vers le bas sur la Recherche",
    researchBackToolTip = "Reculer sur la Piste Recherche",
    researchIncreased = "%s a avancé sur la Piste Recherche.",
    researchDecreased = "%s est revenu en arrière sur la Piste Recherche.",
    researchTopMost = "Impossible d'aller plus vers le haut, votre jeton recherche est déjà sur un Hexagone tout au dessus.",
    researchBottomMost = "Impossible d'aller plus vers plus le bas, votre jeton recherche est déjà sur un Hexagone tout en bas.",
    researchEnd = "Vous ne pouvez plus avancer, vous êtes au maximum de la Recherche !!",
    researchStartingPos = "Vous ne pouvez plus faire de Rollback, vous êtes sur la position de départ !!",
    researchSpecimen = "%s obtient un Spécimen depuis la Piste de Recherche.",
    researchSpecimenBeetle = "%s obtient un Spécimen et avance sur la Piste Tleilaxu grâce à la Piste de Recherche.",
    researchSpecimenTrash = "%s obtient un Spécimen et peut Détruire une carte grâce à la Piste de Recherche.",
    researchBeetle =  "%s avance sur la Piste Tleilaxu grâce à la Piste de Recherche.",
    researchIncome = "%s gagne %s depuis la Piste de Recherche.",
    researchFaction = "%s gagne 1 Influence de Faction au choix grâce à la Piste de Recherche.",
    researchTrashIntrigue = "%s peut Détruire une Intrigue pour obtenir une autre Intrigue et piocher une carte Imperium grâce à la Piste de Recherche.",
    researchAgain = "%s obtient une autre Recherche grâce à la Piste de Recherche.",
    confirmSolarisToBeetles = "Voulez-vous payer 7 Solaris pour avancer deux fois sur la Piste Tleilaxu ?",
    researchSolarisToBeetles = "%s a payé 7 Solaris sur la Piste de Recherche pour avancer deux fois sur la Piste Tleilaxu.",
    addSpecimen = "+1 Spécimen",
    spentSpecimen = "-1 Spécimen",
    tleilaxuButtonTooltip = "Avancer sur la Piste Tleilaxu",
    tleilaxuBackTooltip = "Reculer sur la Piste Tleilaxu",
    tleilaxuIncreased = "%s a avancé sur la Piste Tleilaxu.",
    tleilaxuDecreased = "%s est revenu en arrière sur la Piste Tleilaxu.",
    tleilaxuMax = "Vous êtes au maximum sur la Piste Tleilaxu.",
    rollbackWarning = "Cette fonction est uniquement présente en cas d'erreur. (Vous ne pouvez pas revenir en arrière dans les règles d'Immortality) Voulez-vous vraiment faire ça ?",
    specimenAdded = "%s a ajouté un Spécimen",
    specimenLimitWarning = "Vous ne pouvez pas placer plus de 6 spécimens avec le script automatisé en raison de l'espace limité sur le plateau !!",
    addSpecimenManually = "Ajoutez manuellement votre Spécimen !!",
    specimenRemoved = "%s a retiré un Spécimen",
    tleilaxuIntrigue = "%s a obtenu une Intrigue grâce aux créations illicites des Tleilaxu.",
    tleilaxuVP = "%s a obtenu un Point de Victoire grâce aux créations illicites des Tleilaxu.",
    tleilaxuSpice = "%s a obtenu 2 Épices des Tleilaxu.",
    spiceGreatFlat = "Une Épice Bonus apparait sur LA GRANDE ÉTENDUE.",
    spiceHaggaBasin = "Une Épice Bonus apparait dans le BASSIN DE HAGGA.",
    spiceImperialBasin = "Une Épice Bonus apparait dans le BASSIN IMPÉRIAL.",
    nextRound = '-------------- MANCHE SUIVANTE ----------------',
    holtzmanEngine = " pioche une carte grâce au Moteur Holtzman",
    shuttleFleet = " obtient 2 Solaris grâce à sa Flotte de Navettes",
    holtzmanEffect = " pioche une carte grâce à son effet Holtzman",
    drawFive = "Piochez 5 Cartes",
    playersTurn = "TOUR DES JOUEURS",
    firstPlayer = "Le Premier Joueur est maintenant ",
    willBe = "%s incarnera %s !",
    cantClaimLeader = "Vous ne pouvez pas incarner de leader sans être assis !",
    claimLeaderButton = "INCARNER",
    drawIntrigue = " pioche une Carte Intrigue",
    revealFirstConflictButton = "Révéler\nLe 1er\nConflit",
    revealFirstConflictTooltip = "Révéler après que les joueurs ont choisi leur Dirigeant",
    chooseLeaderFirst = "Choisissez les Dirigeants avant de révéler !",
    noPlayers = "Il n'y a aucun joueur à la table.",
    useDices = "Utilisez une autre méthode pour déterminer le premier joueur.\n(Il y a des dés sur le plateau)",
    firstPlayerBeginning = "Le Premier Joueur sera ",
    hiddenPicksTooltip = "Choisir secrètement un Dirigeant parmi un Draft (NON FAN MADE)",
    scoreBoardTooltip = "Visible uniquement par le spectateur Noir",
    hiddenPicksNumberBanishedTooltip = "Nombre de Dirigeants aléatoirement bannis",
    notSeated = "Certains joueurs ont des couleurs non autorisées,\nmerci de vous asseoir à la table ou de passer spectateurs.",
    notBlitz = "Il faut au moins 3 joueurs pour jouer Blitz",
    notHiddenPicks = "Il faut au moins 3 joueurs pour jouer avec Hidden Picks",
    hiddenPicksRemoving = "Actuellement en train de retirer au hasard %s Dirigeants du jeu!",
    hiddenPickingLeader = " va choisir son Dirigeant.",
    hiddenPickOver = "La phase de sélection est terminée. Bonne chance, amusez-vous bien !",
    notReputation = "Vous n'avez pas la réputation requise.",
    notEnoughSpecimen = "Vous n'avez pas suffisamment de Spécimens.",
    acquiredTleilaxu = "%s a acquis une carte Tleilaxu pour %s %s.",
    reclaimedForcesTroops = " a échangé 3 Spécimens contre 2 Troupes en Garnison.",
    reclaimedForcesScarab = " a échangé 3 Spécimens pour avancer sur la Piste Tleilaxu.",
    reclaimedForcesTroopsWarning = "Voulez-vous vraiment dépenser 3 Spécimens pour ajouter des Troupes dans la Garnison ?",
    reclaimedForcesScarabWarning = "Voulez-vous vraiment dépenser 3 Spécimens pour avancer sur la Piste Tleilaxu ?",
    revealWarning = "Êtes-vous sûr(e) de vouloir Révéler ? Il vous reste au moins un Agent.",
    nope = "Vous ne pouvez pas faire cela.",
    commercialUpUp = " avance deux fois son cargo sur la Piste commerciale.",
    commercialUpDown = " avance son cargo sur la Piste commerciale et le fait rentrer à la base.",
    commercialDownUp = " fait rentrer son cargo à la base puis le fait repartir.",
    commercialUp = " avance son cargo sur la Piste commerciale.",
    commercialDown = " fait rentrer son cargo à la base.",
    revealEarlyConfirm = "Révéler votre main ?",
    soloHotseat = "Voulez-vous jouer Solo ou Hotseat ?",
    card = "carte",
    cards = "cartes",
    specimen = "Spécimen",
    specimens = "Spécimens",
    agentTurn = "Tour Agent",
    putTechHere = "Plateau Techno\n(posez les tuiles Techno ici)",
    selectSound = "Choisir Son de Combat",
    soundOn = "Sons [✓]",
    soundOff = "Sons [   ]",
    prescienceButton = "Prescience",
    prescienceTooltip = "Regarder la carte du dessus de votre Deck facilement avec ce bouton",
    prescienceUsed = "%s a utilisé sa Préscience pour regarder dans le futur.",
    prescienceVoid = "Vous ne voyez que le vide. (pas de Deck actuellement)",
    prescienceManual = "Vous devez regarder manuellement (ALT + MAJ) car il n'y a qu'une seule carte dans votre Deck.",
    addNegotiator = "+1 Négociateur",
    spendNegotiator = "-1 Négociateur",
    negotiatorAdded = "%s a ajouté un Négociateur.",
    negotiatorRemoved = "%s a récupéré un Négociateur.",
    negotiatorLimitWarning = "Vous ne pouvez pas placer plus de 4 Négociateurs avec le script automatisé en raison de l'espace limité sur le plateau !!",
    addNegotiatorManually = "Ajoutez manuellement votre Négociateur !!",
    noClockMode = "Il faut au moins 3 Joueurs pour le Mode Horloge !",
    clockModeActivated = "Mode Horloge activé, les chronos apparaîtront après que le Premier Conflit soit révélé.",
    noRedAsFirst = "Il faut 4 joueurs pour que le Rouge soit premier joueur sans tirage au sort."
}

end)
__bundle_register("i18n", function(require, _LOADED, __bundle_register, __bundle_modules)
local i18n = {locales = {}}

local currentLocale = 'en' -- the default language ( en / fr )

function i18n.getLocale()
    return currentLocale
end

function i18n.setLocale(newLocale)
    currentLocale = newLocale
    assert(i18n.locales[currentLocale],
           ("The locale %q was unknown"):format(newLocale))
end

local function translate(id)
    local result = i18n.locales[currentLocale][id]
    assert(result,
           ("The id %q was not found in the current locale (%q)"):format(id,
                                                                         currentLocale))
    return result
end

i18n.translate = translate

setmetatable(i18n, {__call = function(_, ...) return i18n.translate(...) end})

return i18n

end)
return __bundle_require("Setup.4a3e76.lua")
