local TDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pornnsfw/Main/refs/heads/main/API.lua"))()
local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoRejoin = true
 loadstring(game:HttpGet("https://raw.githubusercontent.com/avtryxz/autogutlin/refs/heads/main/autogutlin.lua"))()

TDS:Loadout("Trapper", "Gatling Gun", "Hacker", "Minigunner", "EvolvedJuggernaut")
TDS:Place("Trapper", 2.6528778076171875, 243, 206.70054626464844, true)
TDS:Ready()

-- [ Wave 1 ] --
TDS:Place("Trapper", -2.811603546142578, 242.99998474121094, 206.31039428710938, true)

-- [ Wave 2 ] --
TDS:Upgrade(2)

-- [ Wave 3 ] --
TDS:Upgrade(1)

-- [ Wave 8 ] --
TDS:Place("Gatling Gun", 2.7078866958618164, 243, 155.51145935058594, true)

-- [ Wave 9 ] --
TDS:Place("Hacker", 2.61263370513916, 242.99998474121094, 270.7286071777344, true)
TDS:Upgrade(4)
TDS:Upgrade(4)

-- [ Wave 10 ] --
TDS:Place("Hacker", -2.6056928634643555, 242.99998474121094, 278.767333984375, true)
TDS:Upgrade(5)
TDS:Upgrade(5)

-- [ Wave 11 ] --
TDS:Upgrade(3)

-- [ Wave 13 ] --
TDS:Upgrade(5)
TDS:SetTarget(4, "Last")

-- [ Wave 15 ] --
TDS:Upgrade(3)

-- [ Wave 16 ] --
TDS:Upgrade(4)

-- [ Wave 17 ] --
TDS:Upgrade(3)

-- [ Wave 20 ] --
TDS:Upgrade(3)

-- [ Wave 22 ] --
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Bear Traps")

-- [ Wave 24 ] --
TDS:Upgrade(4)

-- [ Wave 25 ] --

-- [ Wave 26 ] --
TDS:Upgrade(5)

-- [ Wave 27 ] --
TDS:Ability(4, "Hologram Tower", {towerPosition = Vector3.new(-2.7246172428131104, 263, 155.42352294921875), towerToClone = 3}, true)

-- [ Wave 29 ] --
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Bear Traps")
TDS:Ability(5, "Hologram Tower", {towerPosition = Vector3.new(-3.3700854778289795, 263, 155.4610137939453), towerToClone = 3}, true)

-- [ Wave 30 ] --
TDS:Upgrade(3)

-- [ Wave 31 ] --
TDS:Upgrade(3)
TDS:VoteSkip(31)

-- [ Wave 32 ] --
TDS:Place("Trapper", 3.1354408264160156, 242.99998474121094, 212.2087860107422, true)
TDS:Place("Trapper", -3.071197509765625, 242.99998474121094, 213.86251831054688, true)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:SetOption(7, "Trap", "Landmine")
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:SetOption(6, "Trap", "Landmine")

-- [ Wave 33 ] --

-- [ Wave 34 ] --
TDS:Place("Trapper", 2.8628807067871094, 242.99998474121094, 219.45379638671875, true)
TDS:Place("Trapper", -3.2501139640808105, 243.076904296875, 219.34518432617188, true)
TDS:Place("Trapper", 3.114480972290039, 243, 223.25364685058594, true)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Trap", "Bear Traps")
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:SetOption(8, "Trap", "Bear Traps")

-- [ Wave 35 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Trap", "Bear Traps")
TDS:VoteSkip(35)

-- [ Wave 36 ] --
TDS:VoteSkip(36)

-- [ Wave 37 ] --
TDS:VoteSkip(37)

-- [ Wave 38 ] --

-- [ Wave 39 ] --

-- [ Wave 40 ] --
TDS:WaitForWave(40)
TDS:Upgrade(4, 2)
TDS:Upgrade(5, 2)
TDS:Place("Minigunner", 3.7088470458984375, 242.99998474121094, 266.99835205078125, true)
TDS:Place("EvolvedJuggernaut", -4.840752601623535, 242.99998474121094, 266.62982177734375, true)
