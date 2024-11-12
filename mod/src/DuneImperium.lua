-- Bundled by luabundle {"rootModuleName":"Global.-1.lua","version":"1.6.0"}
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
__bundle_register("Global.-1.lua", function(require, _LOADED, __bundle_register, __bundle_modules)
locale = 'en'

battleSound = nil

function onLoad()

    i18n = require("i18n")
    require("locales") -- if using a separate file for the locales, require it too

    localeAssets = require("localeAssets")
    localeAssets.load()

    --getObjectFromGUID("0552a2").setState(1)    

    constants = require("Constants")

    helperModule = require("HelperModule")

    drawDeckZone = constants.drawDeckZone

    DrawOne = helperModule.DrawOne

    ResetDiscard = helperModule.ResetDiscard

    GetDeckOrCard = helperModule.GetDeckOrCard

    ressources = constants.ressources

    buttonPass = {
        ["Red"] = getObjectFromGUID("0e9fa2"),
        ["Blue"] = getObjectFromGUID("643f32"),
        ["Green"] = getObjectFromGUID("9c69b9"),
        ["Yellow"] = getObjectFromGUID("65876d")
    }

    pos_reveal = {
        ["Red"] = {-13.2, 1.8, 9.40}, -- location of first reveal snap point
        ["Blue"] = {-13.2, 1.8, -12.79},
        ["Green"] = {13.2, 1.8, 9.40},
        ["Yellow"] = {13.2, 1.8, -12.79}
    }
    board_player = {
        ["Red"] = getObjectFromGUID("daf2a3"),
        ["Blue"] = getObjectFromGUID("6957f2"),
        ["Green"] = getObjectFromGUID("0c408d"),
        ["Yellow"] = getObjectFromGUID("6037b3")
    }

    flag_basin_zone = getObjectFromGUID("3fe117") -- token below board at basin control position
    flag_arrakeen_zone = getObjectFromGUID("f1f53d")
    flag_carthag_zone = getObjectFromGUID("9fc2e1")
    flag_basin_pos = {5.96, 1.67, 0.13}
    flag_arrakeen_pos = {6.23, 1.67, 3.53}
    flag_carthag_pos = {2.40, 1.68, 2.77}

    -------------HiddenPicks var section--------------7--       -- This table is used in onObjectEnter and onObjectLeave to make objects invisible during picking phase
    hidingStateTable =
        { -- Must be in global since you can't pass tables with getVar()
            [1] = {"Red", "Blue", "Yellow", "Grey", "White"}, -- 1 = Green picking his leader: make leaders invisible to all other players
            [2] = {"Blue", "Yellow", "Green", "Grey", "White"}, -- 2 = Red picking his leader: make leaders invisible to all other players
            [3] = {"Red", "Yellow", "Green", "Grey", "White"},
            [4] = {"Red", "Blue", "Green", "Grey", "White"},
            [5] = {"Red", "Blue", "Yellow", "Green", "Grey", "White"}, -- 5 = make Leader invisible to all: this is during leader random ban, Important: Black cannot be set invisible and will see bans
            [6] = {} -- 6 = make Leader visible to all: after picking process, for players to see unpicked leaders
        }
    hidingState = 0 -- used as index for hidingStateTable

    function setHidingState(hidingStatePassed)
        hidingState = hidingStatePassed[1]
    end

    hidingLeaderScriptingZone = getObjectFromGUID("550f6d") -- Big scripting zone to hide leader in blind pick

    -----------------End section------------------------

    nom = nil
    zone_conflict_encours = getObjectFromGUID("43f00f") -- ???small zone top rigth of conflict card
    zone_vp_encours = getObjectFromGUID("740624") -- ..for conflict vp placement

    reveal = {
        ["Red"] = 0, -- initialization of bool if they have reveal ?
        ["Blue"] = 0,
        ["Green"] = 0,
        ["Yellow"] = 0
    }

    fight = 0 -- initialization ??
    marker_round = getObjectFromGUID("fb41e2") -- round marker
    vp_pos = constants.pos_vp
    vp_zone = constants.vp_zone 

    bag_friendship = { -- bag for 2 influence vp with factions
        ["Emperor"] = getObjectFromGUID('6a4186'),
        ["Spacing Guild"] = getObjectFromGUID('400d45'),
        ["Bene Gesserit"] = getObjectFromGUID('e763f6'),
        ["Fremen"] = getObjectFromGUID('8bcfe7')
    }

    alliance_token = {
        ["Emperor"] = getObjectFromGUID('13e990'),
        ["Spacing Guild"] = getObjectFromGUID('ad1aae'),
        ["Bene Gesserit"] = getObjectFromGUID('33452e'),
        ["Fremen"] = getObjectFromGUID('4c2bcc')
    }

    flag_bag = { -- infinite bag for flags
        ["Red"] = getObjectFromGUID('61453d'),
        ["Blue"] = getObjectFromGUID('8627e0'),
        ["Green"] = getObjectFromGUID('ad6b92'),
        ["Yellow"] = getObjectFromGUID('b92a4c')
    }

    zone_conseil = getObjectFromGUID("e51f6e") -- scripting zone high consil
    -- pion_reput = {
    --     ["Emperor Faction"] = {["Red"] = getObjectFromGUID('aae631'), ["Blue"] = getObjectFromGUID('aae631'), ["Green"] = getObjectFromGUID('aae631'), ["Yellow"] = getObjectFromGUID('aae631')},
    --     ["Spacing Guild Faction"] = {["Red"] = getObjectFromGUID('aae631'), ["Blue"] = getObjectFromGUID('aae631'), ["Green"] = getObjectFromGUID('aae631'), ["Yellow"] = getObjectFromGUID('aae631')},
    --     ["Bene Gesserit Faction"] = {["Red"] = getObjectFromGUID('aae631'), ["Blue"] = getObjectFromGUID('aae631'), ["Green"] = getObjectFromGUID('aae631'), ["Yellow"] = getObjectFromGUID('aae631')},
    --     ["Fremen Faction"] = {["Red"] = getObjectFromGUID('aae631'), ["Blue"] = getObjectFromGUID('aae631'), ["Green"] = getObjectFromGUID('aae631'), ["Yellow"] = getObjectFromGUID('aae631')}
    -- }

    zone_reput = {
        ["Emperor"] = getObjectFromGUID('aae631'), -- zone medium size were alliance goes
        ["Spacing Guild"] = getObjectFromGUID('768e1e'),
        ["Bene Gesserit"] = getObjectFromGUID('bd1e3b'),
        ["Fremen"] = getObjectFromGUID('4a1ce8')
    }

    zone_player = constants.zone_player

    -- 20 spaces were you put power marker
    marker_combat_pos = {
        {0.82, 3, -9.14}, {1.73, 3, -9.14}, {2.65, 3, -9.14}, {3.55, 3, -9.14},
        {4.46, 3, -9.14}, {5.33, 3, -9.14}, {6.23, 3, -9.14}, {7.15, 3, -9.14},
        {8.07, 3, -9.14}, {8.95, 3, -9.14}, {0.82, 3, -10.13},
        {1.74, 3, -10.13}, {2.65, 3, -10.13}, {3.55, 3, -10.13},
        {4.46, 3, -10.13}, {5.33, 3, -10.13}, {6.23, 3, -10.13},
        {7.15, 3, -10.13}, {8.07, 3, -10.13}, {8.95, 3, -10.13}
    }
    marker_combat_pos_ini = {
        ["Blue"] = {1.28, 1.58, -8.15},
        ["Green"] = {3.48, 1.58, -8.15},
        ["Red"] = {2.35, 1.58, -8.15},
        ["Yellow"] = {4.55, 1.58, -8.15}
    }
    zone_combat = getObjectFromGUID("6d632e") -- doesnt include garnisons
    marker_combat = {
        ["Red"] = getObjectFromGUID('2d1d17'),
        ["Blue"] = getObjectFromGUID('f22e20'),
        ["Green"] = getObjectFromGUID('a1a9a7'),
        ["Yellow"] = getObjectFromGUID('c2dd31')
    }
    VP_name = { -- conflit vp names + GUIDs
        ["Economic Supremacy"] = {"c38946", "6047f9", "4f428d", "ba1a77"},
        ["Battle for Carthag"] = {"e364df", "e123ce"},
        ["Battle for Arrakeen"] = {"e25f79", "8b658c"},
        ["Battle for Imperial Basin"] = {"ff1ce6", "905a58"},
        ["Siege of Carthag"] = {"f131f2"},
        ["Siege of Arrakeen"] = {"29a66c"},
        ["Secure Imperial Basin"] = {"2d469b"},
        ["Terrible Purpose"] = {"d61804"},
        ["Desert Power"] = {"11076b"},
        ["Skirmish"] = {"63791b"}
    }
    reserve_troop_zone = constants.reserve_troop_zone

    zone_vp_combat = getObjectFromGUID("988577") -- ???
    pos_vp_encours = {
        {-0.45, 2, -3.57}, {-0.45, 2, -2.57}, {-0.45, 3, -3.57},
        {-0.45, 3, -2.57}
    }

    players_color = {"Red", "Blue", "Green", "Yellow"}

    board_display_leaders = getObjectFromGUID("5a682a")

    for _, color in ipairs(players_color) do activateButtons(color) end

    -- rendre impossible à delock les plateaux

    getObjectFromGUID("8b1f92").interactable = false
    getObjectFromGUID("96b94b").interactable = false
    getObjectFromGUID("d69aec").interactable = false
    getObjectFromGUID("b24cc5").interactable = false
    getObjectFromGUID("90f762").interactable = false
    bag_friendship["Emperor"].interactable = false
    bag_friendship["Spacing Guild"].interactable = false
    bag_friendship["Bene Gesserit"].interactable = false
    bag_friendship["Fremen"].interactable = false
    getObjectFromGUID("7ded4f").interactable = false
    for _, color in pairs(players_color) do
        ressources[color][9].interactable = false -- conseillers
        buttonPass[color].interactable = false
    end
    

    for _, obj in ipairs(getObjects()) do
        if (obj.getDescription() == "Techs FR" and locale == 'en') or
            (obj.getDescription() == "Techs EN" and locale == 'fr') then
            obj.setInvisibleTo({
                "Red", "Blue", "Green", "Yellow", "White", "Grey", "Brown",
                "Pink", "Purple", "Orange"
            })
        end
    end
end

function doNothing() end

function revealEarly(color)
    if color == 'Blue' or color == "Red" then
        pos1 = {-2.1, 0.02, 1.235}
        pos2 = {-2.3, 0.02, 1.35}
        pos3 = {-1.9, 0.02, 1.35}
    else
        pos1 = {2.1, 0.02, 1.235}
        pos3 = {2.3, 0.02, 1.35}
        pos2 = {1.9, 0.02, 1.35}

    end
    board_player[color].createButton({
        ['click_function'] = 'doNothing',
        ['label'] = i18n("revealEarlyConfirm"),
        ['function_owner'] = Global,
        ['position'] = pos1,
        ['rotation'] = {0, 0, 0},
        ['width'] = 0,
        ['height'] = 0,
        ['scale'] = {0.15, 0.15, 0.15},
        ['font_size'] = 350,
        ['font_color'] = color,
        ['color'] = {0, 0, 0, 1}
    })
    board_player[color].createButton({
        ['click_function'] = 'RevealOK',
        ['label'] = i18n('yes'),
        ['function_owner'] = Global,
        ['position'] = pos2,
        ['rotation'] = {0, 0, 0},
        ['width'] = 600,
        ['height'] = 350,
        ['scale'] = {0.15, 0.15, 0.15},
        ['font_size'] = 350,
        ['font_color'] = {1, 1, 1},
        ['color'] = "Green"
    })
    board_player[color].createButton({
        ['click_function'] = 'cancelChoice',
        ['label'] = i18n('no'),
        ['function_owner'] = Global,
        ['position'] = pos3,
        ['rotation'] = {0, 0, 0},
        ['width'] = 600,
        ['height'] = 350,
        ['scale'] = {0.15, 0.15, 0.15},
        ['font_size'] = 350,
        ['font_color'] = {1, 1, 1},
        ['color'] = "Red"
    })
end

function cancelChoice(board, color)
    if board.hasTag(color) then
        board_player[color].clearButtons()
        activateButtons(color)
    else
        broadcastToColor(i18n('noTouch'), color, "Purple")
    end
end

function activateButtons(color) -- creates button in player zone with position relative to leader board: reveal, reset discard, draw 1, draw 5
    if color == "Red" or color == "Blue" then
        position_reveal_button = {-2.1, 0.02, 1.1}
        tech_button_pos = {-3.5, 0.2, -0.8}
    else
        position_reveal_button = {2.1, 0.02, 1.1}
        tech_button_pos = {3.5, 0.2, -0.8}
    end
    if color == 'Yellow' then
        font_color = {0.1, 0.1, 0.1, 1}
    else
        font_color = {0.9, 0.9, 0.9, 1}
    end

    board_player[color].createButton({
        click_function = "Reveal",
        function_owner = Global,
        label = i18n("revealButton"),
        position = position_reveal_button,
        scale = {0.15, 0.3, 0.15},
        width = 2200,
        height = 400,
        font_size = 400,
        color = color,
        font_color = font_color
    })
    board_player[color].createButton({
        click_function = "ResetDiscardColor",
        function_owner = Global,
        label = i18n("resetDiscardButton"),
        position = {1.08, 0.2, 0.43},
        scale = {0.055, 0.3, 0.055},
        width = 3700,
        height = 700,
        font_size = 400,
        color = color,
        font_color = font_color
    })
    board_player[color].createButton({
        click_function = "DrawFive",
        function_owner = Global,
        label = i18n("drawFiveButton"),
        position = {-1.1, 0.2, 0.43},
        scale = {0.055, 0.3, 0.055},
        width = 3700,
        height = 700,
        font_size = 400,
        color = color,
        font_color = font_color
    })
    board_player[color].createButton({
        click_function = "DrawOneColor",
        function_owner = Global,
        label = i18n("drawOneButton"),
        position = {-1.1, 0.2, 0.6},
        scale = {0.06, 0.3, 0.06},
        width = 2900,
        height = 1100,
        font_size = 400,
        color = color,
        font_color = font_color
    })

    board_player[color].createButton({
        click_function = "doNothing",
        function_owner = Global,
        label = i18n("agentTurn"),
        position = {0, 0.02, 1.1},
        scale = {0.15, 0.3, 0.15},
        width = 0,
        height = 0,
        font_size = 400,
        color = {0, 0, 0, 1},
        font_color = color
    })
    board_player[color].createButton({
        click_function = "doNothing",
        function_owner = Global,
        label = i18n("putTechHere"),
        position = tech_button_pos,
        scale = {0.5, 0.5, 0.5},
        width = 0,
        height = 0,
        font_size = 190,
        color = {0, 0, 0, 1},
        font_color = color
    })
end

function activatePass(color)
    buttonPass[color].createButton({
        click_function = "Pass",
        function_owner = self,
        label = i18n("passButton"),
        position = {0, 1, 0},
        scale = {0.5, 0.5, 0.5},
        width = 2750,
        height = 2000,
        font_size = 800,
        color = "Purple",
        font_color = {0.9, 0.9, 0.9, 1}
    })
end

function Reveal(board, color)
    if board.hasTag(color) then
        local players = getObjectFromGUID("4a3e76").call(
                            "getPlayersBasedOnHotseat")
        local test_agent = testAgent(color)
        local turnColor = nil
        if getObjectFromGUID("4a3e76").getVar("hotseat_mode") then
            turnColor = Player.getPlayers()[1].color
        else
            turnColor = Turns.turn_color
        end
        if turnColor ~= color and #players > 1 then
            broadcastToColor(i18n("revealNotTurn"), color, "Pink")
        elseif test_agent then
            revealEarly(color)
        else
            RevealOK(_, color)
        end
    else
        broadcastToColor(i18n('noTouch'), color, "Purple")
    end

end

function RevealOK(_, color)
    board_player[color].clearButtons()
    Wait.time(function() activateButtons(color) end, 2)
    local player_hand_table = Player[color].getHandObjects()
    local count = 0
    local c = 0
    local d = 0
    local t = 0
    for _, obj in ipairs(player_hand_table) do
        if obj.hasTag('Imperium') then
            Wait.time(function()
                if count < 10 then
                    obj.setPosition({
                        pos_reveal[color][1] + c, 1.8, pos_reveal[color][3] + d
                    })
                    if color == "Yellow" or color == "Green" then
                        c = c + 2.5
                        count = count + 1
                        if count == 8 then
                            c = 15
                            d = 3.6
                        end
                    end
                    if color == "Red" or color == "Blue" then
                        c = c - 2.5
                        count = count + 1
                        if count == 8 then
                            c = -15
                            d = 3.6
                        end
                    end

                end
            end, t)
            t = t + 0.25
        end
    end
    Wait.time(function()
        reveal[color] = 1
        -- TableTurnPlayers()
        Turns.enable = false
        local players = getObjectFromGUID("4a3e76").call(
                            "getPlayersBasedOnHotseat")
        if #players > 1 then activatePass(color) end
    end, 1)
end

function testAgent(color)
    local test = false
    for _, obj in ipairs(constants.zone_player[color].getObjects()) do
        if obj.hasTag("Agent") then
            test = true
            return test
        end
    end
    return test
end

function Pass(_, color)
    if color ~= buttonPass[color].getDescription() then
        broadcastToColor(i18n("noTouch"), color, "Red")
    elseif reveal["Blue"] == 1 and reveal["Red"] == 1 and reveal["Green"] == 1 and
        reveal["Yellow"] == 1 then
        letsFight()
        buttonPass[color].clearButtons()
    else
        if not getObjectFromGUID("4a3e76").getVar("hotseat_mode") then
            TableTurnPlayers()
        end
        buttonPass[color].clearButtons()
        if color == "Blue" then
            if reveal["Red"] == 0 then
                Turns.turn_color = "Red"
            elseif reveal["Green"] == 0 then
                Turns.turn_color = "Green"
            elseif reveal["Yellow"] == 0 then
                Turns.turn_color = "Yellow"
            else
                Turns.turn_color = "Blue"
            end
        elseif color == "Red" then
            if reveal["Green"] == 0 then
                Turns.turn_color = "Green"
            elseif reveal["Yellow"] == 0 then
                Turns.turn_color = "Yellow"
            elseif reveal["Blue"] == 0 then
                Turns.turn_color = "Blue"
            else
                Turns.turn_color = "Red"
            end
        elseif color == "Green" then
            if reveal["Yellow"] == 0 then
                Turns.turn_color = "Yellow"
            elseif reveal["Blue"] == 0 then
                Turns.turn_color = "Blue"
            elseif reveal["Red"] == 0 then
                Turns.turn_color = "Red"
            else
                Turns.turn_color = "Green"
            end
        elseif color == "Yellow" then
            if reveal["Blue"] == 0 then
                Turns.turn_color = "Blue"
            elseif reveal["Red"] == 0 then
                Turns.turn_color = "Red"
            elseif reveal["Green"] == 0 then
                Turns.turn_color = "Green"
            else
                Turns.turn_color = "Yellow"
            end
        end
        if not getObjectFromGUID("4a3e76").getVar("hotseat_mode") then
            Turns.enable = true
        end

    end
end

function TableTurnPlayers()
    local v = 0
    table_players = {}

    if reveal['Blue'] == 0 then
        v = v + 1
        table_players[v] = 'Blue'
    end
    if reveal['Red'] == 0 then
        v = v + 1
        table_players[v] = 'Red'
    end
    if reveal['Green'] == 0 then
        v = v + 1
        table_players[v] = 'Green'
    end
    if reveal['Yellow'] == 0 then
        v = v + 1
        table_players[v] = 'Yellow'
    end

    Turns.order = table_players
end

function ResetDiscardColor(board, color)
    if board.hasTag(color) then
        board_player[color].clearButtons()
        Wait.time(function() activateButtons(color) end, 1)
        ResetDiscard(_, color)
    else
        broadcastToColor(i18n('noTouch'), color, "Purple")
    end
end

function DrawFive(board, color)
    if board.hasTag(color) then

        board_player[color].clearButtons()
        Wait.time(function() activateButtons(color) end, 1)

        local starterDeck = GetDeckOrCard(drawDeckZone[color])
        local countCheck = 0
        local typeCheck = ""
        local drawCount = 0

        if starterDeck ~= nil then
            countCheck = starterDeck.getQuantity()
            typeCheck = starterDeck.type

            if countCheck >= 5 and typeCheck == "Deck" then
                starterDeck.deal(5, color)
            elseif countCheck >= 2 and typeCheck == "Deck" then
                starterDeck.deal(countCheck, color)
                drawCount = 5 - countCheck
                ResetDiscard(_, color)
                Wait.time(function()
                    local drawDeck = GetDeckOrCard(drawDeckZone[color])
                    drawDeck.deal(drawCount, color)
                end, 1.5)
            elseif typeCheck == "Card" then
                starterDeck.deal(1, color)
                ResetDiscard(_, color)
                Wait.time(function()
                    local drawDeck = GetDeckOrCard(drawDeckZone[color])
                    drawDeck.deal(4, color)
                end, 1.5)
            end
        else
            ResetDiscard(_, color)
            Wait.time(function()
                local drawDeck = GetDeckOrCard(drawDeckZone[color])
                drawDeck.deal(5, color)
            end, 1.5)
        end
    else
        broadcastToColor(i18n('noTouch'), color, "Purple")
    end
end

function DrawOneColor(board, color)
    if board.hasTag(color) then
        board_player[color].clearButtons()
        Wait.time(function() activateButtons(color) end, 0.3)
        DrawOne(_, color)
    else
        broadcastToColor(i18n('noTouch'), color, "Purple")
    end

end

function letsFight()
    Turns.enable = false
    marker_round.setPositionSmooth({-4.12, 1.8, -9.33}, false, false)
    broadcastToAll(i18n("fightWarning"), {0.5, 0.5, 0.5})

    if battleSound ~= nil and board_display_leaders.getVar("sound_active") then
        MusicPlayer.setCurrentAudioclip(battleSound)

        MusicPlayer.play()
    end
    fight = 1
end

function getFight() return fight end

function resetRound()

    local players = nil

    if getObjectFromGUID("4a3e76").getVar("hotseat_mode") then
        players = {'Red', 'Blue', 'Green', 'Yellow'}
    else
        players = getSeatedPlayers()
    end

    reveal["Red"] = 1
    reveal["Blue"] = 1
    reveal["Green"] = 1
    reveal["Yellow"] = 1
    fight = 0

    for _, value in ipairs(players) do
        if value == "Red" then reveal["Red"] = 0 end
        if value == "Blue" then reveal["Blue"] = 0 end
        if value == "Green" then reveal["Green"] = 0 end
        if value == "Yellow" then reveal["Yellow"] = 0 end
    end
end

function CountForce(name)
    local zoneObjects = zone_combat.getObjects()
    local force = 0
    local conseilObjects = zone_conseil.getObjects()
    local playerObjects = zone_player[name].getObjects()
    local test1 = 0
    local test2 = 0
    for i, object in ipairs(zoneObjects) do
        if object.getName() == name then
            force = force + 2
        elseif object.getName() == name .. " Dreadnought" or object.getName() ==
            name .. " dreadnought" then
            if ressources[name][6].getObjects()[1].hasTag("Rhombur") then
                force = force + 4
            else
                force = force + 3
            end
        end
    end
    for _, obj in ipairs(conseilObjects) do
        if obj.getName() == name .. " Councilor" then test1 = 1 end
    end
    for _, obj in ipairs(playerObjects) do
        if obj.hasTag("Restricted Ordnance") then test2 = 1 end
    end
    if test1 == 1 and test2 == 1 then force = force + 4 end

    if force == 0 then
        marker_combat[name].setPositionSmooth(marker_combat_pos_ini[name],
                                              false, false)

    elseif force < 21 then
        marker_combat[name].setPositionSmooth(marker_combat_pos[force], false,
                                              false)
        marker_combat[name].setRotationSmooth({0, 180, 0})
    else
        marker_combat[name].setPositionSmooth(marker_combat_pos[force - 20],
                                              false, false)
        marker_combat[name].setRotationSmooth({0, 180, 180})
    end
end

function defenseTroop()
    flag = nil
    if nom == "Secure Imperial Basin" or nom == "Battle for Imperial Basin" then
        flag = flag_basin_zone
    elseif nom == "Siege of Arrakeen" or nom == "Battle for Arrakeen" then
        flag = flag_arrakeen_zone
    elseif nom == "Siege of Carthag" or nom == "Battle for Carthag" then
        flag = flag_carthag_zone
    end
    if flag ~= nil then addTroopDefense() end
end

function addTroopDefense()
    local reserve_zone = nil
    local joueur = nil
    local table = flag.getObjects()
    for _, obj in ipairs(table) do
        if obj.getName() == "Red Dreadnought" or obj.getName() ==
            "Red dreadnought" then
            joueur = "Red"
        elseif obj.getName() == "Blue Dreadnought" or obj.getName() ==
            "Blue dreadnought" then
            joueur = "Blue"
        elseif obj.getName() == "Green Dreadnought" or obj.getName() ==
            "Green dreadnought" then
            joueur = "Green"
        elseif obj.getName() == "Yellow Dreadnought" or obj.getName() ==
            "Yellow dreadnought" then
            joueur = "Yellow"
        end
    end
    if joueur == nil then
        for _, obj in ipairs(table) do
            if obj.getName() == "Red Flag" then
                joueur = "Red"
            elseif obj.getName() == "Blue Flag" then
                joueur = "Blue"
            elseif obj.getName() == "Green Flag" then
                joueur = "Green"
            elseif obj.getName() == "Yellow Flag" then
                joueur = "Yellow"
            end
        end
    end
    if joueur ~= nil then
        reserve_zone = reserve_troop_zone[joueur]
        local troops = reserve_zone.getObjects()
        for _, troop in ipairs(troops) do
            if troop.getName() == joueur then
                troop.setPositionSmooth({4.79, 2, -5.19}, false, false)
                local leaderName = ressources[joueur][6].getObjects()[1]
                                       .getName()
                broadcastToAll(i18n("defenseTroop"):format(leaderName), joueur)
                break
            end
        end
    end
end

function onObjectEnterScriptingZone(zone, enter_object)

    -----------------New section------------------------
    if zone.guid == hidingLeaderScriptingZone.guid and hidingState ~= 0 then
        enter_object.setInvisibleTo(hidingStateTable[hidingState])
    end
    -----------------End section------------------------
    if zone.guid == zone_combat.guid then
        local name = enter_object.getDescription()
        if name == "Red" or name == "Blue" or name == "Green" or name ==
            "Yellow" then CountForce(name) end
    end

    if zone.guid == zone_reput["Emperor"].guid then
        local faction = "Emperor"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then Friendship(faction, color) end
    end

    if zone.guid == zone_reput["Spacing Guild"].guid then
        local faction = "Spacing Guild"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then Friendship(faction, color) end
    end

    if zone.guid == zone_reput["Bene Gesserit"].guid then
        local faction = "Bene Gesserit"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then Friendship(faction, color) end
    end

    if zone.guid == zone_reput["Fremen"].guid then
        local faction = "Fremen"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then Friendship(faction, color) end
    end

    if zone.guid == zone_conflict_encours.guid then
        if enter_object.guid == '2b2575' then
            enter_object.setPosition({4.80, 2, -2.73})
            GetDeckOrCard('07e239').takeObject({
                position = {-1.16, 2, -5.74},
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        round_start = getObjectFromGUID("120026").call("getRoundStart")
        if round_start == 1 then
            nom = enter_object.getName()
            local j = 0
            for _, obj in pairs(getObjectFromGUID('d9a457').getObjects()) do
                if obj.name == nom then -- we use name instead of getName() here because objects are still in a bag and cannot use methods on them
                    j = j + 1
                    getObjectFromGUID('d9a457').takeObject({
                        position = pos_vp_encours[j],
                        rotation = {0, 180, 0},
                        smooth = true,
                        guid = obj.guid
                    })
                end
            end
            defenseTroop()
        end
    end

    if zone.guid == vp_zone["Yellow"].guid then
        local name = enter_object.guid
        if name == "2d469b" or name == "ff1ce6" then
            local objets = flag_basin_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Yellow"].takeObject({
                position = flag_basin_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "29a66c" or name == "e25f79" then
            local objets = flag_arrakeen_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Yellow"].takeObject({
                position = flag_arrakeen_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "f131f2" or name == "e123ce" then
            local objets = flag_carthag_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Yellow"].takeObject({
                position = flag_carthag_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end

    end
    if zone.guid == vp_zone["Red"].guid then
        local name = enter_object.guid
        if name == "2d469b" or name == "ff1ce6" then
            local objets = flag_basin_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Red"].takeObject({
                position = flag_basin_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "29a66c" or name == "e25f79" then
            local objets = flag_arrakeen_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Red"].takeObject({
                position = flag_arrakeen_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "f131f2" or name == "e123ce" then
            local objets = flag_carthag_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Red"].takeObject({
                position = flag_carthag_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end

    end
    if zone.guid == vp_zone["Blue"].guid then
        local name = enter_object.guid
        if name == "2d469b" or name == "ff1ce6" then
            local objets = flag_basin_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Blue"].takeObject({
                position = flag_basin_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "29a66c" or name == "e25f79" then
            local objets = flag_arrakeen_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Blue"].takeObject({
                position = flag_arrakeen_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "f131f2" or name == "e123ce" then
            local objets = flag_carthag_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Blue"].takeObject({
                position = flag_carthag_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end

    end

    if zone.guid == vp_zone["Green"].guid then
        local name = enter_object.guid
        if name == "2d469b" or name == "ff1ce6" then
            local objets = flag_basin_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Green"].takeObject({
                position = flag_basin_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "29a66c" or name == "e25f79" then
            local objets = flag_arrakeen_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Green"].takeObject({
                position = flag_arrakeen_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end
        if name == "f131f2" or name == "e123ce" then
            local objets = flag_carthag_zone.getObjects()
            for _, obj in ipairs(objets) do
                if obj.getName() == "Red Flag" or obj.getName() == "Blue Flag" or
                    obj.getName() == "Green Flag" or obj.getName() ==
                    "Yellow Flag" then obj.destruct() end
            end
            flag_bag["Green"].takeObject({
                position = flag_carthag_pos,
                rotation = {0, 180, 0},
                smooth = false
            })
        end

    end
end

function onObjectLeaveScriptingZone(zone, enter_object)

    if zone.guid == zone_reput["Emperor"].guid then
        local faction = "Emperor"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then
            Wait.time(function() loseFriendship(faction, color) end, 0.7)
        end
    end
    if zone.guid == zone_reput["Spacing Guild"].guid then
        local faction = "Spacing Guild"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then
            Wait.time(function() loseFriendship(faction, color) end, 0.7)
        end
    end
    if zone.guid == zone_reput["Bene Gesserit"].guid then
        local faction = "Bene Gesserit"
        local name = enter_object.getName()
        local color = ""

        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then
            Wait.time(function() loseFriendship(faction, color) end, 0.7)
        end
    end
    if zone.guid == zone_reput["Fremen"].guid then
        local faction = "Fremen"
        local name = enter_object.getName()
        local color = ""
        if name == faction .. " Faction Red" then
            color = "Red"
        elseif name == faction .. " Faction Blue" then
            color = "Blue"
        elseif name == faction .. " Faction Green" then
            color = "Green"
        elseif name == faction .. " Faction Yellow" then
            color = "Yellow"
        end
        if color == "Red" or color == "Blue" or color == "Green" or color ==
            "Yellow" then
            Wait.time(function() loseFriendship(faction, color) end, 0.7)
        end
    end

end

function Friendship(faction, color)
    local test = 0
    local vp = vp_zone[color].getObjects()
    for _, value in ipairs(vp) do
        if value.getName() == faction .. " Friendship" then test = 1 end
    end
    if test == 0 then give2influence(faction, color) end
end

function loseFriendship(faction, color)
    local test = 0
    local vp = vp_zone[color].getObjects()
    for _, value in ipairs(vp) do
        if value.getName() == faction .. " Friendship" then test = 1 end
        if test == 1 then
            local zoneObjects = vp_zone[color].getObjects()
            for i, object in ipairs(zoneObjects) do
                if object.getName() == faction .. " Friendship" then
                    object.setPositionSmooth({-4.27, 4, 34.54}, false, false)
                end
            end

        end
    end

end

function give2influence(faction, color)

    local zoneObjects = vp_zone[color].getObjects()
    local vpIndex = 1
    for i, object in ipairs(zoneObjects) do
        if object.getDescription() == "VP" then vpIndex = vpIndex + 1 end
    end
    if vpIndex > 13 then vpIndex = 13 end

    bag_friendship[faction].takeObject({
        position = vp_pos[color][vpIndex],
        rotation = {0, 180, 0}
    })

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
__bundle_register("localeAssets", function(require, _LOADED, __bundle_register, __bundle_modules)
local localeAssets = {}

local constants = require("Constants")

local i18n = require("i18n")

helperModule = require("HelperModule")

GetDeckOrCard = helperModule.GetDeckOrCard

local epic_cards = constants.epic_cards
local starter_decks = {"014c6a", "b8e747", "0c5e03", "a76b37"}
local dune_decks = {"8c99a3", "af840c", "44069d", "85fb54"}
local experimentation_decks = {"ef9531", "45ce21", "2d935f", "8ed0cd"}

local imperiumCardBack =
    "https://steamusercontent-a.akamaihd.net/ugc/1892102433196500461/C3DC7A02CF378129569B414967C9BE25097C6E77/"

local intrigueCardBack =
    "https://steamusercontent-a.akamaihd.net/ugc/1892102433196339102/D63B92C616541C84A7984026D757DB03E79532DD/"

local cardsTleilaxAttributes = {
    {specimenCost = 3}, {specimenCost = 2}, {specimenCost = 1},
    {specimenCost = 1}, {specimenCost = 2}, {specimenCost = 1},
    {specimenCost = 2}, {specimenCost = 3}, {specimenCost = 2},
    {specimenCost = 1}, {specimenCost = 3}, {specimenCost = 3},
    {specimenCost = 2}, {specimenCost = 3}, {specimenCost = 2},
    {specimenCost = 2}, {specimenCost = 4}, {specimenCost = 3},
    {specimenCost = 4}
}

function loadDeck(GUID, face, back, width, height, number)

    local params = {
        face = face,
        back = back,
        width = width,
        height = height,
        number = number,
        back_is_hidden = true
    }

    local deck = getObjectFromGUID(GUID)

    deck.setCustomObject(params)

    deck.reload()

end

function loadCard(GUID, face, back)

    local params = {face = face, back = back}

    local cardObj = getObjectFromGUID(GUID)

    cardObj.setCustomObject(params)

    cardObj.reload()

end

function localeAssets.load()
    local currentLocale = i18n.getLocale()

    if currentLocale ~= "en" then
        -- retourner les règles coté français
        if currentLocale == 'fr' then
            getObjectFromGUID("e43180").setRotation({0,180,180})
            getObjectFromGUID("44e3ba").setRotation({0,180,180})
            -- changer les pdf par les pdf français
            if getObjectFromGUID("9ac7d6")~=nil then
                local position_regles = getObjectFromGUID("9ac7d6").getPosition()
                local position_faq = getObjectFromGUID("a4a8a7").getPosition()
                local position_regles_ix = getObjectFromGUID("373d17").getPosition()
                local position_regles_immo = getObjectFromGUID("537207").getPosition()
                getObjectFromGUID("9ac7d6").destruct()
                getObjectFromGUID("a4a8a7").destruct()
                getObjectFromGUID("373d17").destruct()
                getObjectFromGUID("537207").destruct()
                local sac_vf = getObjectFromGUID("433052")
                local regles_immo = sac_vf.takeObject({
                    position          = position_regles_immo,
                    rotation          = {0,180,0},
                    smooth            = false
                })
                local regles_ix = sac_vf.takeObject({
                    position          = position_regles_ix,
                    rotation          = {0,180,0},
                    smooth            = false
                })
                local faq = sac_vf.takeObject({
                    position          = position_faq,
                    rotation          = {0,180,0},
                    smooth            = false
                })
                local regles = sac_vf.takeObject({
                    position          = position_regles,
                    rotation          = {0,180,0},
                    smooth            = false
                })
                regles.setLock(true)
                faq.setLock(true)
                regles_ix.setLock(true)
                regles_immo.setLock(true)
            end
        end

        -- Leaders tiles
        for k, leader in pairs(constants.leaders) do
            local params = {image = localeAssets[currentLocale][k]}

            local leaderObj = getObjectFromGUID(leader.GUID)

            leaderObj.setCustomObject(params)
            -- leaderObj.setName('Princesse Yuna')

            leaderObj.reload()
        end

        for _, GUID in ipairs(starter_decks) do
            loadDeck(GUID, localeAssets[currentLocale]["cardsStarterImperium"],
                     imperiumCardBack, 4, 2, 8)
        end

        for _, GUID in ipairs(dune_decks) do
            loadDeck(GUID, localeAssets[currentLocale]["cardsDunePlanet"],
                     imperiumCardBack, 2, 2, 2)
        end

        loadDeck("014161", localeAssets[currentLocale]["cardsFoldspace"],
                 imperiumCardBack, 3, 2, 6)

        loadDeck("7d34c9", localeAssets[currentLocale]["cardsLiaison"],
                 imperiumCardBack, 4, 2, 8)

        loadDeck("8de6d5", localeAssets[currentLocale]["cardsTSMF"],
                 imperiumCardBack, 5, 2, 10)

        loadDeck("99d41d", localeAssets[currentLocale]["cardsBaseImperium"],
                 imperiumCardBack, 10, 7, 70)

        loadDeck(constants.imperium_deck_ix,
                 localeAssets[currentLocale]["cardsIxImperium"],
                 imperiumCardBack, 6, 6, 36)

        loadDeck(constants.imperium_deck_immortality,
                 localeAssets[currentLocale]["cardsImmortalityImperium"],
                 imperiumCardBack, 6, 5, 30)

        loadCard(constants.reclaimed_forces,
                 localeAssets[currentLocale]["cardReclaimedForces"],
                 imperiumCardBack)

        loadDeck(constants.intrigue_base,
                 localeAssets[currentLocale]["cardsBaseIntrigue"],
                 intrigueCardBack, 8, 5, 40)

        loadDeck(constants.intrigue_ix,
                 localeAssets[currentLocale]["cardsIxIntrigue"],
                 intrigueCardBack, 5, 4, 17)

        loadDeck(constants.intrigue_immortality,
                 localeAssets[currentLocale]["cardsImmortalityIntrigue"],
                 intrigueCardBack, 6, 3, 15)

        for _, guidEpic in ipairs(epic_cards) do
            loadCard(guidEpic,
                     localeAssets[currentLocale]["cardControlTheSpice"],
                     imperiumCardBack)
        end

        for _, GUID in ipairs(experimentation_decks) do
            loadDeck(GUID, localeAssets[currentLocale]["cardsExperimentation"],
                     imperiumCardBack, 2, 2, 2)
        end

        Wait.time(function()
            for _, obj in pairs(getObjectFromGUID("e88cd0").getObjects()) do
                obj.setInvisibleTo({
                    "Red", "Blue", "Green", "Yellow", "White", "Grey", "Brown",
                    "Pink", "Purple", "Orange"
                })
            end
        end, 0.5)

        if getObjectFromGUID(constants.tleilaxu_deck) ~= nil then -- ça va changer le GUID du deck tleilaxu, besoin de le faire qu'une fois.
            loadDeck(constants.tleilaxu_deck,
                     localeAssets[currentLocale]["cardsTleilaxu"],
                     imperiumCardBack, 4, 5, 19)

            local tleilaxu_deck = getObjectFromGUID(constants.tleilaxu_deck)
            for i = 1, 19 do
                Wait.time(function()
                    card = tleilaxu_deck.takeObject({
                        position = tleilaxu_deck.getPosition() +
                            Vector({0, (0.2 * i), 0}),
                        rotation = {0, 180, 180},
                        smooth = false
                    })
                    card.setGMNotes(JSON.encode(cardsTleilaxAttributes[i]))
                end, 0.001 * i)
            end
        end
    end
end

localeAssets.fr = {
    yuna = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440254532/CDAED205706CD8E32700B8A56C9BD387C5D72696/",
    hundro = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440287844/A64F2D77C6F482F31B12EC97C2DEEBBDF45AF3F9/",
    memnon = "https://steamusercontent-a.akamaihd.net/ugc/2029468089262094752/36DB26EE194B780C9C879C74FC634C15433CE06A/",
    ariana = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440480689/3C1CA2B3506FB7AD8B1B40DB1414F7461F6974C8/",
    ilesa = "https://steamusercontent-a.akamaihd.net/ugc/2029468089262092469/7A0FCC4CA1D0CAF19C8066776DC23A9631000997/",
    armand = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440253818/98401D1D00D15DB3512E48BBD63B9922EE17EF71/",
    paul = "https://steamusercontent-a.akamaihd.net/ugc/2029468089262095259/008429F21B2898E4C2982EC7FB1AF422FDD85E24/",
    leto = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440402017/152B626A2D773B224CFFF878E35CEFDBB6F67505/",
    tessia = "https://steamusercontent-a.akamaihd.net/ugc/2029468089262093029/6C34345ADF23EBD567DE0EE662B4920906F721F0/",
    rhombur = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440274764/58A6CF3EB6EBDEAC4B5826C0D21408A3CC02E678/",
    rabban = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440364572/68A9DE7E06DA5857EE51ECB978E13E3921A15B1A/",
    vladimir = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440341651/6F682C5E5C1ADE0B9B1B8FAC80B9525A6748C351/",
    ilban = "https://steamusercontent-a.akamaihd.net/ugc/2029467636440255083/F0F052CCAB7005F4D30879BF639AFACEDFF70A80/",
    helena = "https://steamusercontent-a.akamaihd.net/ugc/5095292505135062968/A069B3ECF1B4E9C42D2453E28EA13257F397B3F3/",
    cardsStarterImperium = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268121216/D25AA65312D89EB7CEED36D451618E731A674BED/",
    cardsDunePlanet = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268102690/98F5861E28F3167495D3F2890879072BF3A84E60/",
    cardsFoldspace = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268101016/AE481C2ED19B085E2669F22420FD282982FD11A9/",
    cardsLiaison = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268100070/D7411DB495E6EB13D6B64F5E46CCF69FF322039F/",
    cardsTSMF = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268101681/B6E08F8328DB699C60A8F058E88AA6443BA2F716/",
    cardsBaseImperium = "https://steamusercontent-a.akamaihd.net/ugc/2047498313948793470/1736E8BEF901B3F2BDE1F79A381CB691F3FF67E3/",
    cardsIxImperium = "https://steamusercontent-a.akamaihd.net/ugc/2029469358268106254/C54BCAB79869547E728509123AC47EDB32E79BF5/",
    cardsImmortalityImperium = "https://steamusercontent-a.akamaihd.net/ugc/2063250888850083256/142F50245296C2EE1F5ABAD8CE93982AC0592110/",
    cardsTleilaxu = "https://steamusercontent-a.akamaihd.net/ugc/2063250888847571463/639814906915DFA557375A3F7963C9DE53301D57/",
    cardReclaimedForces = "https://steamusercontent-a.akamaihd.net/ugc/2063250888847577276/60812AEA733FF5558BA9190E47CBD474EBF38C94/",
    cardsImmortalityIntrigue = "https://steamusercontent-a.akamaihd.net/ugc/2063250888848685998/83BA634F05FC7A14933153A18B7AEF83E07E3C14/",
    cardsIxIntrigue = "https://steamusercontent-a.akamaihd.net/ugc/2029469358271904511/3D33B3E59811CEDC64A53F104D31190E76676C64/",
    cardsBaseIntrigue = "https://steamusercontent-a.akamaihd.net/ugc/2029469995670901713/13659DD01D152A8B8055B894B247CB1D254D3752/",
    cardControlTheSpice = "https://steamusercontent-a.akamaihd.net/ugc/2029469358243272739/DD5ED3E5FD12F0A1C4F42750E766E83564248E07/",
    cardsExperimentation = "https://steamusercontent-a.akamaihd.net/ugc/2063250888850160556/BF6DF4E8EF5B8C8F5BB6952166C559694A61BA04/",
    -- fan made leaders
    vorian = "https://steamusercontent-a.akamaihd.net/ugc/2021593766276323633/CF05EB98F06D6A83657528AE9B848AF1269E16CB/",
    butler = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048963078/DC8CA97CC8837799620DC818CF86A17E6AE21C7A/",
    scytale = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048926023/CCCE3E2850003D29577EE441DDE9F76C340CF67B/",
    wensicia = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048923600/50C3448B1B131BCCEDEF2489B8D55BD122436063/",
    irulan = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048920158/54684F67F54FBA44E0E919C09AE731EF6452609A/",
    norma = "https://steamusercontent-a.akamaihd.net/ugc/2021593312052178581/FFDA79B76F75EFF0D5FE13F8FB9A93907027FDB3/",
    miles = "https://steamusercontent-a.akamaihd.net/ugc/2021593766276340183/7A6796DC0800083D9A7B667BEE290FB59C9EF908/",
    feyd = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048912133/FE488A5E03313545438CD8DA4E52BAED4E903996/",
    esmar = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048901208/6389B462773D70A50810F6ED7D6D62670AE19107/",
    metulli = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048898591/31A0F66BAB24BB067FA817844AFC62CF7A9C6E6F/",
    margot = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048896971/5E8A0FD7841FA1E0E859CABB20629E90866DE770/",
    memnon2 = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048894378/54389935A815BF7D4475DD29DF06EA911957F87A/",
    hasimir = "https://steamusercontent-a.akamaihd.net/ugc/2021593766276332961/E664A9BDC5C848CE47A06349B983D7E1438F968A/",
    otto = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048891817/37A53D71D3D80F35ADA6ACB63EB75236B0812785/",
    abulurd = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048886235/2613FE67B82A7A60717655610E1DFAB668C24B77/",
    esmar2 = 'https://steamusercontent-a.akamaihd.net/ugc/2021593312048814518/FFCC4D10A115AF72BCFA88B6495AD2CBB47B913D/',
    rhombur2 = 'https://steamusercontent-a.akamaihd.net/ugc/2021593312048797174/A5C5C5F42EE00169BBD4CC92576DB8F585952CF0/',
    farok = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048740730/487626BF0B4B4176C00D76C6073710179BAE6A7E/",
    darwi = "https://steamusercontent-a.akamaihd.net/ugc/2021593312048731551/F18296C86EDCCDC244B98AE5AF9B0809A0D1651C/",
    xavier = "https://steamusercontent-a.akamaihd.net/ugc/2021593312049143257/8D87E9ECF612D69B4048E62046D115C5D8B895E1/",
    whitmore = "https://steamusercontent-a.akamaihd.net/ugc/2021593312049142091/2F525198F540FCB6292064CB53F7C37FF7CD905F/"
}

return localeAssets

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
return __bundle_require("Global.-1.lua")
