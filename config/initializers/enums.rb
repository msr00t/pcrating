RANKS = {
  fps: {
    '30 Max': 0,
    '60 Max': 1,
    'Limitless': 2
  },
  resolution: {
    'Does not support 1080p': 0,
    'Up to 1080p': 1,
    '4k support': 2
  },
  multi_monitor: {
    'Multi-monitor support': 0,
    'No Multi-monitor support': 1
  },
  optimization: {
    'Poor': 0,
    'Passable': 1,
    'Good': 2,
    'Great': 3,
    'Glorious': 4
  },
  bugs: {
    "Constant game breaking bugs": 0,
    "Excessively buggy, mostly playable": 1,
    "Playable but often encounter bugs": 2,
    "A few bugs here and there, but rarely do they affect enjoyment": 3,
    "Rare bugs. Possible to go entire game without encountering": 4
  },
  cosmetic_modding: {
    'Cosmetic mods supported': 0,
    'Cosmetic mods not supported': 1
  },
  functionality_modding: {
    'Functionality mods supported': 0,
    'Functionality mods not supported': 1
  },
  modding_tools: {
    'Modding tools available': 0,
    'No modding tools provided': 1
  },
  level_editors: {
    'Level editor available': 0,
    'No level editor': 1
  },
  server_stability: {
    "Down most of the time": 0,
    "Partially stable servers.": 1,
    "Servers unstable at high volume.": 2,
    "Acceptable servers": 3,
    "Reliable servers": 4
  },
  dedicated_servers: {
    'Server software available': 0,
    'No server software available': 1
  },
  multiplayer_servers_turned_off: {
    'Multiplayer servers off': 0,
    'Multiplayer servers still up': 1
  },
  lan_support: {
    'Lan support': 0,
    'No lan support': 1
  },
  day_1_dlc: {
    'Day one DLC': 0,
    'No Day one DLC': 1,
    'Free': 2
  },
  dlc_quality: {
    'Preorder exclusives': 0,
    'Game Breaking': 1,
    'Cosmetic Only': 2,
    'Small content packs': 3,
    'Old Style Expansion Style': 4
  },
  video_options: {
    'Cannot Change': 0,
    'Presets only': 1,
    'Can change most things': 2,
    'Can change all settings': 3
  },
  controller_support: {
    'Controllers support': 0,
    'No controller support': 1
  },
  key_remapping: {
    'Can remap keys': 0,
    'Cannot remap keys': 1
  },
  mouse_sensitivity_adjustment: {
    'Can adjust mouse sensitivity': 0,
    'Cannot adjust mouse sensitivity': 1
  },
  vr_support: {
    'Official': 0,
    'With Mods': 1,
    'No': 2
  },
  subtitles: {
    'Can turn on subtitles': 0,
    'No subtitles': 1
  },
  launcher_drm: {
    'Multiple required launchers': 0,
    'Requires Steam': 1,
    'No launchers': 2,
    'Optional launchers for updating and downloads': 3
  },
  limited_activations: {
    'Limited activations allowed': 0,
    'Unlmited installs': 1
  },
  drm_free: {
    'Game available DRM free': 0,
    'Game only available with DRM': 1
  },
  disc_check: {
    'Disc required in drive': 0,
    'Do not require disc in drive': 1
  },
  always_on_drm: {
    'Internet connection required at all times': 0,
    'Internet connection required on startup': 1,
    'Can play offline': 2
  },
  drm_servers_off: {
    'DRM servers are off, must crack to play': 0,
    'DRM servers still up': 1
  }
}

SCORES = {
  fps: {
    '30 Max': -10,
    '60 Max': 2,
    'Limitless': 5
  },
  resolution: {
    'Does not support 1080p': -10,
    'Up to 1080p': 2,
    '4k support': 5
  },
  multi_monitor: {
    'Multi-monitor support': 2,
    'No Multi-monitor support': 0
  },
  optimization: {
    'Poor': -4,
    'Passable': -2,
    'Good': 1,
    'Great': 3,
    'Glorious': 5
  },
  bugs: {
    "Constant game breaking bugs": 0,
    "Excessively buggy, mostly playable": 1,
    "Playable but often encounter bugs": 2,
    "A few bugs here and there, but rarely do they affect enjoyment": 3,
    "Rare bugs. Possible to go entire game without encountering": 4
  },
  cosmetic_modding: {
    'Cosmetic mods supported': 3,
    'Cosmetic mods not supported': 0
  },
  functionality_modding: {
    'Functionality mods supported': 5,
    'Functionality mods not supported': 0
  },
  modding_tools: {
    'Modding tools available': 3,
    'No modding tools provided': 0
  },
  level_editors: {
    'Level editor available': 2,
    'No level editor': 0
  },
  server_stability: {
    "Down most of the time": 0,
    "Partially stable servers.": 1,
    "Servers unstable at high volume.": 2,
    "Acceptable servers": 3,
    "Reliable servers": 4
  },
  dedicated_servers: {
    'Server software available': 2,
    'No server software available': 0
  },
  multiplayer_servers_turned_off: {
    'Multiplayer servers off': -25,
    'Multiplayer servers still up': 0
  },
  lan_support: {
    'Lan support': 3,
    'No lan support': 0
  },
  day_1_dlc: {
    'Day one DLC': -5,
    'No Day one DLC': 0,
    'Free': 1
  },
  dlc_quality: {
    'Preorder exclusives': -16,
    'Game Breaking': -15,
    'Cosmetic Only': -5,
    'Small content packs': 2,
    'Old Style Expansion Style': 5
  },
  video_options: {
    'Cannot Change': -15,
    'Presets only': -10,
    'Can change most things': 2,
    'Can change all settings': 5
  },
  controller_support: {
    'Controllers support': 2,
    'No controller support': 0
  },
  key_remapping: {
    'Can remap keys': 0,
    'Cannot remap keys': -7
  },
  mouse_sensitivity_adjustment: {
    'Can adjust mouse sensitivity': 0,
    'Cannot adjust mouse sensitivity': -3
  },
  vr_support: {
    'Official': 6,
    'With Mods': 3,
    'No': 0
  },
  subtitles: {
    'Can turn on subtitles': 2,
    'No subtitles': 0
  },
  launcher_drm: {
    'Multiple required launchers': -15,
    'Requires Steam': -5,
    'No launchers': 0,
    'Optional launchers for updating and downloads': 3
  },
  limited_activations: {
    'Limited activations allowed': 0,
    'Unlmited installs': -10
  },
  drm_free: {
    'Game available DRM free': 5,
    'Game only available with DRM': 0
  },
  disc_check: {
    'Disc required in drive': -2,
    'Do not require disc in drive': 0
  },
  always_on_drm: {
    'Internet connection required at all times': -10,
    'Internet connection required on startup': -9,
    'Can play offline': -10
  },
  drm_servers_off: {
    'DRM servers are off, must crack to play': -50,
    'DRM servers still up': 0
  }
}
