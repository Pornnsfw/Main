--!strict
-- AutoTrialsRequirements.lua
-- Static trial/fallback requirements and strategy script URLs.

return {
 RevampAutoTrials = {
    ["Speedy Enemies"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Tesla", "Gatling Gun", "Medic", "Mercenary Base", "Trapper"},
            -- Example placeholder for Premium:
            -- ["Tower 2"] = {"Tesla", "Gatling Gun", "Medic", "Brawler", "Trapper"}, 
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Speedy.lua",
            -- ["Tower 2"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/SpeedyAlt.lua"
        }
    },
    ["Glass"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Hacker", "Gatling Gun", "Militant", "Mercenary Base", "Trapper"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Glass.lua"
        }
    },
    ["Quarantine"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Hacker", "Gatling Gun", "Militant", "Mercenary Base", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Quarantine.lua"
        }
    },
    ["Fog"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Trapper", "Hacker", "Gatling Gun", "Mercenary Base", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Fog.lua"
        }
    },
    ["Limitation"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Trapper", "Medic", "Gatling Gun", "Mercenary Base", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Limitation.lua"
        }
    },
    ["Flying Enemies"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Militant", "Gatling Gun", "Medic", "Mercenary Base", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Flying.lua"
        }
    },
    ["Jailed"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Scout", "Gatling Gun", "Militant", "Mercenary Base", "Paintballer", "Assassin", "DJ Booth", "Crook Boss"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Jailed.lua"
        }
    },
    ["Exploding Enemies"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Militant", "Gatling Gun", "Medic", "Mercenary Base", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Exploading.lua"
        }
    },
    ["Inflation"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Ace Pilot", "Trapper", "Gatling Gun", "DJ Booth", "Medic"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Inflation.lua"
        }
    },
    ["Committed"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Hacker", "Gatling Gun", "Medic", "Scout", "Demoman"}
        },
        Golden = {"Scout", "Demoman"},
        SkillTree = {
            ["Bigger Budget"] = 25,
            ["Fortify"] = 40,
            ["Stonks"] = 20,
            ["Over-Heal"] = 25,
            ["Bandages"] = 25,
            ["Accelerator"] = 25,
            ["Enhanced Optics"] = 20,
            ["Scavenger"] = 20,
            ["Improved Gunpowder"] = 25,
            ["Fight Dirty"] = 25,
            ["Precision"] = 15,
            ["Re-enforcements"] = 10,
            ["Extreme Conditioning"] = 25,
        },
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Committed.lua"
        }
    },
    ["Hidden Enemies"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Gatling Gun", "Medic", "Mercenary Base", "Militant", "DJ Booth"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Hidden.lua"
        }
    },
    ["Broke"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Gatling Gun", "Trapper", "Militant", "Mercenary Base", "Medic"},
            ["Tower 2"] = {"Gatling Gun", "Hacker", "Militant", "Mercenary Base", "Medic"}
        },
        Golden = {},
        SkillTree = {},
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/Main/refs/heads/main/Trials/Free/Broke.lua"
            ["Tower 2"] = "https://raw.githubusercontent.com/Pornnsfw/Main/refs/heads/main/Trials/Premium/Broke.lua"
        }
    },
    ["Healthy Enemies"] = {
        Level = 175,
        Towers = {
            ["Tower 1"] = {"Ace Pilot", "Mercenary Base", "DJ Booth", "Gatling Gun", "Medic"}
        },
        Golden = {},
        SkillTree = {
            ["Bigger Budget"] = 10,
            ["Fortify"] = 10,
            ["Stonks"] = 10,
            ["Over-Heal"] = 10,
            ["Bandages"] = 10,
            ["Accelerator"] = 10,
            ["Enhanced Optics"] = 10,
            ["Resourcefulness"] = 10,
        },
        scripts = {
            ["Tower 1"] = "https://raw.githubusercontent.com/Pornnsfw/HUB/refs/heads/main/PremiumTrials/Healthy.lua"
        }
    },
}
  
    fallbackScripts = {
        ["Easy"]         = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        ["Casual"]       = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        ["Intermediate"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        ["Molten"]       = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        ["Fallen"]       = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        ["Frost"]        = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
    },

    trialConfigs = {
        ["Speedy Enemies"] = {
            Level = 175,
            Towers = {"Tesla", "Gatling Gun", "Medic", "Mercenary Base", "Trapper"}, -- no skill tree, no gold, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Glass"] = {
            Level = 175,
            Towers = {"Hacker", "Gatling Gun", "Militant", "Mercenary Base", "Trapper"},
            Golden = {},
            SkillTree = {},
        },
        ["Quarantine"] = {
            Level = 175,
            Towers = {"Hacker", "Gatling Gun", "Militant", "Mercenary Base", "DJ Booth"},
            Golden = {},
            SkillTree = {},
        },
        ["Fog"] = {
            Level = 175,
            Towers = {"Trapper", "Hacker", "Gatling Gun", "Mercenary Base", "DJ Booth"},
            Golden = {},
            SkillTree = {},
        },
        ["Limitation"] = {
            Level = 175,
            Towers = {"Trapper", "Medic", "Gatling Gun", "Mercenary Base", "DJ Booth"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Flying Enemies"] = {
            Level = 175,
            Towers = {"Militant", "Gatling Gun", "Medic", "Mercenary Base", "DJ Booth"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Jailed"] = {
            Level = 175,
            Towers = {"Scout", "Gatling Gun", "Militant", "Mercenary Base", "Paintballer", "Assassin", "DJ Booth", "Crook Boss"}, -- no gold, no skill tree, no hardcore, - higher winrate chance
            Golden = {},
            SkillTree = {},
        },
        ["Exploding Enemies"] = {
            Level = 175,
            Towers = {"Militant", "Gatling Gun", "Medic", "Mercenary Base", "DJ Booth"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Inflation"] = {
            Level = 175,
            Towers = {"Ace Pilot", "Trapper", "Gatling Gun", "DJ Booth", "Medic"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Committed"] = {
            Level = 175,
            Towers = {"Hacker", "Gatling Gun", "Medic", "Scout", "Demoman"}, -- super exepsive 50% winrate
            Golden = {"Scout", "Demoman"},
            SkillTree = {
                ["Bigger Budget"] = 25,
                ["Fortify"] = 40,
                ["Stonks"] = 20,
                ["Over-Heal"] = 25,
                ["Bandages"] = 25,
                ["Accelerator"] = 25,
                ["Enhanced Optics"] = 20,
                ["Scavenger"] = 20,
				["Improved Gunpowder"] = 25,
				["Fight Dirty"] = 25,
				["Precision"] = 15,
				["Re-enforcements"] = 10,
				["Extreme Conditioning"] = 25,
            },
        },
      ["Hidden Enemies"] = {
            Level = 175,
            Towers = {"Gatling Gun", "Medic", "Mercenary Base", "Militant", "DJ Booth"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Broke"] = {
            Level = 175,
            Towers = {"Gatling Gun", "Trapper", "Militant", "Trapper", "DJ Booth", "Assassin"}, -- no gold, no skill tree, no hardcore
            Golden = {},
            SkillTree = {},
        },
        ["Healthy Enemies"] = {
            Level = 175,
            Towers = {"Ace Pilot", "Mercenary Base", "DJ Booth", "Gatling Gun", "Medic"}, -- No Gold, No Hardcore
            Golden = {},
            SkillTree = {
                ["Bigger Budget"] = 10,
                ["Fortify"] = 10,
                ["Stonks"] = 10,
                ["Over-Heal"] = 10,
                ["Bandages"] = 10,
                ["Accelerator"] = 10,
                ["Enhanced Optics"] = 10,
                ["Resourcefulness"] = 10,
            },
        },
    },

    -- Standard modes do not have a trial title, so fallback requirements stay separate.
   FallbackConfigs = {
    ["Easy"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Lay By", "Simplicity"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
    ["Casual"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Lay By", "Simplicity"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
    ["Intermediate"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Simplicity", "Lay By"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
    ["Molten"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Lay By", "Simplicity"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
    ["Fallen"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Lay By", "Simplicity"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
    ["Frost"] = {
        Level = 175,
        Towers = {"Gatling Gun", "Trapper", "Medic", "DJ Booth", "Mercenary Base"},
        Golden = {},
        SkillTree = {},
        Maps = {"Lay By", "Simplicity"},
        Scripts = {
            ["Lay By"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
            ["Simplicity"] = "https://raw.githubusercontent.com/AmonguszzZ/ModdedAether/refs/heads/main/Strats/Mode.lua",
        },
    },
},
    allTrialOptions = {
        "Exploding Enemies",
        "Fog",
        "Quarantine",
        "Speedy Enemies",
        "Glass",
        "Limitation",
        "Flying Enemies",
        "Jailed",
        "Inflation",
        "Committed",
        "Hidden Enemies",
        "Hidden",
        "Broke",
        "Healthy Enemies",
    },

    fallbackModesList = {
        "Molten",
        "Fallen",
    },
}
