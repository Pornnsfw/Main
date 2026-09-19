local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true

 loadstring(game:HttpGet("https://raw.githubusercontent.com/avtryxz/autogutlin/refs/heads/main/autogutlin.lua"))()
TDS:Mode("Trial")

TDS:Place("Trapper", -7.582979202270508, 0.2561579942703247, 3.232050895690918,  true)
TDS:Ready()

-- [ Wave 1 ] --

-- [ Wave 2 ] --
TDS:Place("Trapper", -10.687474250793457, 0.371063768863678, 3.076357841491699,  true)
TDS:Upgrade(1)

-- [ Wave 4 ] --
TDS:Upgrade(2)
TDS:Place("Trapper", -13.756681442260742, 0.4265212416648865, 3.043254852294922,  true)
TDS:Upgrade(3)

-- [ Wave 5 ] --
TDS:Upgrade(2)

-- [ Wave 6 ] --
TDS:SetOption(2, "Trap", "Landmine")
TDS:SetTarget(2, "Last")
TDS:SetTarget(2, "Strongest")
TDS:SetTarget(2, "Weakest")
TDS:SetTarget(2, "Closest")

-- [ Wave 9 ] --
TDS:Place("Gatling Gun", 20.314252853393555, 0.7463734149932861, -7.332786560058594,  true)

-- [ Wave 10 ] --
TDS:Upgrade(4)

-- [ Wave 12 ] --
TDS:Upgrade(4)

-- [ Wave 13 ] --
TDS:Upgrade(3)

-- [ Wave 15 ] --
TDS:Upgrade(4)

-- [ Wave 28 ] --
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:Place("Medic", 14.104090690612793, 0.849151611328125, -6.890920162200928,  true)
TDS:Place("Medic", 14.26883316040039, 1.2653586864471436, -10.280129432678223,  true)

-- [ Wave 29 ] --
TDS:Place("Medic", 15.237065315246582, 0.3758990168571472, -3.6190013885498047,  true)
TDS:Place("Medic", 16.827171325683594, 0.012176096439361572, -0.7156953811645508,  true)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
Globals.AutoMedic = true
TDS:Place("Mercenary Base", 24.637155532836914, 0.5744336247444153, -6.553370475769043,  true)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)

-- [ Wave 30 ] --
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:Place("Mercenary Base", 20.953845977783203, 0.09887814521789551, -0.6531429290771484,  true)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")
TDS:Place("Mercenary Base", 25.526973724365234, 0.18209311366081238, -0.6413650512695312,  true)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")

-- [ Wave 31 ] --
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)

-- [ Wave 32 ] --
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(10)
TDS:Upgrade(10)

-- [ Wave 33 ] --
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(9)

-- [ Wave 34 ] --
TDS:Upgrade(9)

-- [ Wave 35 ] --
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Bear Traps")
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Bear Traps")
TDS:Place("Trapper", -7.197992324829102, 0.6072995066642761, -0.0676584243774414,  true)
TDS:Place("Trapper", -16.043546676635742, 0.6085028648376465, 0.8943347930908203,  true)
TDS:Place("Trapper", -16.10527801513672, 0.35067516565322876, -2.3174703121185303,  true)
TDS:Place("Trapper", -16.90013885498047, 0.618645429611206, -5.376672744750977,  true)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:SetOption(12, "Trap", "Landmine")
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Trap", "Landmine")
TDS:Upgrade(13)
TDS:Upgrade(14)
TDS:Upgrade(14)

-- [ Wave 36 ] --
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Landmine")
TDS:Place("Hacker", -25.415498733520508, 1.726061463356018, -1.796701431274414,  true)
TDS:Place("Hacker", -18.705839157104492, 0.9901490807533264, -9.66650104522705,  true)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)

TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(20.314252853393555, 20.7463734149932861, -7.332786560058594), towerToClone = 4}, true)
TDS:Ability(16, "Hologram Tower", {towerPosition = Vector3.new(20.314252853393555, 20.7463734149932861, -7.332786560058594), towerToClone = 4}, true)

TDS:WaitForWave(40)
TDS:Upgrade(17)
TDS:Upgrade(16)

