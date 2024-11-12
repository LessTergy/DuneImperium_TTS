-- Bundled by luabundle {"rootModuleName":"Worm.20b33a.lua","version":"1.6.0"}
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
__bundle_register("Worm.20b33a.lua", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Tournament Worm by grimnebulin (aka Mark Silverman) && Rogerio Camorim
-- marksilverman@gmail.com or grimnebulin#0122
-- camorimcanada@gmail.com or 
local wormData = {}

constants = require("Constants")
helperModule = require("HelperModule")
resources = constants.ressources
spice = 1
solari = 2
water = 3
leader = 6
results = {}
startTime = os.date("!%m/%d/%Y %H:%M:%S", os.time(os.date("!*t"))) -- convert system time to GMT for consistency
gameWasSubmitted = false
game_id = "0"
tournament_mode = false
gameToken = "-1"
wormData.vptray = nil
wormData.points = nil
wormData.pics = nil
wormData.swordMasterRound = {}
wormData.swordMasterRound["Red"] = 0
wormData.swordMasterRound["Green"] = 0
wormData.swordMasterRound["Yellow"] = 0
wormData.swordMasterRound["Blue"] = 0

gameStartTime = nil
red_go_first = false
rise_of_ix = false
immortality = false
first_player = "Red"
leaderPickOrder = "4321"

function init()
    wormData.pics = {}
    wormData.pics["Baron Harkonnen"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251375/58773A049B5EC10CB24DABC66E8DFF5B3B5A7966/"
    wormData.pics["Countess Ariana"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251277/0AC41A9B4FF90D7CAD22A0C899532FA3624CD9D3/"
    wormData.pics["Archduke Armand"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251323/D7E5F550BBCAF67F7FC6280A9D2C8CBFD357D605/"
    wormData.pics["Count Ilban"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251507/68BE1BAD1A7DB2BD87330DD3D97E25D034B03A10/"
    wormData.pics["Helena Richese"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251414/B3136F00AE416D6989303FE5A2504A1FC8DA32C2/"
    wormData.pics["Tessia Vernius"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251901/38DEC17448EF01FE1D9C4BF402EA5864A07DBF31/"
    wormData.pics["Prince Rhombur"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251758/471BF295C71548463E1B1980E933911EA4C620E6/"
    wormData.pics["Rabban 'The Beast'"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251857/541AF590F49C02EB4D75E1188355B504A657E8F2/"
    wormData.pics["Ilesa Ecaz"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251553/2A9487D3C7E3546EC0272001965FBEFAB6F9324E/"
    wormData.pics["Duke Leto"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251596/CC72D93C394CB1ECD456DF514D0746BE252F8D14/"
    wormData.pics["Viscount Hundro"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251459/E06835C878941E36867616FC354BD9E1CE578B72/"
    wormData.pics["Paul Atreides"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251699/8E702CE9D1470D280C4BA616B41FA9CEB0265EC0/"
    wormData.pics["Princess Yuna"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251815/17C22AFCDBF5ED0B4743D98D4F7CBA2B52D3E133/"
    wormData.pics["Earl Memnon"] =
        "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251647/6E26B748A38B5FADF1A719C33E9E8EC591285052/"

    wormData.vptray = {}
    wormData.vptray["Red"] = getObjectFromGUID("e0ed4b")
    wormData.vptray["Green"] = getObjectFromGUID("caaba4")
    wormData.vptray["Yellow"] = getObjectFromGUID("99a860")
    wormData.vptray["Blue"] = getObjectFromGUID("121bb6")

    wormData.points = {}
    wormData.points["Blue"] = nil
    wormData.points["Red"] = nil
    wormData.points["Yellow"] = nil
    wormData.points["Green"] = nil

end

function firstStep()
    wormData.tournament_mode = true
    UI.show("firstPanel")
end

function updateTournamentToken(player, value, element) game_id = value end

function secondStep()
    generateGameToken()
    for _, player in ipairs(Player.getPlayers()) do
        if allGood(player) then
            local color = player.color
            results[color] = {}
            results[color]["color"] = color
            results[color]["name"] = player.steam_name
            results[color]["id"] = player.steam_id
            -- UI.setAttribute("agree_" .. color, "text", player.steam_name)
        end
    end
    submitScreenButton()
end

function submitScreenButton()
    UI.hide("firstPanel")
    UI.hide("scorePanel")
    UI.show("secondPanel")
end

function openScoreScreen()

    UI.hide("secondPanel")
    UI.show("scorePanel")

    Wait.frames(refreshResults, 2)
end

function lookForProblems()
    if gameWasSubmitted then return end

    local rankList = {
        UI.getAttribute("rank_red", "text"),
        UI.getAttribute("rank_green", "text"),
        UI.getAttribute("rank_yellow", "text"),
        UI.getAttribute("rank_blue", "text")
    }
    for i = 1, 3 do
        for j = i + 1, 4 do
            if rankList[i] == rankList[j] then
                broadcastToAll(
                    'ERROR: Two or more players are tied in rank. Resolve this before submitting.')
                UI.setAttribute("submit", "interactable", "false")
                UI.setAttribute("submit", "color", "red")
                UI.setAttribute("submit", "textColor", "white")
                UI.setAttribute("submit", "text", "Resolve tie first!")
                return
            end
        end
    end

    vpRed = tonumber(UI.getAttribute("points_red", "text"))
    vpGreen = tonumber(UI.getAttribute("points_green", "text"))
    vpYellow = tonumber(UI.getAttribute("points_yellow", "text"))
    vpBlue = tonumber(UI.getAttribute("points_blue", "text"))
    if vpRed < 10 and vpGreen < 10 and vpYellow < 10 and vpBlue < 10 then
        UI.setAttribute("reminder", "text", "")
        UI.setAttribute("submit", "interactable", "false")
        UI.setAttribute("submit", "color", "red")
        UI.setAttribute("submit", "textColor", "white")
        UI.setAttribute("submit", "text", "Game not finished.")
        return
    end

    UI.setAttribute("reminder", "text", "Take a screenshot!")
    UI.setAttribute("submit", "interactable", "true")
    UI.setAttribute("submit", "color", "blue")
    UI.setAttribute("submit", "textColor", "white")
    UI.setAttribute("submit", "text", "Submit?")
end

function changeValue(player, value, element)
    UI.setAttribute(element, "text", value)
    Wait.frames(lookForProblems, 2)
end

function changeToggle(player, value, element)
    UI.setAttribute(element, "isOn", value)
    Wait.frames(lookForProblems, 2)
end

function disableSubmitButton()
    UI.setAttribute("submit", "interactable", "false")
    UI.setAttribute("submit", "color", "purple")
    UI.setAttribute("submit", "textColor", "yellow")
    UI.setAttribute("submit", "text", "SUCCESS!")
end

function formCallback(request)
    if request.is_error then
        broadcastToAll('There was an error!')
        broadcastToAll(request.text)
        gameWasSubmitted = false
    else
        broadcastToAll(
            'It looks like the game was submitted, but save your screenshot!')
        disableSubmitButton()
    end
end

function webServerCallbackSK(request)
    if request.is_error then
        broadcastToAll('The server (sk) will be consuming the game.')
    else
        broadcastToAll('The game was submitted to the wb server.')
        disableSubmitButton()
    end
end

function webServerCallbackWB(request)
    if request.is_error then
        broadcastToAll('The server (wb) will be consuming the game.')
    else
        broadcastToAll('The game was submitted to the sk server.')
        disableSubmitButton()
    end
end

function sendForm(submitter)
    if gameWasSubmitted then
        broadcastToAll('Results were already submitted.')
        disableSubmitButton()
        return
    end

    -- UI.setAttribute("submit", "interactable", "false")

    round = helperModule.countRound()

    local meeples = getObjectFromGUID("83ea90").getObjects()
    for _, meeple in ipairs(meeples) do
        if meeple.getName() == "Yellow Swordmaster" then
            wormData.swordMasterRound["Yellow"] = meeple.getGMNotes()
        elseif meeple.getName() == "Green Swordmaster" then
            wormData.swordMasterRound["Green"] = meeple.getGMNotes()
        elseif meeple.getName() == "Blue Swordmaster" then
            wormData.swordMasterRound["Blue"] = meeple.getGMNotes()
        elseif meeple.getName() == "Red Swordmaster" then
            wormData.swordMasterRound["Red"] = meeple.getGMNotes()
        end
    end

    local meeples = getObjectFromGUID("c68e45").getObjects()
    for _, meeple in ipairs(meeples) do
        if meeple.getName() == "Yellow Swordmaster" then
            wormData.swordMasterRound["Yellow"] = meeple.getGMNotes()
        elseif meeple.getName() == "Green Swordmaster" then
            wormData.swordMasterRound["Green"] = meeple.getGMNotes()
        elseif meeple.getName() == "Blue Swordmaster" then
            wormData.swordMasterRound["Blue"] = meeple.getGMNotes()
        elseif meeple.getName() == "Red Swordmaster" then
            wormData.swordMasterRound["Red"] = meeple.getGMNotes()
        end
    end

    for _, playerColor in ipairs(constants.PLAYER_COLORS) do
        local objtsOnZone = constants.zone_player[playerColor].getObjects()
        for _, meeple in ipairs(objtsOnZone) do
            if meeple.getName() == "Yellow Swordmaster" then
                wormData.swordMasterRound["Yellow"] = meeple.getGMNotes()
            elseif meeple.getName() == "Green Swordmaster" then
                wormData.swordMasterRound["Green"] = meeple.getGMNotes()
            elseif meeple.getName() == "Blue Swordmaster" then
                wormData.swordMasterRound["Blue"] = meeple.getGMNotes()
            elseif meeple.getName() == "Red Swordmaster" then
                wormData.swordMasterRound["Red"] = meeple.getGMNotes()
            end
        end
    end

    local playerRed = {
        steamName = UI.getAttribute("name_red", "text"),
        steamId = results["Red"]["id"],
        placement = UI.getAttribute("rank_red", "text"),
        vp = UI.getAttribute("points_red", "text"),
        vpsList = "",
        spice = UI.getAttribute("spice_red", "text"),
        solari = UI.getAttribute("solari_red", "text"),
        water = UI.getAttribute("water_red", "text"),
        chamurky = "",
        startPos = "",
        leader = UI.getAttribute("leader_red", "text"),
        swordMasterRound = wormData.swordMasterRound["Red"],
        cards = {}
    }

    local playerGreen = {
        steamName = UI.getAttribute("name_green", "text"),
        steamId = results["Green"]["id"],
        placement = UI.getAttribute("rank_green", "text"),
        vp = UI.getAttribute("points_green", "text"),
        vpsList = "",
        spice = UI.getAttribute("spice_green", "text"),
        solari = UI.getAttribute("solari_green", "text"),
        water = UI.getAttribute("water_green", "text"),
        chamurky = "",
        startPos = "",
        leader = UI.getAttribute("leader_green", "text"),
        swordMasterRound = wormData.swordMasterRound["Green"],
        cards = {}
    }

    local playerYellow = {
        steamName = UI.getAttribute("name_yellow", "text"),
        steamId = results["Yellow"]["id"],
        placement = UI.getAttribute("rank_yellow", "text"),
        vp = UI.getAttribute("points_yellow", "text"),
        vpsList = "",
        spice = UI.getAttribute("spice_yellow", "text"),
        solari = UI.getAttribute("solari_yellow", "text"),
        water = UI.getAttribute("water_yellow", "text"),
        chamurky = "",
        startPos = "",
        leader = UI.getAttribute("leader_yellow", "text"),
        swordMasterRound = wormData.swordMasterRound["Yellow"],
        cards = {}
    }

    local playerBlue = {
        steamName = UI.getAttribute("name_blue", "text"),
        steamId = results["Blue"]["id"],
        placement = UI.getAttribute("rank_blue", "text"),
        vp = UI.getAttribute("points_blue", "text"),
        vpsList = "",
        spice = UI.getAttribute("spice_blue", "text"),
        solari = UI.getAttribute("solari_blue", "text"),
        water = UI.getAttribute("water_blue", "text"),
        chamurky = "",
        startPos = "",
        leader = UI.getAttribute("leader_blue", "text"),
        swordMasterRound = wormData.swordMasterRound["Blue"],
        cards = {}
    }

    startPosLookup = {}
    for i, color in ipairs(constants.PLAYER_COLORS) do
        startPosLookup[color] = constants.COLOR_ORDER[first_player][i]
    end

    playerRed.startPos = startPosLookup["Red"]
    playerGreen.startPos = startPosLookup["Green"]
    playerYellow.startPos = startPosLookup["Yellow"]
    playerBlue.startPos = startPosLookup["Blue"]
    ----------------------

    local game = {
        isRanked = "0",
        gameId = game_id,
        gameToken = gameToken,
        carryallVersion = "2",
        submitterSteamId = submitter.steam_id,
        submitterSteamName = submitter.steam_name,
        gameStartTimeStamp = gameStartTime,
        numberOfRounds = round,
        riseOfIx = rise_of_ix,
        immortality = immortality,
        tournament = "1",
        redGoFirst = redGoFirst,
        firstPlayer = first_player,
        timestamp = os.date("!%m/%d/%Y %H:%M:%S", os.time(os.date("!*t"))),
        leadersNotPicked = {},
        leaderPickOrder = leaderPickOrder,
        players = {}
    }

    -- Switch function
    _G.switch = function(param, case_table)
        local case = case_table[param]
        if case then return case() end
        local def = case_table['default']
        return def and def() or nil
    end
    ----------------------
    --- Get cards from players in the Draw deck + discart + play area  ---

    for playerColor, deckZone in pairs(constants.drawDeckZone) do
        local mainDeck = helperModule.GetDeckOrCard(deckZone)
        local discardDeck = helperModule.GetDeckOrCard(
                                constants.discardZone[playerColor])

        local cardsNames = {}
        if mainDeck then
            if mainDeck.type == "Card" then
                table.insert(cardsNames, mainDeck.getName())
            elseif mainDeck.type == "Deck" then
                for _, card in pairs(mainDeck.getObjects()) do
                    table.insert(cardsNames, card.name)
                end
            end
        end

        if discardDeck then
            if discardDeck.type == "Card" then
                table.insert(cardsNames, discardDeck.getName())
            elseif discardDeck.type == "Deck" then
                for _, card in pairs(discardDeck.getObjects()) do
                    table.insert(cardsNames, card.name)
                end
            end
        end

        local playCardsZonesTable = {}
        local playCardsZones = getObjectFromGUID(
                                   (constants.playCardsZones[playerColor]))

        if playCardsZones then
            for _, obj in ipairs(playCardsZones.getObjects()) do
                if obj.type == "Card" or obj.type == "Deck" then
                    table.insert(playCardsZonesTable, obj)
                end
            end
        end

        if playCardsZones then
            for _, cardsInPlayerPlayzone in ipairs(playCardsZonesTable) do
                if cardsInPlayerPlayzone then
                    if cardsInPlayerPlayzone.type == "Card" then
                        if cardsInPlayerPlayzone.getName() ~= "" then
                            table.insert(cardsNames,
                                         cardsInPlayerPlayzone.getName())
                        end
                    elseif cardsInPlayerPlayzone.type == "Deck" then
                        for _, card in
                            ipairs(cardsInPlayerPlayzone.getObjects()) do
                            if card.name ~= "" then
                                table.insert(cardsNames, card.name)
                            end
                        end
                    end
                end
            end
        end

        switch(playerColor, {
            ["Red"] = function() playerRed.cards = cardsNames end,
            ["Green"] = function() playerGreen.cards = cardsNames end,
            ["Yellow"] = function() playerYellow.cards = cardsNames end,
            ["Blue"] = function() playerBlue.cards = cardsNames end,
            ["default"] = function()
                print("Error: playerColor not found")
            end
        })
    end

    for _, color in ipairs(constants.PLAYER_COLORS) do
        local vpList = {}
        vp_zone = constants.vp_zone[color]
        local zoneObjects = vp_zone.getObjects()
        for i, object in ipairs(zoneObjects) do
            if object.getDescription() == "VP" then
                table.insert(vpList, object.getName())
            end
        end
        switch(color, {
            ["Red"] = function() playerRed.vpsList = vpList end,
            ["Green"] = function() playerGreen.vpsList = vpList end,
            ["Yellow"] = function() playerYellow.vpsList = vpList end,
            ["Blue"] = function() playerBlue.vpsList = vpList end,
            ["default"] = function()
                print("Error: playerColor not found")
            end
        })
    end

    table.insert(game.players, playerRed)
    table.insert(game.players, playerGreen)
    table.insert(game.players, playerYellow)
    table.insert(game.players, playerBlue)

    function containsWord(s, word)
        return s:match("%f[%a]" .. word .. "%f[%A]") ~= nil
    end

    for i, v in ipairs(getObjectFromGUID("550f6d").getObjects()) do
        if not containsWord(v.getName(), "Token") then
            if not containsWord(v.getName(), "Board") then
                table.insert(game.leadersNotPicked, v.getName())
            end
        end
    end

    local json = JSON.encode(game)

    -- post to dunerank webServer
    local headers = {
        ["Content-Type"] = "application/json",
        Accept = "application/json"
    }
    WebRequest.custom(constants.API_ENDPOINT_BASE_URL ..
                          constants.API_GAME_SUBMIT, "POST", false, json,
                      headers, webServerCallbackWB)
    WebRequest.custom(constants.API_ENDPOINT_WEB .. constants.API_GAME_SUBMIT,
                      "POST", false, json, headers, webServerCallbackSK)

    local infoTable = {
        ["entry.2126893034"] = "0", -- is_ranked
        ["entry.447092407"] = game_id, -- game_id
        ["entry.40772176"] = "2", -- carryall_version. Increment this value by 1 each release.
        ["entry.1195859029"] = submitter.steam_id, -- submitter_steam_id
        ["entry.980559040"] = submitter.steam_name, -- submitter_steam_name
        ["entry.779373663"] = startTime, -- game_start_timestamp
        ["entry.234195300"] = round, -- n_rounds

        ["entry.82402215"] = results["Red"]["id"], -- p1_steam_id
        ["entry.1635429235"] = UI.getAttribute("name_red", "text"), -- p1_steam_name
        ["entry.419710564"] = UI.getAttribute("rank_red", "text"), -- p1_placement
        ["entry.1878523358"] = UI.getAttribute("points_red", "text"), -- p1_total_points
        ["entry.1073272736"] = "", -- p1_vps_list
        ["entry.178708796"] = UI.getAttribute("spice_red", "text"), -- p1_spice
        ["entry.312713987"] = UI.getAttribute("solari_red", "text"), -- p1_solari
        ["entry.377801515"] = UI.getAttribute("water_red", "text"), -- p1_water
        ["entry.1566289571"] = "", -- p1_chamurky
        ["entry.220375463"] = playerRed.startPos, -- p1_startpos
        ["entry.565786681"] = UI.getAttribute("leader_red", "text"), -- p1_leader

        ["entry.926384740"] = results["Green"]["id"], -- p2_steam_id
        ["entry.8189124"] = UI.getAttribute("name_green", "text"), -- p2_steam_name
        ["entry.829300525"] = UI.getAttribute("rank_green", "text"), -- p2_placement
        ["entry.1498362639"] = UI.getAttribute("points_green", "text"), -- p2_total_points
        ["entry.1338086196"] = "", -- p2_vps_list
        ["entry.2112800604"] = UI.getAttribute("spice_green", "text"), -- p2_spice
        ["entry.97230832"] = UI.getAttribute("solari_green", "text"), -- p2_solari
        ["entry.1615516743"] = UI.getAttribute("water_green", "text"), -- p2_water
        ["entry.431493524"] = "", -- p2_chamurky
        ["entry.516704953"] = playerGreen.startPos, -- p2_startpos
        ["entry.126177821"] = UI.getAttribute("leader_green", "text"), -- p2_leader

        ["entry.1056344986"] = results["Yellow"]["id"], -- p3_steam_id
        ["entry.1000335964"] = UI.getAttribute("name_yellow", "text"), -- p3_steam_name
        ["entry.1815125303"] = UI.getAttribute("rank_yellow", "text"), -- p3_placement
        ["entry.1006025268"] = UI.getAttribute("points_yellow", "text"), -- p3_total_points
        ["entry.405019323"] = "", -- p3_vps_list
        ["entry.1485294161"] = UI.getAttribute("spice_yellow", "text"), -- p3_spice
        ["entry.1960273034"] = UI.getAttribute("solari_yellow", "text"), -- p3_solari
        ["entry.2103268491"] = UI.getAttribute("water_yellow", "text"), -- p3_water
        ["entry.1546563705"] = "", -- p3_chamurky
        ["entry.1730389595"] = playerYellow.startPos, -- p3_startpos
        ["entry.555758857"] = UI.getAttribute("leader_yellow", "text"), -- p3_leader

        ["entry.724137382"] = results["Blue"]["id"], -- p4_steam_id
        ["entry.79132597"] = UI.getAttribute("name_blue", "text"), -- p4_steam_name
        ["entry.1095237101"] = UI.getAttribute("rank_blue", "text"), -- p4_placement
        ["entry.1786102321"] = UI.getAttribute("points_blue", "text"), -- p4_total_points
        ["entry.654442789"] = "", -- p4_vps_list
        ["entry.1200193803"] = UI.getAttribute("spice_blue", "text"), -- p4_spice
        ["entry.848733094"] = UI.getAttribute("solari_blue", "text"), -- p4_solari
        ["entry.767203598"] = UI.getAttribute("water_blue", "text"), -- p4_water
        ["entry.2048085041"] = "", -- p4_chamurky
        ["entry.1751147952"] = playerBlue.startPos, -- p4_startpos
        ["entry.850152509"] = UI.getAttribute("leader_blue", "text"), -- p4_leader

        ["entry.879491944"] = immortality, -- immortality
        ["entry.550642770"] = "1" -- tournament2022        
    }

    -- post to google forms
    WebRequest.post(
        "https://docs.google.com/forms/u/0/d/e/1FAIpQLScGit6kyKI_5It9aZAM82KNCBQ4RC0dQWxNA4DDwgj3z05zKA/formResponse",
        infoTable, formCallback)

    gameWasSubmitted = true

end

function allGood(player)
    if not player.seated then return false end

    local color = player.color
    if color == "Red" or color == "Green" or color == "Yellow" or color ==
        "Blue" then
        return true
    else
        return false
    end
end

function refreshResults()
    if gameWasSubmitted then disableSubmitButton() end

    techZone = constants.zone_player

    if wormData.vptray == nil then init() end

    if results == nil then results = {} end
    for _, player in pairs(results) do
        local color = player["color"]
        local victoryPoints = wormData.vptray[color].call("getScore")

        results[color]["chaumurky"] = 0
        for _, techObj in ipairs(techZone[color].getObjects()) do
            if techObj.getGUID() == "3c6492" then
                broadcastToAll(color .. " has Chaumurky", color)
                results[color]["chaumurky"] = 1
                break
            end
        end

        results[color]["rank"] = -1
        results[color]["points"] = victoryPoints
        local leaderObjs = resources[color][leader].getObjects()
        if leaderObjs == nil or #leaderObjs < 1 then
            results[color]["leader"] = "ERROR!"
        else
            results[color]["leader"] = leaderObjs[1].getName()
        end
        results[color]["spice"] = resources[color][spice].call("collectVal")
        results[color]["solari"] = resources[color][solari].call("collectVal")
        results[color]["water"] = resources[color][water].call("collectVal")
    end

    -- tables can't be sorted so we copy the values into an array
    local sortedResults = {}
    for _, value in pairs(results) do table.insert(sortedResults, value) end

    local tied = false
    table.sort(sortedResults, function(left, right)
        if left["points"] ~= right["points"] then
            return left["points"] > right["points"]
        elseif left["chaumurky"] ~= right["chaumurky"] then
            return left["chaumurky"] > right["chaumurky"]
        elseif left["spice"] ~= right["spice"] then
            return left["spice"] > right["spice"]
        elseif left["solari"] ~= right["solari"] then
            return left["solari"] > right["solari"]
        elseif left["water"] ~= right["water"] then
            return left["water"] > right["water"]
        else
            tied = true
            return false
        end
    end)

    if tied then broadcastToAll("WARNING: Two or more players are tied.") end

    -- now we can extract the rankings
    for rank, value in pairs(sortedResults) do
        results[value["color"]]["rank"] = rank
    end

    UI.setAttribute("game_id", "text", game_id)

    UI.setAttribute("points_red", "text", results["Red"]["points"])
    UI.setAttribute("name_red", "text", results["Red"]["name"])
    UI.setAttribute("id_red", "text", results["Red"]["id"])
    UI.setAttribute("rank_red", "text", results["Red"]["rank"])
    UI.setAttribute("leader_red", "text", results["Red"]["leader"])
    UI.setAttribute("spice_red", "text", results["Red"]["spice"])
    UI.setAttribute("solari_red", "text", results["Red"]["solari"])
    UI.setAttribute("water_red", "text", results["Red"]["water"])

    UI.setAttribute("points_green", "text", results["Green"]["points"])
    UI.setAttribute("name_green", "text", results["Green"]["name"])
    UI.setAttribute("id_green", "text", results["Green"]["id"])
    UI.setAttribute("rank_green", "text", results["Green"]["rank"])
    UI.setAttribute("leader_green", "text", results["Green"]["leader"])
    UI.setAttribute("spice_green", "text", results["Green"]["spice"])
    UI.setAttribute("solari_green", "text", results["Green"]["solari"])
    UI.setAttribute("water_green", "text", results["Green"]["water"])

    UI.setAttribute("points_yellow", "text", results["Yellow"]["points"])
    UI.setAttribute("name_yellow", "text", results["Yellow"]["name"])
    UI.setAttribute("id_yellow", "text", results["Yellow"]["id"])
    UI.setAttribute("rank_yellow", "text", results["Yellow"]["rank"])
    UI.setAttribute("leader_yellow", "text", results["Yellow"]["leader"])
    UI.setAttribute("spice_yellow", "text", results["Yellow"]["spice"])
    UI.setAttribute("solari_yellow", "text", results["Yellow"]["solari"])
    UI.setAttribute("water_yellow", "text", results["Yellow"]["water"])

    UI.setAttribute("points_blue", "text", results["Blue"]["points"])
    UI.setAttribute("name_blue", "text", results["Blue"]["name"])
    UI.setAttribute("leader_blue", "text", results["Blue"]["leader"])
    UI.setAttribute("id_blue", "text", results["Blue"]["id"])
    UI.setAttribute("rank_blue", "text", results["Blue"]["rank"])
    UI.setAttribute("spice_blue", "text", results["Blue"]["spice"])
    UI.setAttribute("solari_blue", "text", results["Blue"]["solari"])
    UI.setAttribute("water_blue", "text", results["Blue"]["water"])
    Wait.frames(lookForProblems, 2)
end

function setOpenScoreBoard() UI.setAttribute("thirdPanel", "active", "true") end

scoreBoardUp = false

function firstScoreBoardRender()
    local composedXml = ''

    if wormData.vptray == nil then init() end

    local seatedPlayerCount = 0
    for _, thisPlayer in ipairs(Player.getPlayers()) do
        if allGood(thisPlayer) then
            seatedPlayerCount = seatedPlayerCount + 1
        end
    end

    if seatedPlayerCount < 3 then
        broadcastToColor(
            'Not enough seated players. Try again with at least 3 players.',
            'Black', 'Black')
        return
    end

    local panelHeight = 103 * seatedPlayerCount

    composedXml = [[
        <Panel visibility="Black" rectAlignment="UpperRight" class="Window"
        color="black" width="200" height="]] .. panelHeight .. [["
        allowDragging="True" returnToOriginalPositionWhenReleased="false">
        <TableLayout cellSpacing="4" autoCalculateHeight="true" columnWidths="100 100">
        ]]

    local leaderName = ''
    local thisColor = ''
    local leaderObjs = nil
    local points = nil
    local playerCount = 0
    for _, thisPlayer in ipairs(Player.getPlayers()) do
        thisColor = thisPlayer.color
        if wormData.vptray[thisColor] == nil then goto continue end

        points = wormData.vptray[thisColor].call("getScore")
        if points == nil then points = 0 end
        wormData.points[thisColor] = points

        leaderObjs = resources[thisColor][leader].getObjects()
        if leaderObjs == nil or #leaderObjs == 0 then goto continue end
        leaderName = leaderObjs[1].getName()

        composedXml = composedXml .. '<Row preferredHeight="100">'

        if wormData.pics[leaderName] then
            pic = wormData.pics[leaderName]
        else
            broadcastToAll('missing pic for ' .. leaderName, undefined)
            pic =
                "https://steamusercontent-a.akamaihd.net/ugc/2008072820073251943/862A2819BDA92202E094E955AE465E9B0EBCAD4C/"
        end

        composedXml = composedXml .. [[
                          <Cell width="50"><Panel padding="10" color="]] ..
                          thisColor .. [[">
                           <Image image="]] .. pic .. [["/>
                           </Panel>
                           </Cell> 
                           <Cell>
                           <Panel color="white">
                           <Text id="]] .. thisColor ..
                          [[points" fontSize="38" fontStyle="Bold" alignment="MiddleCenter" color="black">]] ..
                          wormData.points[thisColor] .. [[</Text></Panel></Cell>
                           </Row> ]]
        playerCount = playerCount + 1
        ::continue::
    end

    composedXml = composedXml .. '</TableLayout></Panel>'
    if playerCount == seatedPlayerCount then
        local existingXml = UI.getXml()
        UI.setXml(existingXml .. composedXml)
        scoreBoardUp = true
        UI.hide("thirdPanel")
    else
        broadcastToColor(
            'Not all seated players selected a leader. Try again after they did.',
            'Black', 'Black')
    end
end

function updateScores()
    if scoreBoardUp then
        for _, thisPlayer in ipairs(Player.getPlayers()) do
            thisColor = thisPlayer.color
            if wormData.vptray[thisColor] ~= nil then

                points = wormData.vptray[thisColor].call("getScore")
                if points == nil then points = 0 end
                wormData.points[thisColor] = points
                UI.setValue(thisColor .. "points", wormData.points[thisColor])
            end
        end
    end
end

function generateGameToken()
    for _, player in ipairs(Player.getPlayers()) do
        if player.host then
            WebRequest.get(constants.API_ENDPOINT_BASE_URL ..
                               constants.API_GAME_TOKEN .. player.steam_name,
                           function(request)
                if request.is_error then
                    log(request.error)
                else
                    gameToken = request.text
                end
            end)
        end
    end
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
return __bundle_require("Worm.20b33a.lua")
