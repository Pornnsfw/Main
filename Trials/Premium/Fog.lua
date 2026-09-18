local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true
TDS:Mode("Trial")

TDS:Place("Trapper", -6.890721321105957, 0.9299085736274719, 33.54568099975586,  true)
TDS:Ready()

-- [ Wave 2 ] --
TDS:Upgrade(1)
TDS:Place("Trapper", -10.032605171203613, 0.9760749936103821, 34.14137649536133,  true)

-- [ Wave 3 ] --
TDS:Upgrade(2)

-- [ Wave 4 ] --
TDS:Place("Trapper", -13.159086227416992, 1.0143141746520996, 34.66229248046875,  true)

-- [ Wave 5 ] --
TDS:Upgrade(3)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Landmine")

-- [ Wave 6 ] --
TDS:SetTarget(2, "Last")
TDS:SetTarget(2, "Strongest")
TDS:SetTarget(2, "Weakest")
TDS:SetTarget(2, "Closest")

-- [ Wave 9 ] --
TDS:Place("Gatling Gun", 4.2299017906188965, 4.9513840675354, -34.7037239074707,  true)

-- [ Wave 11 ] --
TDS:Upgrade(4)

-- [ Wave 13 ] --
TDS:Upgrade(4)

-- [ Wave 16 ] --
TDS:Upgrade(4)

-- [ Wave 19 ] --
TDS:Upgrade(4)

-- [ Wave 26 ] --
TDS:Upgrade(4)

-- [ Wave 27 ] --
TDS:Upgrade(4)

-- [ Wave 28 ] --
TDS:Place("Medic", 0.5890030860900879, 4.959322452545166, -35.21307373046875,  true)
TDS:Place("Medic", -2.677302360534668, 4.96317195892334, -35.78282928466797,  true)
TDS:Place("Medic", 3.846081018447876, 4.966623306274414, -41.28699493408203,  true)
TDS:Place("Medic", 7.018693923950195, 4.95555305480957, -40.91440963745117,  true)

-- [ Wave 29 ] --
TDS:Place("Mercenary Base", 10.421979904174805, 4.942455291748047, -38.6832389831543,  true)
TDS:Place("Mercenary Base", -2.7399091720581055, 4.954736709594727, -31.952978134155273,  true)
TDS:Place("Mercenary Base", 1.613245964050293, 4.973018646240234, -44.30091857910156,  true)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)

-- [ Wave 32 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
Globals.AutoMedic = true
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

-- [ Wave 34 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)

-- [ Wave 35 ] --
TDS:Upgrade(10)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Bear Traps")
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Bear Traps")
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Landmine")
TDS:Place("Trapper", -10.612292289733887, 0.9938457012176514, 40.32221221923828,  true)
TDS:Place("Trapper", -7.548600673675537, 0.9650318622589111, 39.65617370605469,  true)
TDS:Place("Trapper", -4.256411552429199, 0.9284792542457581, 38.94483947753906,  true)
TDS:Place("Trapper", -0.8341817855834961, 0.9016615152359009, 38.39372634887695,  true)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:VoteSkip(35)
TDS:Upgrade(12)
TDS:SetOption(12, "Trap", "Bear Traps")
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Trap", "Landmine")

-- [ Wave 36 ] --
TDS:Upgrade(13)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Landmine")
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Landmine")

-- [ Wave 37 ] --
TDS:Place("Hacker", -6.80238676071167, 0.9829299449920654, 46.23255157470703,  true)
TDS:Place("Hacker", -6.577513694763184, 0.9749583005905151, 55.767189025878906,  true)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)

-- [ Wave 39 ] --
TDS:Upgrade(17, 2)
TDS:Upgrade(16, 2)
TDS:Ability(16, "Hologram Tower", {towerPosition = Vector3.new(-5.063486099243164, 4.970478057861328, -38.865142822265625), towerToClone = 4}, true)
