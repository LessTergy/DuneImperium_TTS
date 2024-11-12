-- Bundled by luabundle {"rootModuleName":"Spice.78fb8a.lua","version":"1.6.0"}
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
__bundle_register("Spice.78fb8a.lua", function (require, _LOADED, __bundle_register, __bundle_modules)
    MIN_VALUE = 0
    MAX_VALUE = 99

    function onload(saved_data)
        i18n = require("i18n")
        require("locales")

        self.interactable = false

        light_mode = false
        tooltip_show = true
        val = 0
        oldVal = 0

        if saved_data ~= "" then
            local loaded_data = JSON.decode(saved_data)
            light_mode = loaded_data[1]
            val = loaded_data[2]
            tooltip_show = loaded_data[3]
            oldVal = loaded_data[4]
        end

        createAll()
    end

    function updateSave()
        local data_to_save = { light_mode, val, tooltip_show, oldVal }
        saved_data = JSON.encode(data_to_save)
        self.script_state = saved_data
    end

    function createAll()
        s_color = { 0.5, 0.5, 0.5, 95 }

        if light_mode then
            f_color = { 0.9, 0.9, 0.9, 95 }
        else
            f_color = { 0.1, 0.1, 0.1, 100 }
        end

        if tooltip_show then
            ttText = "     " .. val .. "\n" .. i18n("spice")
        else
            ttText = i18n("spice")
        end

        self.createButton({
            label = tostring(val),
            click_function = "add_subtract",
            tooltip = ttText,
            function_owner = self,
            position = { 0, 0.05, 0.2 },
            height = 600,
            width = 1000,
            alignment = 3,
            scale = { x = 1.5, y = 1.5, z = 1.5 },
            font_size = 800,
            font_color = f_color,
            color = { 0, 0, 0, 0 }
        })

        if tooltip_show then
            tooltipShowText = "[ Hide value in tooltip ]"
        else
            tooltipShowText = "[ Show value in tooltip ]"
        end
        self.createButton({
            label = tooltipShowText,
            tooltip = tooltipShowText,
            click_function = "swap_tooltip",
            function_owner = self,
            position = { 0, -0.05, 0.2 },
            rotation = { 180, 180, 0 },
            height = 250,
            width = 1200,
            scale = { x = 1, y = 1, z = 1 },
            font_size = 150,
            font_color = s_color,
            color = { 0, 0, 0, 0 }
        })

        if light_mode then
            lightButtonText = "[ Set dark text ]"
        else
            lightButtonText = "[ Set light text ]"
        end
        self.createButton({
            label = lightButtonText,
            tooltip = lightButtonText,
            click_function = "swap_fcolor",
            function_owner = self,
            position = { 0, -0.05, 0.6 },
            rotation = { 180, 180, 0 },
            height = 150,
            width = 1200,
            scale = { x = 1, y = 1, z = 1 },
            font_size = 150,
            font_color = s_color,
            color = { 0, 0, 0, 0 }
        })

        self.createButton({
            label = "[ Reset ]",
            tooltip = "[ Reset ]",
            click_function = "reset_val",
            function_owner = self,
            position = { 0, -0.05, 1.4 },
            rotation = { 180, 180, 0 },
            height = 250,
            width = 1200,
            scale = { x = 1, y = 1, z = 1 },
            font_size = 250,
            font_color = s_color,
            color = { 0, 0, 0, 0 }
        })

        self.createInput({
            value = "#",
            label = "...",
            input_function = "keepSample",
            function_owner = self,
            alignment = 3,
            position = { 0, -0.05, -0.8 },
            rotation = { 180, 180, 0 },
            width = 600,
            height = 800,
            font_size = 1200,
            scale = { x = 1, y = 1, z = 1 },
            font_color = f_color,
            color = { 0, 0, 0, 0 }
        })

        setTooltips()
    end

    function removeAll()
        self.removeInput(0)
        self.removeButton(0)
        self.removeButton(1)
        self.removeButton(2)
        self.removeButton(3)
    end

    function reloadAll()
        removeAll()
        createAll()
        setTooltips()
        updateSave()
    end

    function swap_fcolor(_obj, _color, alt_click)
        light_mode = not light_mode
        reloadAll()
    end

    function swap_align(_obj, _color, alt_click)
        center_mode = not center_mode
        reloadAll()
    end

    function swap_tooltip(_obj, _color, alt_click)
        tooltip_show = not tooltip_show
        reloadAll()
        setTooltips()
    end

    function editName(_obj, _string, value)
        self.setName(value)
        setTooltips()
    end

    function add_subtract(_obj, _color, alt_click)
        local numberOfPlayers = #getObjectFromGUID("4a3e76").call("getPlayersBasedOnHotseat")
        local playerActingStr = ""
        local msgColor = _color


        if _color ~= "Yellow" and numberOfPlayers < 3 then
            playerActingStr = i18n("playerActing"):format(i18n(_color:lower()))
            msgColor = "Pink"
        end


        if _color ~= "Yellow" and numberOfPlayers > 2 then
            broadcastToColor(i18n("noTouch"), _color, _color)
        else
            mod = alt_click and -1 or 1
            new_value = math.min(math.max(val + mod, MIN_VALUE), MAX_VALUE)
            if val ~= new_value then
                val = new_value
                updateVal()
                updateSave()

                if scheduledInQueue ~= nil then
                    Wait.stop(scheduledInQueue)
                end

                scheduledInQueue = Wait.time(function ()
                    local delta = val - oldVal
                    local spice = i18n("spices")
                    if math.abs(delta) == 1 then
                        spice = i18n("spice")
                    end

                    if delta < 0 then
                        broadcastToAll(i18n("spentManually"):format(i18n("yellow"), math.abs(delta),
                                spice) ..
                            playerActingStr, msgColor)
                    end
                    if delta > 0 then
                        broadcastToAll(i18n("receiveManually"):format(i18n("yellow"), math.abs(delta),
                                spice) ..
                            playerActingStr, msgColor)
                    end
                    oldVal = val
                    updateSave()
                end, 1)
            end
        end
    end

    function updateVal()
        if tooltip_show then
            ttText = "     " .. val .. "\n" .. i18n("spice")
        else
            ttText = i18n("spice")
        end

        self.editButton({ index = 0, label = tostring(val), tooltip = ttText })
    end

    function reset_val()
        val = 0
        updateVal()
        updateSave()
    end

    function setTooltips()
        if tooltip_show then
            ttText = "     " .. val .. "\n" .. i18n("spice")
        else
            ttText = i18n("spice")
        end

        self.editButton({ index = 0, value = tostring(val), tooltip = ttText })
    end

    function null() end

    function keepSample(_obj, _string, value) reloadAll() end

    function incrementVal()
        val = val + 1
        oldVal = val
        updateVal()
        updateSave()
    end

    function decrementVal()
        val = val - 1
        oldVal = val
        updateVal()
        updateSave()
    end

    function collectVal() return val end
end)
__bundle_register("locales", function (require, _LOADED, __bundle_register, __bundle_modules)
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
        isDecidingToDraw =
        "%s is deciding wether to draw cards right away or not cause their discard will be reshuffled.",
        warningBeforeDraw =
        "Warning: Your discard will be reshuffled. Do you want to draw %s %s right away ? (You will have to draw manually if you cancel)",
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
        solari = "Solari",
        water = "Water",
        spices = "Spices",
        solaris = "Solaris",
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
        researchBeetle = "%s advance on the the Tleilaxu Track thanks to the Research Track.",
        researchIncome = "%s gain %s from the Research Track.",
        researchFaction = "%s gain 1 Faction Influence of their choice thanks to the Research Track.",
        researchTrashIntrigue =
        "%s can Trash one Intrigue to get another Intrigue and draw an Imperium card thanks to the Research Track.",
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
        rollbackWarning =
        "This feature is only for emergency rollback due to mistake (You cannot go back in immortality rules). Do you really mean to do this ?",
        specimenAdded = "%s added a Specimen",
        specimenLimitWarning =
        "You cannot place more than 6 specimens with the automated script cause of the limited space on the board !!",
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
        negotiatorLimitWarning =
        "You cannot place more than 4 Negotiators with the automated script cause of the limited space on the board !!",
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
        tiedAlliance =
        "2 joueurs ou plus sont à égalité pour l'Alliance %s. Choisissez un joueur à égalité pour lui donner votre Alliance.",
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
        mentatAlreadyTaken =
        "Le Mentat est déjà pris, voulez-vous malgré tout utiliser cette case pour juste piocher des cartes ?",
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
        troopTransport =
        "%s a recruté 3 Troupes grâce à la Technologie Transport de Troupes et peut les déployer immédiatement.",
        dividends = "Chaque autre joueur gagne 1 Solari grâce à leurs parts de la CHOAM.",
        fremenBonus = "%s a obtenu une Eau grâce à sa bonne réputation auprès des Fremens.",
        beneBonus = "%s a obtenu une Intrigue grâce à sa bonne réputation auprès du Bene Gesserit.",
        spaceBonus = "%s a obtenu %s Solaris grâce à sa bonne réputation auprès de la Guilde Spatiale.",
        emperorBonus = "%s a obtenu 2 Troupes grâce à sa bonne réputation auprès de l'Empereur.",
        flagBasin = " a obtenu 1 Épice pour avoir occupé le Bassin Impérial.",
        flagArrakeen = " a obtenu %s Solari pour l'occupation d'Arrakeen.",
        flagCarthag = " a obtenu %s Solari pour l'occupation de Carthag.",
        fenrig = " pioche une Intrigue supplémentaire et doit détruire une Intrigue.",
        isDecidingToDraw =
        "%s est en train de décider de piocher des cartes tout de suite ou non car sa défausse va être remélangée.",
        warningBeforeDraw =
        "Attention : Votre défausse va être remélangée. Voulez-vous piocher %s %s tout de suite ? (Vous devrez piocher manuellement si vous annulez)",
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
        solari = "Solari",
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
        researchTopMost =
        "Impossible d'aller plus vers le haut, votre jeton recherche est déjà sur un Hexagone tout au dessus.",
        researchBottomMost =
        "Impossible d'aller plus vers plus le bas, votre jeton recherche est déjà sur un Hexagone tout en bas.",
        researchEnd = "Vous ne pouvez plus avancer, vous êtes au maximum de la Recherche !!",
        researchStartingPos = "Vous ne pouvez plus faire de Rollback, vous êtes sur la position de départ !!",
        researchSpecimen = "%s obtient un Spécimen depuis la Piste de Recherche.",
        researchSpecimenBeetle = "%s obtient un Spécimen et avance sur la Piste Tleilaxu grâce à la Piste de Recherche.",
        researchSpecimenTrash = "%s obtient un Spécimen et peut Détruire une carte grâce à la Piste de Recherche.",
        researchBeetle = "%s avance sur la Piste Tleilaxu grâce à la Piste de Recherche.",
        researchIncome = "%s gagne %s depuis la Piste de Recherche.",
        researchFaction = "%s gagne 1 Influence de Faction au choix grâce à la Piste de Recherche.",
        researchTrashIntrigue =
        "%s peut Détruire une Intrigue pour obtenir une autre Intrigue et piocher une carte Imperium grâce à la Piste de Recherche.",
        researchAgain = "%s obtient une autre Recherche grâce à la Piste de Recherche.",
        confirmSolarisToBeetles = "Voulez-vous payer 7 Solaris pour avancer deux fois sur la Piste Tleilaxu ?",
        researchSolarisToBeetles =
        "%s a payé 7 Solaris sur la Piste de Recherche pour avancer deux fois sur la Piste Tleilaxu.",
        addSpecimen = "+1 Spécimen",
        spentSpecimen = "-1 Spécimen",
        tleilaxuButtonTooltip = "Avancer sur la Piste Tleilaxu",
        tleilaxuBackTooltip = "Reculer sur la Piste Tleilaxu",
        tleilaxuIncreased = "%s a avancé sur la Piste Tleilaxu.",
        tleilaxuDecreased = "%s est revenu en arrière sur la Piste Tleilaxu.",
        tleilaxuMax = "Vous êtes au maximum sur la Piste Tleilaxu.",
        rollbackWarning =
        "Cette fonction est uniquement présente en cas d'erreur. (Vous ne pouvez pas revenir en arrière dans les règles d'Immortality) Voulez-vous vraiment faire ça ?",
        specimenAdded = "%s a ajouté un Spécimen",
        specimenLimitWarning =
        "Vous ne pouvez pas placer plus de 6 spécimens avec le script automatisé en raison de l'espace limité sur le plateau !!",
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
        notSeated =
        "Certains joueurs ont des couleurs non autorisées,\nmerci de vous asseoir à la table ou de passer spectateurs.",
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
        reclaimedForcesTroopsWarning =
        "Voulez-vous vraiment dépenser 3 Spécimens pour ajouter des Troupes dans la Garnison ?",
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
        prescienceManual =
        "Vous devez regarder manuellement (ALT + MAJ) car il n'y a qu'une seule carte dans votre Deck.",
        addNegotiator = "+1 Négociateur",
        spendNegotiator = "-1 Négociateur",
        negotiatorAdded = "%s a ajouté un Négociateur.",
        negotiatorRemoved = "%s a récupéré un Négociateur.",
        negotiatorLimitWarning =
        "Vous ne pouvez pas placer plus de 4 Négociateurs avec le script automatisé en raison de l'espace limité sur le plateau !!",
        addNegotiatorManually = "Ajoutez manuellement votre Négociateur !!",
        noClockMode = "Il faut au moins 3 Joueurs pour le Mode Horloge !",
        clockModeActivated = "Mode Horloge activé, les chronos apparaîtront après que le Premier Conflit soit révélé.",
        noRedAsFirst = "Il faut 4 joueurs pour que le Rouge soit premier joueur sans tirage au sort."
    }
end)
__bundle_register("i18n", function (require, _LOADED, __bundle_register, __bundle_modules)
    local i18n = { locales = {} }

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

    setmetatable(i18n, { __call = function (_, ...) return i18n.translate(...) end })

    return i18n
end)
return __bundle_require("Spice.78fb8a.lua")
