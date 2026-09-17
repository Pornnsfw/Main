local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true

TDS:Loadout("Trapper", "Gatling Gun", "Medic", "Mercenary Base", "Hacker")
TDS:Place("Trapper", 2.810445785522461, 243, 207.17857360839844, true)
TDS:Ready()

-- [ Wave 2 ] --
TDS:Place("Trapper", -3.6782188415527344, 242.99998474121094, 207.2757568359375, true)

-- [ Wave 3 ] --
TDS:Upgrade(1)
TDS:Upgrade(2)

-- [ Wave 6 ] --
TDS:Place("Trapper", 2.861997604370117, 242.99998474121094, 212.19485473632812, true)

-- [ Wave 8 ] --
TDS:Upgrade(3)
TDS:VoteSkip(8)

-- [ Wave 9 ] --
TDS:VoteSkip(9)
TDS:Place("Gatling Gun", 2.9863929748535156, 243, 154.97462463378906, true)

-- [ Wave 12 ] --
TDS:Upgrade(4)

-- [ Wave 15 ] --
TDS:Upgrade(4)

-- [ Wave 17 ] --
TDS:Upgrade(4)

-- [ Wave 21 ] --
TDS:Upgrade(4)

-- [ Wave 22 ] --
TDS:Place("Medic", 2.763633966445923, 243, 158.39602661132812, true)
TDS:Place("Medic", 2.9182918071746826, 243, 160.81573486328125, true)
TDS:Place("Medic", 2.940459728240967, 243, 162.80609130859375, true)
TDS:Place("Medic", 3.092133045196533, 243, 164.96795654296875, true)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)

-- [ Wave 23 ] --
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
Globals.AutoMedic = true
TDS:Place("Mercenary Base", -3.1810455322265625, 243, 156.05453491210938, true)
TDS:Place("Mercenary Base", -3.1738734245300293, 243, 159.80682373046875, true)
TDS:Place("Mercenary Base", -3.1552157402038574, 243, 163.09356689453125, true)

-- [ Wave 26 ] --
TDS:Upgrade(4)

-- [ Wave 27 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)

-- [ Wave 28 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")

-- [ Wave 29 ] --
TDS:VoteSkip(29)

-- [ Wave 30 ] --
TDS:Upgrade(4)

-- [ Wave 32 ] --
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(9)
TDS:Upgrade(9)

-- [ Wave 33 ] --
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Bear Traps")
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Bear Traps")
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Bear Traps")

-- [ Wave 34 ] --
TDS:Place("Trapper", -3.1419029235839844, 242.99998474121094, 213.2861785888672, true)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:SetOption(12, "Trap", "Bear Traps")
TDS:Place("Trapper", 3.222662925720215, 243, 219.6001434326172, true)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Trap", "Bear Traps")
TDS:Place("Trapper", -2.786444664001465, 243.11184692382812, 221.65341186523438, true)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Bear Traps")
TDS:Place("Trapper", 3.8030624389648438, 242.99998474121094, 228.26480102539062, true)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Bear Traps")
TDS:Place("Hacker", -3.828462600708008, 242.99998474121094, 281.943359375, true)
TDS:Place("Hacker", 3.0264673233032227, 242.99998474121094, 269.5069885253906, true)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17, 2)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)

-- [ Wave 35 ] --
TDS:Upgrade(16)
TDS:Upgrade(16, 2)
TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(4.028531074523926, 263, 160.63613891601562), towerToClone = 4}, true)
