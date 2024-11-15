-- Bundled by luabundle {"rootModuleName":"Counter PV Red.e0ed4b.lua","version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function (superRequire)
    local loadingPlaceholder = { [{}] = true }

    local register
    local modules = {}

    local require
    local loaded = {}

    register = function (name, body)
        if not modules[name] then
            modules[name] = body
        end
    end

    require = function (name)
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
__bundle_register("Counter PV Red.e0ed4b.lua", function (require, _LOADED, __bundle_register, __bundle_modules)
    -- compteur de Red
    previous_score = -1

    constants = require("Constants")

    setupObj = constants.setupObj

    function onload()
        self.interactable = false

        vp_zone = constants.vp_zone["Red"]
        marker = getObjectFromGUID("4feaca")

        marker_pos = {
            { 10.35, 3.1, -10.08 }, --0
            { 10.33, 3.1, -8.93 }, --1
            { 10.33, 3.1, -7.77 }, --2
            { 10.35, 3.1, -6.57 }, --3
            { 10.35, 3.1, -5.43 }, --4
            { 10.35, 3.1, -4.24 }, --5
            { 10.34, 3.1, -3.08 }, --6
            { 10.35, 3.1, -1.86 }, --7
            { 10.35, 3.1, -0.69 }, --8
            { 10.37, 3.1, 0.47 }, --9
            { 10.37, 3.1, 1.65 }, --10
            { 10.41, 3.1, 2.81 }, --11
            { 10.41, 3.1, 4.01 }, --12
            { 10.40, 3.1, 5.05 } -- au dessus c'est le soleil
        }
        score = 1
    end

    function CountPoints()
        local zoneObjects = vp_zone.getObjects()
        score = 0
        for i, object in ipairs(zoneObjects) do
            if object.getDescription() == "VP" then score = score + 1 end
        end
        local vpIndex = score + 1
        if vpIndex > 14 then vpIndex = 14 end

        marker.setPositionSmooth(marker_pos[vpIndex])
        marker.setRotationSmooth({ 0, 0, 0 }, false, false)
        if score ~= previous_score then setupObj.call("updateScores") end
        previous_score = score
    end

    function onObjectEnterScriptingZone(zone, enter_object)
        if zone.guid == vp_zone.guid then
            local name = enter_object.getDescription()
            if name == "VP" then CountPoints() end
        end
    end

    function onObjectLeaveScriptingZone(zone, enter_object)
        if zone.guid == vp_zone.guid then
            local name = enter_object.getDescription()
            if name == "VP" then CountPoints() end
        end
    end

    function getScore() return score end
end)
__bundle_register("Constants", function (require, _LOADED, __bundle_register, __bundle_modules)
    local constants = {}

    constants.setupObj = getObjectFromGUID("4a3e76")


    constants.imperium_deck_ix = "58c4c3"
    constants.imperium_deck_immortality = "88b666"
    constants.tleilaxu_deck = "dcad54"
    constants.reclaimed_forces = "3c772c"
    constants.intrigue_immortality = "a5dbab"
    constants.intrigue_ix = "afa5e5"
    constants.intrigue_base = "77d25d"
    constants.epic_cards = { '7ae7f5', 'fbaf9f', '497c84', '30b760' }

    constants.vp_zone = {
        ["Red"] = getObjectFromGUID('5b9a53'),
        ["Blue"] = getObjectFromGUID('376f34'),
        ["Green"] = getObjectFromGUID('0e374f'),
        ["Yellow"] = getObjectFromGUID('b25c3c')
    }

    constants.leaderPos = {
        ["Yellow"] = { 18.89, 2, -1.60 },
        ["Green"] = { 19.10, 2, 20.58 },
        ["Blue"] = { -18.98, 2, -1.60 },
        ["Red"] = { -19.23, 2, 20.35 }
    }

    constants.leaders = {
        yuna = { GUID = "0b6322" },
        hundro = { GUID = "6e3714" },
        memnon = { GUID = "d9daed" },
        ariana = { GUID = "4d862a" },
        ilesa = { GUID = "158da6" },
        armand = { GUID = "796f0a" },
        paul = { GUID = "2df658" },
        leto = { GUID = "9b6cdc" },
        tessia = { GUID = "1839fa" },
        rhombur = { GUID = "691ca6" },
        rabban = { GUID = "4cf050" },
        vladimir = { GUID = "98cae8" },
        ilban = { GUID = "78551e" },
        helena = { GUID = "5a8a9a" },

        -- fan made
        vorian = { GUID = "0cffc9" },
        butler = { GUID = "c34187" },
        scytale = { GUID = "14dbb8" },
        wensicia = { GUID = "5d90ae" },
        irulan = { GUID = "514559" },
        norma = { GUID = "80b577" },
        miles = { GUID = "7bdba3" },
        feyd = { GUID = "84581f" },
        esmar = { GUID = "ec4142" },
        metulli = { GUID = "5133d2" },
        margot = { GUID = "a35523" },
        memnon2 = { GUID = "f3082c" },
        hasimir = { GUID = "bff714" },
        otto = { GUID = "97564a" },
        abulurd = { GUID = "4f8d56" },
        rhombur2 = { GUID = "835042" },
        farok = { GUID = "73e664" },
        darwi = { GUID = "2bf676" },
        xavier = { GUID = "83b4e1" },
        whitmore = { GUID = "c4d7e4" }

    }

    constants.ressources = { -- 1 : épices, 2 : solaris, 3 : eau, 4 : troupes, 5 : cartes, 6 : zone leader, 7 : swordmaster, 8 : zone swordmaster, 9 : conseiller, 10 : zone conseiller, 11 : zone bonus conseiller, 12 : zone conseiller vanilla
        ["Red"] = { getObjectFromGUID("3074d4"), getObjectFromGUID("576ccd"), getObjectFromGUID("692c4d"), getObjectFromGUID("8ea4af"), getObjectFromGUID("3a9e65"), getObjectFromGUID("66cdbb"), getObjectFromGUID("ed3490"), { -18.85, 1.71, 22.89 }, getObjectFromGUID("f19a48"), { -0.83, 3, 9.52 }, { -28.10, 2, 6.11 }, { -1.04, 3, 9.59 } },
        ["Blue"] = { getObjectFromGUID("9cc286"), getObjectFromGUID("fa5236"), getObjectFromGUID("0afaeb"), getObjectFromGUID("b71dd9"), getObjectFromGUID("a0bb82"), getObjectFromGUID("681774"), getObjectFromGUID("a78ad7"), { -18.94, 1.71, 1.15 }, getObjectFromGUID("f5b14a"), { -1.57, 3, 9.52 }, { -28.25, 2, -15.73 }, { -1.76, 3, 9.59 } },
        ["Green"] = { getObjectFromGUID("22478f"), getObjectFromGUID("e597dc"), getObjectFromGUID("fa9522"), getObjectFromGUID("126c3c"), getObjectFromGUID("c7fb9b"), getObjectFromGUID("cf1486"), getObjectFromGUID("fb1629"), { 19.06, 1.66, 22.89 }, getObjectFromGUID("a0028d"), { 0.82, 3, 9.52 }, { 28.22, 2, 6.12 }, { 0.63, 3, 9.59 } },
        ["Yellow"] = { getObjectFromGUID("78fb8a"), getObjectFromGUID("c5c4ef"), getObjectFromGUID("f217d0"), getObjectFromGUID("6af67a"), getObjectFromGUID("17a08e"), getObjectFromGUID("a677e0"), getObjectFromGUID("635c49"), { 18.85, 1.65, 1.15 }, getObjectFromGUID("1be491"), { 1.55, 3, 9.52 }, { 28.23, 2, -15.97 }, { 1.35, 3, 9.59 } }
    }

    constants.pos_discard = {
        ["Red"] = { -13.77, 3, 20.45 },
        ["Blue"] = { -13.65, 3, -1.50 },
        ["Green"] = { 24.48, 3, 20.51 },
        ["Yellow"] = { 24.25, 3, -1.50 }
    }

    constants.drawDeckZone = {
        ["Red"] = "4f08fc",
        ["Blue"] = "907f66",
        ["Green"] = "6d8a2e",
        ["Yellow"] = "e6cfee"
    }

    constants.drawSpot = {
        ["Red"] = { -24.65, 2.2, 20.36 }, --location of draw snap
        ["Blue"] = { -24.38, 2.2, -1.50 },
        ["Green"] = { 13.68, 2.2, 20.52 },
        ["Yellow"] = { 13.54, 2.2, -1.50 },
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

    constants.pos_black_market = { { -7.61, 2, 24.5 }, { -5.05, 2, 24.5 }, { -2.49, 2, 24.5 } }

    constants.pos_trash_upper = { -4.27, 5, 34.54 }

    constants.pos_trash_lower = { -1.92, 2, -19.65 }

    constants.first_player_marker = getObjectFromGUID("1f5576")

    constants.first_player_positions = {
        ["Red"] = { -13.73, 1.71, 23.79 },
        ["Blue"] = { -13.79, 1.70, 1.92 },
        ["Green"] = { 13.71, 1.67, 24.20 },
        ["Yellow"] = { 13.49, 1.66, 1.92 }
    }

    constants.zone_deck_imperium = '8bd982'
    constants.zone_deck_tleilaxu = '14b2ca'

    constants.imperiumRow = {
        { zoneGuid = '3de1d0', pos = { -7.25, 2, 12.87 } },
        { zoneGuid = '356e2c', pos = { -4.75, 2, 12.87 } },
        { zoneGuid = '7edbb3', pos = { -2.25, 2, 12.87 } },
        { zoneGuid = '641974', pos = { 0.25, 2, 12.87 } },
        { zoneGuid = 'c6dbed', pos = { 2.75, 2, 12.87 } }
    }

    constants.tleilaxuRow = {
        { zoneGuid = 'e5ba35', pos = { -7.59, 2, 20.04 } },
        { zoneGuid = '1e5a32', pos = { -5.04, 2, 20.04 } }
    }

    constants.buy7_guid = '439df9'
    constants.buy8_guid = '363f98'

    constants.zone_black_market = { "323acb", "e96c10", "93de6d" }

    constants.reserve_troop_zone = {
        ["Red"] = getObjectFromGUID('ab8fdf'), -- inside reserve bowl: seems bit small
        ["Blue"] = getObjectFromGUID('2a520c'),
        ["Green"] = getObjectFromGUID('bdfade'),
        ["Yellow"] = getObjectFromGUID('ffbd81')
    }

    constants.pos_supply_bowls = {
        ["Red"] = { -24.63, 4.73, 23.89 },
        ["Blue"] = { -24.26, 4.67, 1.96 },
        ["Green"] = { 24.77, 4.69, 23.89 },
        ["Yellow"] = { 24.45, 4.57, 1.98 }
    }

    constants.pos_vp = {
        ["Red"] = {
            { -28.54, 2.5, 20.23 }, { -28.57, 2.5, 21.26 }, { -28.56, 2.5, 22.26 },
            { -28.56, 2.5, 23.26 }, { -28.56, 2.5, 24.28 }, { -28.57, 2.5, 25.25 },
            { -27.64, 2.5, 20.23 }, { -27.62, 2.5, 21.26 }, { -27.61, 2.5, 22.26 },
            { -27.64, 2.5, 23.26 }, { -27.61, 2.5, 24.28 }, { -27.61, 2.5, 25.25 },
            { -27.61, 4, 25.25 }
        },
        ["Blue"] = {
            { -28.52, 2.5, -1.92 }, { -28.54, 2.5, -0.89 }, { -28.54, 2.5, 0.11 },
            { -28.56, 2.5, 1.12 }, { -28.54, 2.5, 2.14 }, { -28.54, 2.5, 3.11 },
            { -27.62, 2.5, -1.92 }, { -27.6, 2.5, -0.89 }, { -27.59, 2.5, 0.11 },
            { -27.61, 2.5, 1.12 }, { -27.59, 2.5, 2.14 }, { -27.59, 2.5, 3.11 },
            { -27.59, 4, 3.11 }
        },
        ["Green"] = {
            { 27.67, 2.5, 20.14 }, { 27.65, 2.5, 21.17 }, { 27.65, 2.5, 22.17 },
            { 27.65, 2.5, 23.18 }, { 27.65, 2.5, 24.19 }, { 27.65, 2.5, 25.16 },
            { 28.57, 2.5, 20.14 }, { 28.59, 2.5, 21.17 }, { 28.6, 2.5, 22.17 },
            { 28.58, 2.5, 23.18 }, { 28.6, 2.5, 24.19 }, { 28.6, 2.5, 25.16 },
            { 28.6, 4, 25.16 }
        },
        ["Yellow"] = {
            { 27.62, 2.5, -2.10 }, { 27.6, 2.5, -1.08 }, { 27.61, 2.5, -0.07 },
            { 27.6,  2.5, 0.93 }, { 27.61, 2.5, 1.95 }, { 27.6, 2.5, 2.92 },
            { 28.53, 2.5, -2.10 }, { 28.55, 2.5, -1.08 }, { 28.55, 2.5, -0.07 },
            { 28.53, 2.5, 0.93 }, { 28.56, 2.5, 1.95 }, { 28.56, 2.5, 2.92 },
            { 28.56, 4, 2.92 }
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

    constants.PLAYER_COLORS = { "Red", "Green", "Yellow", "Blue" }
    constants.COLOR_ORDER = {
        Red = { "1", "2", "3", "4" },
        Green = { "2", "3", "4", "1" },
        Yellow = { "3", "4", "1", "2" },
        Blue = { "4", "1", "2", "3" }
    }

    return constants
end)
return __bundle_require("Counter PV Red.e0ed4b.lua")
