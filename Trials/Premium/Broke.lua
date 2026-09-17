local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true

TDS:Place("Militant", 6.31201171875, 1.000009536743164, 4.398539066314697, true)
TDS:Ready()

-- [ Wave 1 ] --
TDS:Upgrade(1)

-- [ Wave 3 ] --
TDS:Place("Militant", 6.254179954528809, 1.000009536743164, 7.407127380371094, true)
TDS:Upgrade(2)

-- [ Wave 4 ] --
TDS:Place("Militant", 9.326314926147461, 1.000009536743164, 7.3630828857421875, true)

-- [ Wave 5 ] --
TDS:Upgrade(3)
TDS:Upgrade(2)
TDS:Upgrade(1)

-- [ Wave 6 ] --
TDS:Upgrade(3)

-- [ Wave 9 ] --
TDS:VoteSkip(9)

-- [ Wave 10 ] --
TDS:Place("Gatling Gun", -0.3964524269104004, 5.376314163208008, -24.641199111938477, true)

-- [ Wave 11 ] --
TDS:Upgrade(4)

-- [ Wave 13 ] --
TDS:Upgrade(4)

-- [ Wave 17 ] --
TDS:Upgrade(4)

-- [ Wave 22 ] --
TDS:Upgrade(4)

-- [ Wave 26 ] --
TDS:Upgrade(4)

-- [ Wave 30 ] --
TDS:VoteSkip(30)

-- [ Wave 31 ] --
TDS:Upgrade(4)

-- [ Wave 32 ] --
TDS:Place("Mercenary Base", 0.19862687587738037, 1.000009536743164, -29.150108337402344, true)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:SetOption(5, "Unit 1", "Riot Guard")
TDS:SetOption(5, "Unit 3", "Riot Guard")
TDS:SetOption(5, "Unit 2", "Riot Guard")

-- [ Wave 33 ] --
TDS:Place("Mercenary Base", -4.402531623840332, 1.000009536743164, -29.11245346069336, true)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:SetOption(6, "Unit 1", "Riot Guard")
TDS:SetOption(6, "Unit 2", "Riot Guard")
TDS:SetOption(6, "Unit 3", "Riot Guard")
TDS:Place("Mercenary Base", 4.9249982833862305, 1.000009536743164, -29.118717193603516, true)

-- [ Wave 34 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:SetOption(7, "Unit 1", "Riot Guard")
TDS:SetOption(7, "Unit 2", "Riot Guard")
TDS:SetOption(7, "Unit 3", "Riot Guard")
TDS:Place("Medic", 0.19988727569580078, 1.000009536743164, -12.713384628295898, true)
TDS:Place("Medic", -2.844512939453125, 1.000009536743164, -12.712215423583984, true)
TDS:Place("Medic", -5.892308235168457, 1.000009536743164, -12.868677139282227, true)
TDS:Place("Medic", -2.580258369445801, 1.000009536743164, -15.94083023071289, true)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
Globals.AutoMedic = true
-- [ Wave 36 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(5)
TDS:Upgrade(5)

-- [ Wave 37 ] --
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:VoteSkip(37)

-- [ Wave 38 ] --
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(11)


-- [ Wave 39 ] --
TDS:Place("Hacker", 7.615595817565918, 1.000009536743164, 27.998157501220703, true)
TDS:Place("Hacker", 11.918306350708008, 1.000009536743164, 15.325929641723633, true)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:WaitForWave(40)

TDS:Ability(12, "Hologram Tower", {towerPosition = Vector3.new(-0.3964524269104004, 25.376314163208008, -24.641199111938477), towerToClone = 4}, true)
TDS:Ability(13, "Hologram Tower", {towerPosition = Vector3.new(-0.3964524269104004, 25.376314163208008, -24.641199111938477), towerToClone = 4}, true)
