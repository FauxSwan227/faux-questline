Config = {}

Config.DebugCommand = true
Config.OpenKey = 'F7'
Config.CloseKey = 'ESCAPE'
Config.CancelKey = 'X'
Config.AutoOpenOnPlayerLoaded = false

Config.Inventory = {
    -- ox is the default because this server uses ox_inventory.
    -- Set to 'qb' if this resource is reused on a pure qb-inventory server.
    type = 'ox',
    cashAsItem = false,
    cashItem = 'cash',
    defaultMoneyAccount = 'cash'
}

Config.Brand = {
    logoText = 'S',
    logoImage = 'img/logo.png',
    product = 'Quests',
    version = ''
}

Config.Profile = {
    fallbackName = 'New Arrival',
    -- Optional integration point. Return a Discord CDN URL from here if your server has a
    -- Discord bridge/bot resource that can resolve user avatars.
    getAvatarUrl = function(source)
        return nil
    end
}

Config.Categories = {
    {
        id = 'civilian',
        label = 'Civilian Quests',
        shortLabel = 'Civilian',
        icon = 'user',
        accent = '#f08a42'
    },
    {
        id = 'lea',
        label = 'LEA Quests',
        shortLabel = 'Law Enforcement',
        icon = 'shield',
        accent = '#79b8ff'
    },
    {
        id = 'criminal',
        label = 'Criminal Quests',
        shortLabel = 'Criminal',
        icon = 'skull',
        accent = '#e85959'
    }
}

Config.Quests = {
    civilian = {
        {
            id = 'fresh_off_the_boat',
            order = 1,
            title = 'Fresh Off The Boat',
            description = 'Visit City Hall, obtain your legal identification documents, and register your first bank account.',
            reward = '$2,500 Cash',
            rewardType = 'cash',
            rewards = {
                money = {
                    amount = 2500,
                    account = 'cash'
                }
            },
            status = 'available'
        },
        {
            id = 'honest_worker',
            order = 2,
            title = 'The Honest Worker',
            description = 'Complete 5 delivery shifts for Post-OP to prove your work ethic to the local trade council.',
            reward = 'Panto Key',
            rewardType = 'vehicle',
            rewards = {
                items = {
                    {
                        name = 'vehiclekey',
                        amount = 1,
                        metadata = {
                            vehicle = 'panto',
                            quest = 'honest_worker'
                        }
                    }
                }
            },
            status = 'current'
        },
        {
            id = 'settling_in',
            order = 3,
            title = 'Settling In',
            description = 'Purchase your first clothing items from Binco to fit in with the local population.',
            reward = '50 XP',
            rewardType = 'xp',
            rewards = {
                xp = 50
            },
            status = 'completed'
        },
        {
            id = 'new_perspective',
            order = 4,
            title = 'A New Perspective',
            description = 'Unlock the city by meeting helpful locals around the Golden Station.',
            reward = 'Mystery Crate',
            rewardType = 'crate',
            rewards = {
                items = {
                    {
                        name = 'mystery_crate',
                        amount = 1,
                        metadata = {
                            source = 'questline'
                        }
                    }
                }
            },
            status = 'locked'
        }
    },
    lea = {
        {
            id = 'public_service',
            order = 1,
            title = 'Public Service',
            description = 'Meet a recruiter, learn department basics, and collect your application packet.',
            reward = 'Application Access',
            rewardType = 'access',
            rewards = {
                items = {
                    {
                        name = 'lea_application',
                        amount = 1
                    }
                }
            },
            status = 'available'
        },
        {
            id = 'ride_along',
            order = 2,
            title = 'Ride Along',
            description = 'Complete a supervised patrol route and report back to the station mentor.',
            reward = 'Cadet Badge',
            rewardType = 'badge',
            rewards = {
                items = {
                    {
                        name = 'cadet_badge',
                        amount = 1
                    }
                }
            },
            status = 'locked'
        }
    },
    criminal = {
        {
            id = 'whispers',
            order = 1,
            title = 'Whispers In The Alley',
            description = 'Find a street contact near the old motel and learn how reputation gates illegal work.',
            reward = 'Contact Number',
            rewardType = 'contact',
            rewards = {
                items = {
                    {
                        name = 'burner_phone',
                        amount = 1,
                        metadata = {
                            contact = 'unknown'
                        }
                    }
                }
            },
            status = 'available'
        },
        {
            id = 'dirty_errand',
            order = 2,
            title = 'Dirty Errand',
            description = 'Move a sealed package without attracting attention.',
            reward = '$1,200 Dirty Cash',
            rewardType = 'cash',
            rewards = {
                items = {
                    {
                        name = 'black_money',
                        amount = 1200
                    }
                }
            },
            status = 'locked'
        }
    }
}
