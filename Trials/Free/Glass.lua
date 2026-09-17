local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoMercenary = true

TDS:Place("Trapper", -22.10948371887207, -1.3309587240219116, -0.1244668960571289)
TDS:Ready()

-- [ Wave 2 ] --
TDS:Place("Trapper", -19.199508666992188, -1.4956305027008057, -1.2158899307250977)
TDS:Upgrade(1)

-- [ Wave 3 ] --
TDS:Place("Trapper", -23.003957748413086, -1.1907671689987183, 2.8466434478759766)
TDS:Upgrade(2)

-- [ Wave 5 ] --
TDS:Upgrade(3)

-- [ Wave 6 ] --
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Landmine")
TDS:SetTarget(1, "Last")
TDS:SetTarget(1, "Strongest")
TDS:SetTarget(1, "Weakest")
TDS:SetTarget(1, "Closest")

-- [ Wave 8 ] --
TDS:VoteSkip(8)

-- [ Wave 9 ] --
TDS:VoteSkip(9)
TDS:Place("Gatling Gun", -28.280120849609375, -1.0543718338012695, -0.8959217071533203)

-- [ Wave 11 ] --
TDS:Upgrade(4)

-- [ Wave 12 ] --
TDS:Upgrade(4)

-- [ Wave 15 ] --
TDS:Upgrade(4)

-- [ Wave 19 ] --
TDS:Upgrade(4)

-- [ Wave 23 ] --
TDS:Upgrade(4)

-- [ Wave 27 ] --
TDS:Upgrade(4)

-- [ Wave 28 ] --
TDS:Place("Medic", -26.667156219482422, -1.2284495830535889, -5.048072814941406, true)
TDS:Place("Medic", -24.078548431396484, -1.3615680932998657, -6.6804351806640625)

-- [ Wave 29 ] --
TDS:Place("Medic", -21.217391967773438, -1.5022398233413696, -8.151348114013672)
TDS:Place("Medic", -28.427749633789062, -0.9045403003692627, 3.0308609008789062)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
Globals.AutoMedic = true
-- [ Wave 30 ] --
TDS:Place("Mercenary Base", -28.619915008544922, -0.8032532334327698, 7.022825241088867)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:Upgrade(9)
TDS:MedicSelect(5, 6)

-- [ Wave 31 ] --
TDS:Place("Mercenary Base", 16.5142879486084, -0.6936412453651428, 18.557025909423828)
TDS:Place("Mercenary Base", 21.423147201538086, -0.7101182341575623, 14.179484367370605)
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
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

-- [ Wave 33 ] --
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(10)
TDS:Upgrade(10)

-- [ Wave 34 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Place("Trapper", -19.97119140625, -1.3387326002120972, 2.4126243591308594)
TDS:Place("Trapper", -16.713220596313477, -1.641871452331543, -3.131206512451172)
TDS:Place("Trapper", -22.233840942382812, -1.1384508609771729, 5.995277404785156)
TDS:Place("Trapper", -16.494415283203125, -1.5660345554351807, 0.8561248779296875)

-- [ Wave 35 ] --
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Bear Traps")
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Landmine")
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:SetOption(12, "Trap", "Landmine")
TDS:Upgrade(12)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Landmine")
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)

-- [ Wave 36 ] --
TDS:SetOption(15, "Trap", "Bear Traps")
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Trap", "Bear Traps")

-- [ Wave 37 ] --
TDS:Place("Militant", -7.34818172454834, -1.4816205501556396, -33.14677047729492)
TDS:Place("Militant", -0.6324853897094727, -1.5216360092163086, -21.182769775390625)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
