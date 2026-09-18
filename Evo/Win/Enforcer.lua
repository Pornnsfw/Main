local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true
TDS:Loadout("Trapper", "Gatling Gun", "Hacker", "Shotgunner", "EvolvedEnforcer")

TDS:Place("Trapper", 3.651508331298828, 263, 207.24977111816406)
TDS:Ready()

-- [ Wave 2 ] --
TDS:Place("Trapper", 3.593029022216797, 263, 208.05429077148438)
TDS:Place("Trapper", 4.210151672363281, 263, 207.1165771484375)

-- [ Wave 3 ] --
TDS:Place("Trapper", 4.2512969970703125, 263, 208.02134704589844)

-- [ Wave 4 ] --
TDS:Upgrade(1)

-- [ Wave 5 ] --
TDS:Upgrade(2)
TDS:Place("Trapper", 4.695913314819336, 263, 207.9593048095703)

-- [ Wave 6 ] --
TDS:Place("Trapper", 4.868358612060547, 263, 207.14488220214844)
TDS:Upgrade(1)

-- [ Wave 7 ] --
TDS:SetOption(1, "Trap", "Landmine")
TDS:Upgrade(4)
TDS:Upgrade(3)
TDS:Upgrade(5)

-- [ Wave 8 ] --
TDS:Upgrade(6)

-- [ Wave 9 ] --
TDS:Place("Trapper", 3.746623992919922, 263, 209.08413696289062)
TDS:Upgrade(7)

-- [ Wave 10 ] --
TDS:Upgrade(6)

-- [ Wave 12 ] --
TDS:Place("Gatling Gun", 2.7174906730651855, 263, 156.28396606445312)
TDS:Upgrade(8)

-- [ Wave 13 ] --
TDS:Place("Hacker", -3.3838653564453125, 263.99998474121094, 280.3294372558594)
TDS:Upgrade(9)
TDS:Upgrade(9)

-- [ Wave 14 ] --
TDS:Place("Hacker", 2.9317703247070312, 263.99998474121094, 269.7218933105469)
TDS:Upgrade(10)
TDS:Upgrade(10)

-- [ Wave 15 ] --
TDS:Upgrade(8)

-- [ Wave 17 ] --
TDS:Upgrade(8)

-- [ Wave 20 ] --
TDS:Upgrade(8)

-- [ Wave 21 ] --
TDS:Upgrade(9)
TDS:Upgrade(10)

-- [ Wave 25 ] --
TDS:Upgrade(9)

-- [ Wave 26 ] --
TDS:Upgrade(10)

-- [ Wave 27 ] --
TDS:Ability(10, "Hologram Tower", {towerPosition = Vector3.new(-2.6452383995056152, 263, 155.88705444335938), towerToClone = 8}, true)

-- [ Wave 29 ] --
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(7)

-- [ Wave 30 ] --
TDS:Upgrade(7)
TDS:SetOption(7, "Trap", "Bear Traps")

-- [ Wave 31 ] --
TDS:Upgrade(8)

-- [ Wave 32 ] --
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Bear Traps")
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:SetOption(4, "Trap", "Landmine")

-- [ Wave 33 ] --
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Bear Traps")

-- [ Wave 34 ] --
TDS:Ability(9, "Hologram Tower", {towerPosition = Vector3.new(-3.4562973976135254, 263, 156.14068603515625), towerToClone = 8}, true)

-- [ Wave 36 ] --

-- [ Wave 37 ] --
-- [ Wave38 ] --
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:SetOption(5, "Trap", "Bear Traps")
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:SetOption(6, "Trap", "Bear Traps")

-- [ Wave 39 ] --
TDS:VoteSkip(39)

-- [ Wave 40 ] --
TDS:WaitForWave(40)
TDS:Upgrade(9, 2)
TDS:Upgrade(10, 2)
TDS:Place("Shotgunner", -3.3329086303710938, 263.99998474121094, 266.528564453125)
TDS:Place("EvolvedEnforcer", -3.3329086303710938, 263.99998474121094, 266.528564453125)
