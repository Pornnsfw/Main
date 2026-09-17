local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true
TDS:Mode("Trial")

TDS:Place("Militant", 17.750417709350586, 26.394407272338867, -156.91810607910156, true)
TDS:Ready()

-- [ Wave 1 ] --
TDS:Upgrade(1)

-- [ Wave 3 ] --
TDS:Upgrade(1)

-- [ Wave 5 ] --
TDS:Place("Militant", 19.06043243408203, 26.423812866210938, -157.50953674316406, true)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Place("Militant", 19.084596633911133, 28.273479461669922, -161.63673400878906, true)
TDS:Upgrade(3)

-- [ Wave 6 ] --
TDS:Upgrade(3)

-- [ Wave 9 ] --
TDS:VoteSkip(9)
TDS:Place("Gatling Gun", 65.8719711303711, 33.166709899902344, -148.67343139648438, true)

-- [ Wave 10 ] --
TDS:Upgrade(4)

-- [ Wave 12 ] --
TDS:Upgrade(4)

-- [ Wave 17 ] --
TDS:Upgrade(4)

-- [ Wave 23 ] --
TDS:Upgrade(4)

-- [ Wave 24 ] --
TDS:Upgrade(4)

-- [ Wave 28 ] --
TDS:Upgrade(4)

-- [ Wave 32 ] --
TDS:Place("Medic", 71.27108764648438, 28.86094093322754, -145.69227600097656, true)
TDS:Place("Medic", 70.29525756835938, 29.499937057495117, -148.4242706298828, true)
TDS:Place("Medic", 69.051513671875, 29.944259643554688, -150.7398223876953, true)
TDS:Place("Medic", 69.85575103759766, 29.86263084411621, -153.26766967773438, true)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
Globals.AutoMedic = true

-- [ Wave 33 ] --
TDS:Place("Mercenary Base", 62.05501937866211, 29.58336639404297, -151.96453857421875, true)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Grenadier")
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:Place("Mercenary Base", 81.91941833496094, 28.344154357910156, -142.18179321289062, true)
TDS:Place("Mercenary Base", 77.66292572021484, 28.352861404418945, -148.50045776367188, true)
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
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

-- [ Wave 34 ] --
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)

-- [ Wave 35 ] --
TDS:Place("Trapper", 17.00051498413086, 27.334186553955078, -145.3190155029297, true)
TDS:Place("Trapper", 17.487960815429688, 27.31978416442871, -150.97509765625, true)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
