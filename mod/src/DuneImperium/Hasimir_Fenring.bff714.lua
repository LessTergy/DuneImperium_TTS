-- Bundled by luabundle {"rootModuleName":"Hasimir Fenring.bff714.lua","version":"1.6.0"}
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
__bundle_register("Hasimir Fenring.bff714.lua", function(require, _LOADED, __bundle_register, __bundle_modules)
constants = require("Constants")

leaderPos = constants.leaderPos

i18n = require("i18n")
require("locales")

function onload(saved_data)
    if saved_data ~= '["claimed"]' then
        claimLabel()
    end

end

function updateSave()
    local data_to_save = {claimed}
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function claimLabel()
    self.createButton({
       click_function = "claimLeader",
       function_owner = self,
       label          = i18n("claimLeaderButton"),
       position       = {0.3,0.2,0.4},
       rotation       = {0, 0, 0},
       scale          = {0.75, 1, 0.75},
       width          = 600,
       height         = 150,
       tooltip        = "",
       font_color     = {1, 1, 1},
       font_size      = 85,
       color          = "Black"
       })
  end
       
  
  function claimLeader(GO, color)
    local t=0
    if color == "Red" or color == "Blue" or color == "Green" or color == "Yellow" then
      GO.setPositionSmooth(leaderPos[color])
      GO.setRotationSmooth({0,180,0})
      GO.clearButtons()
      Wait.time(function() GO.lock() end, 3)
      claimed = "claimed"
      updateSave()
      broadcastToAll(i18n("willBe"):format(i18n(color:lower())
,GO.getName()), color)
    else
      broadcastToColor(i18n("cantClaimLeader"), color, color)
    end
  end

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
return __bundle_require("Hasimir Fenring.bff714.lua")
