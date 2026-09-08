Config = {}

Config.DebugCommand = true
Config.OpenKey = 'F7'
Config.AutoOpenOnPlayerLoaded = true
Config.OnboardingMetadataKey = 'faux_onboarding_complete'

Config.Brand = {
    logoText = 'F',
    logoImage = 'img/logo.png',
    product = 'RADIANTCOAST',
    version = 'City Guide'
}

Config.CompleteEvent = nil

Config.Pages = {
   {
    id = 'arrival',
    eyebrow = 'First Steps',
    title = 'Welcome to the City',
    subtitle = 'Start here after creating your character.',
    body = 'This guide gives you the essentials before you step out and begin your story. At any point of time, if you wish to return to this guide, you can do so by typing /guide in chat.',
    locationLabel = '',
    mapLabel = '',
    locationImage = 'img/main_ch.png',
    mapImage = 'img/skyl_day.png',
    waypoint = vector2(-1037.64, -2737.74)
    },
    {
    id = 'cityhall',
      eyebrow = 'Identity',
      title = 'Visit City Hall',
      subtitle = 'Collect documents, licenses, and browse Jobs.',
      body = 'City Hall is where new residents handle official paperwork. Use it to understand identification, licensing, information on jobs and current affairs of the city.',
      locationLabel = 'City Hall',
      mapLabel = 'Hawick Ave',
      locationImage = 'img/city_peds.png',
      mapImage = 'img/city_loc.png',
        waypoint = vector2(-544.82, -204.36)
    },
    {
    id = 'vehicle',
      eyebrow = 'First Ride',
      title = 'Get a Vehicle',
      subtitle = 'Vehicles are essential for transportation and roleplay.',
      body = 'Getting Started with a vehicle is important for exploring the city and engaging in roleplay. You can find vehicles at dealerships or at sale-lots where other players may be selling their vehicles. Make sure to check the vehicle\'s condition and legality before purchasing.',
      locationLabel = 'Premium Deluxe Motorsport',
      mapLabel = 'Adams Apple Blvd',
      locationImage = 'img/dealer_ext.png',
      mapImage = 'img/dealer_loc.png',
        waypoint = vector2(-269.81, -957.45)
    },
    {
    id = 'fuel',
      eyebrow = 'Gas Up',
      title = 'Refuel Your Vehicle',
      subtitle = 'Keep your vehicle running with regular fueling.',
      body = 'Find the nearest fuel station to keep your vehicle powered up for your adventures.',
      locationLabel = 'Fuel Station',
      mapLabel = 'Refueling Point',
      locationImage = 'img/gas_pic.png',
      mapImage = 'img/gas_loc.png',
        waypoint = vector2(-265.16, -963.62)
    },
    {
    id = 'services',
      eyebrow = 'Gears n Screws',
      title = 'Mechanic Shops',
      subtitle = 'Repair and customize your vehicles at local mechanic shops.',
      body = 'Mechanic shops are available throughout the city to provide repair and customization services for your vehicles. Whether you need a quick fix or want to upgrade your ride, visit a mechanic shop for professional assistance.',
      locationLabel = 'Benny\'s Original Motor Works',
      mapLabel = 'Innocence Blvd',
      locationImage = 'img/benny_pic.png',
      mapImage = 'img/benny_loc.png',
        waypoint = vector2(148.52, -1040.48)
    },
    {
    id = 'housing',
      eyebrow = 'Home Sweet Home',
      title = 'Find Your Home',
      subtitle = 'Secure a place to live and call your own.',
      body = 'Find a home at Dynasty8 to store your belongings, vehicles, and have a place to relax. Housing is available for purchase or rent in various districts of the city. Furnitures for your house can be purchased from KRAPEA at Davis.',
      locationLabel = 'Dynasty8 Real Estate',
      mapLabel = 'Hawick Ave',
      locationImage = 'img/d8_int.png',
      mapImage = 'img/d8_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
    id = 'ems',
      eyebrow = 'Call a Medic!',
      title = 'LS Medical Center',
      subtitle = 'Hurt yourself? Feel sick? We got you covered!',
      body = 'The Los Santos Medical Center is the primary healthcare facility in the city. It provides emergency medical services, routine check-ups, and specialized care. In case of injury or illness, visit the medical center for treatment and support.',
      locationLabel = 'Medical Center',
      mapLabel = 'Little Seoul',
      locationImage = 'img/lsmc_pic.png',
      mapImage = 'img/lsmc_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
        id = 'garages',
      eyebrow = 'Keep-em Safe',
      title = 'Public Garages',
      subtitle = 'Store your vehicles securely in public garages.',
      body = 'Public garages are available throughout the city for vehicle storage. They provide a safe place to park your vehicles when not in use, preventing theft and damage. Make sure to check the garage locations before using them.',
      locationLabel = 'Legion Square Garage',
      mapLabel = 'Legion Square',
      locationImage = 'img/legn_pic.png',
      mapImage = 'img/legn_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
        id = 'clothing',
      eyebrow = 'Drip-feed',
      title = 'Clothing Stores',
      subtitle = 'Find the perfect outfit for any occasion.',
      body = 'Explore the various clothing stores throughout the city to find the latest trends and styles. From casual wear to formal attire, you\'ll find everything you need to express your personal style.',
      locationLabel = 'Ponsonbys',
      mapLabel = 'Legion Square',
      locationImage = 'img/pons_pic.png',
      mapImage = 'img/pons_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
        id = 'police',
      eyebrow = 'Protect & Serve',
      title = 'LS Police Department',
      subtitle = 'Get help from the local police.',
      body = 'The LSPD is here to serve and protect the community. If you need assistance or have any concerns, don\'t hesitate to reach out.',
      locationLabel = 'Vinewood PD',
      mapLabel = 'Legion Square',
      locationImage = 'img/pd_pic.png',
      mapImage = 'img/pd_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
        id = 'bank',
      eyebrow = 'Financial Services',
      title = 'Fleeca Bank',
      subtitle = 'Manage your finances with confidence.',
      body = 'The Fleeca Bank offers a wide range of financial services to meet your needs. Whether you want to open an account, apply for a loan, or manage your investments, our team is here to help.',
      locationLabel = 'Bank Branch',
      mapLabel = 'Legion Square',
      locationImage = 'img/flc_pic.png',
      mapImage = 'img/flc_loc.png',
        waypoint = vector2(215.76, -810.12),
        final = false
    },
    {
        id = 'journey',
      eyebrow = 'Begin',
      title = 'Start Your Journey',
      subtitle = 'You now have the foundation.',
      body = 'Explore at your own pace, ask questions in character, and let your story build naturally.',
      locationLabel = 'Open City',
      mapLabel = 'Your Next Destination',
      locationImage = 'img/contract-bg.avif',
      mapImage = 'img/map-placeholder.svg',
        waypoint = vector2(215.76, -810.12),
        final = true
    }
}

Config.KeybindPages = {
    {
        title = 'Vehicle',
        items = {
            {
                keys = { 'F6' },
                title = 'Toggle Vehicle Control Menu',
                description = 'Open the vehicle control menu to manage your vehicle\'s settings and features.'
            },
            {
                keys = { 'J' },
                title = 'Toggle Boat Anchor',
                description = 'Toggle the anchor on your boat to keep it in place or allow it to drift.'
            },
            {
                keys = { 'J' },
                title = 'Toggle Cruise Control',
                description = 'Toggle cruise control for your vehicle.'
            },
            {
                keys = { 'G' },
                title = 'Toggle Vehicle Engine',
                description = 'Start or stop your vehicle\'s engine.'
            },
            {
                keys = { 'L' },
                title = 'Lock Vehicle',
                description = 'Lock or unlock your vehicle from inside or outside.'
            },
            {
                keys = { 'U' },
                title = 'Toggle Carplay',
                description = 'Open or close the carplay interface. If not installed, access will remain restricted.'
            },
            {
                keys = { 'H' },
                title = 'Toggle Headlights',
                description = 'Turn your vehicle\'s headlights on or off.'
            },
            {
                keys = { 'P' },
                title = 'Pause Menu',
                description = 'Open your Server Pause Menu.'
            },
        }
    },
    {
        title = 'Interaction',
        items = {
            {
                keys = { 'Alt' },
                title = 'Target Eye',
                description = 'Look at nearby objects, people, and doors for interactions.'
            },
            {
                keys = { 'E' },
                title = 'Interact',
                description = 'Use prompts, doors, pickups, and service points.'
            },
            {
                keys = { 'I' },
                title = 'Inventory',
                description = 'Open your carried items.'
            },
            {
                keys = { 'M' },
                title = 'Phone',
                description = 'Open phone apps and contacts.'
            },
            {
                keys = { 'F1' },
                title = 'Menu',
                description = 'Open the personal action(radial) menu.'
            },
            {
                keys = { 'T' },
                title = 'Chat',
                description = 'Focus the chat input.'
            },
            {
                keys = { 'O' },
                title = 'Pets',
                description = 'Toggle the pet menu.'
            }
        }
    }
}

Config.CommandPages = {
    {
        title = 'Quick Commands',
        items = {
            {
                command = '/report',
                description = 'Open the reports dialogue to contact staff',
                requiresParameters = false
            },
            {
                command = '/togglehud',
                description = 'Toggle the HUD.',
                requiresParameters = false
            },
            {
                command = '/id',
                description = 'Show your server ID.',
                requiresParameters = false
            },
            {
                command = '/me',
                description = 'Describe an in-character action. Requires text.',
                requiresParameters = true
            },
            {
                command = '/do',
                description = 'Describe scene details. Requires text.',
                requiresParameters = true
            },
            {
                command = '/photomode',
                description = 'Toggle Photo Mode',
                requiresParameters = true
            }
        }
    },
    {
        title = 'Roleplay Basics',
        items = {
            {
                command = '/ooc',
                description = 'Send an out-of-character message. Requires text.',
                requiresParameters = true
            },
            {
                command = '/emotes',
                description = 'Open the emote menu.',
                requiresParameters = false
            },
            {
                command = '/e',
                description = 'Play an emote. Requires an emote name.',
                requiresParameters = true
            },
            {
                command = '/clear',
                description = 'Clear your chat window.',
                requiresParameters = false
            }
        }
    }
}

Config.FAQs = {
    {
        question = 'Where should I go first?',
        answer = 'Start with City Hall, then learn your phone, inventory, banking, and garage options before chasing bigger goals.'
    },
    {
        question = 'How do I get help from staff?',
        answer = 'Use the configured report command with a clear message, or follow your community Discord support flow.'
    },
    {
        question = 'What should I do if a command needs parameters?',
        answer = 'Open chat, type the command, add the needed text or value, then submit it manually.'
    },
    {
        question = 'Why are some commands clickable and others not?',
        answer = 'Only commands that can safely run without extra text are clickable from this guide.'
    },
    {
        question = 'Can server owners edit this content?',
        answer = 'Yes. The tabs are fed from config, so keybinds, commands, and FAQs can be adjusted for your city.'
    }
}

-- Chapters are shown first to characters who have completed the onboarding guide.
-- Add each major RadiantCoast update here. Images are relative to the html folder.
Config.Chapters = {
    {
        id = 'chapter-0',
        label = 'RadiantCoast Chapter 0',
        phase = 'Beta Phase',
        title = 'The Beta Begins',
        description = 'The first chapter of RadiantCoast is where the city opens its doors, its stories begin, and the community helps shape what comes next.',
        coverImage = 'img/rdc_beta_ch0.png',
        additions = {
            'RadiantCoast Beta is now live.',
            'Core city systems and starter experiences are available to explore.',
            'The City Guide is available for new residents.'
        },
        changes = {
            'This chapter establishes the foundation for future city updates.'
        },
        fixes = {
            'Beta fixes and balance improvements will be documented here as they ship.'
        }
    }
}
