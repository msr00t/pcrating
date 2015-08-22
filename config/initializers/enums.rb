STATS = {
  fps: {
    display_name: :FPS,
    section: :Technical,
    type: :radio,
    ranks: {
      :"30 FPS Max" => -7,
      :"60 FPS Max" => 0,
      Limitless: 5
    }
  },
  resolution: {
    display_name: :Resolution,
    section: :Technical,
    type: :radio,
    ranks: {
      :"Does not support 1080p" => -7,
      :"Supports up to 1080p" => 0,
      :"4k support" => 5
    }
  },
  multi_monitor: {
    display_name: :"Multi Monitor Support",
    section: :Technical,
    type: :radio,
    ranks: {
      :"Multi-monitor support" => 2,
      :"No Multi-monitor support" => 0
    }
  },
  optimization: {
    display_name: :Optimization,
    section: :Technical,
    type: :select,
    ranks: {
      :"Poor Optimization" => -6,
      :"Passable Optimization" => -4,
      :"Good Optimization" => 0,
      :"Great Optimization" => 2,
      :"Glorious Optimization" => 4
    }
  },
  bugs: {
    display_name: :Bugs,
    section: :Technical,
    type: :select,
    ranks: {
      :"Constant game breaking bugs" => -10,
      :"Excessively buggy, mostly playable" => -6,
      :"Playable but often encounter bugs" => -4,
      :"A few bugs here and there, but rarely do they affect enjoyment" => 0,
      :"Rare bugs. Possible to go entire game without encountering" => 2
    }
  },
  vr_support: {
    display_name: :"VR support",
    section: :Technical,
    type: :radio,
    ranks: {
      :"Official VR support" => 4,
      :"VR supported with mods" => 2,
      :"No VR support" => 0
    }
  },

  cosmetic_modding: {
    display_name: :"Cosmetic Modding",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Cosmetic mods supported" => 2,
      :"Cosmetic mods not supported" => -2
    }
  },
  functionality_modding: {
    display_name: :"Gameplay Mods",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Gameplay mods supported" => 2,
      :"Gameplay mods not supported" => -2
    }
  },
  modding_tools: {
    display_name: :"Modding Tools",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Modding tools available" => 1,
      :"No modding tools provided" => -1
    }
  },
  level_editors: {
    display_name: :"Level editor",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Level editor available" => 1,
      :"No level editor" => -1
    }
  },

  launcher_drm: {
    display_name: :"Launcher DRM",
    section: :"DRM",
    type: :select,
    ranks: {
      :"Multiple mandatory launchers" => -6,
      :"Requires Steam" => -4,
      :"No launchers required" => 0,
      :"Optional launchers for updating and downloads" => 2
    }
  },
  limited_activations: {
    display_name: :"Limited Activation",
    section: :"DRM",
    type: :radio,
    ranks: {
      :"Limited activations allowed" => -3,
      :"Unlimited installs" => 0
    }
  },
  drm_free: {
    display_name: :"DRM",
    section: :"DRM",
    type: :radio,
    ranks: {
      :"Game available DRM free" => 0,
      :"Game only available with DRM" => -2
    }
  },
  disc_check: {
    display_name: :"Disc Check DRM",
    section: :"DRM",
    type: :radio,
    ranks: {
      :"Disc required in drive" => -2,
      :"Do not require disc in drive" => 0
    }
  },
  always_on_drm: {
    display_name: :"Always on DRM",
    section: :"DRM",
    type: :radio,
    ranks: {
      :"Internet connection required at all times" => -10,
      :"Internet connection required on startup" => -9,
      :"Can play offline" => 0
    }
  },
  drm_servers_off: {
    display_name: :"DRM Servers",
    section: :"DRM",
    type: :select,
    ranks: {
      :"DRM servers are off, must crack to play" => -50,
      :"DRM servers still up" => -2,
      :"No DRM servers required" => 0
    }
  },

  server_stability: {
    display_name: :"Servers",
    section: :Multiplayer,
    type: :select,
    ranks: {
      :"Servers have been turned off" => -25,
      :"Servers down most of the time" => -6,
      :"Servers unreliable" => -4,
      :"Servers unstable at high volume" => -2,
      :"Servers occasionally down" => 0,
      :"Servers never down" => 2,
    }
  },
  dedicated_servers: {
    display_name: :"Dedicated Servers",
    section: :Multiplayer,
    type: :radio,
    ranks: {
      :"No server software available" => -2,
      :"Server software available" => 0
    }
  },
  lan_support: {
    display_name: :"LAN support",
    section: :Multiplayer,
    type: :radio,
    ranks: {
      :"No lan support" => 0,
      :"Lan support" => 2
    }
  },

  day_1_dlc: {
    display_name: :"Day 1 DLC",
    section: :"DLC",
    type: :radio,
    ranks: {
      :"Day one DLC" => -4,
      :"No Day one DLC" => 0,
      :"Day one DLC is free" => 4
    }
  },
  dlc_quality: {
    display_name: :"DLC Quality",
    section: :"DLC",
    type: :select,
    ranks: {
      :"Preorder exclusives" => -5,
      :"Affects game balance" => -5,
      :"Cosmetic only" => -3,
      :"Small content packs" => -2,
      :"Old style expansions" => 0
    }
  },

  video_options: {
    display_name: :"Video Options",
    section: :"Settings",
    type: :select,
    ranks: {
      :"Cannot change video settings" => -6,
      :"Preset video settings only" => -4,
      :"Can change most video settings" => 0,
      :"Can change all video settings" => 2
    }
  },
  key_remapping: {
    display_name: :"Control Remapping",
    section: :"Settings",
    type: :radio,
    ranks: {
      :"Cannot remap keys" => -2,
      :"Can remap keys" => 0
    }
  },
  mouse_sensitivity_adjustment: {
    display_name: :"Mouse Sensitivity",
    section: :"Settings",
    type: :radio,
    ranks: {
      :"Can adjust mouse sensitivity" => 2,
      :"Cannot adjust mouse sensitivity" => 0
    }
  },
  subtitle_support: {
    display_name: :"Subtitles",
    section: :"Settings",
    type: :radio,
    ranks: {
      :"Subtitles unavailable" => -2,
      :"Subtitles available" => 0
    }
  },

  opinion: {
    display_name: :"Would you recommend this?",
    section: :Opinion,
    type: :radio,
    ranks: {
      :"Would not recommend to anyone" => -3,
      :"Would recommend to fans of the genre" => 0,
      :"Would recommend to everyone" => 3
    }
  }
}