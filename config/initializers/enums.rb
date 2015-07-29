STATS = {
  fps: {
    display_name: :FPS,
    section: :Technical,
    type: :radio,
    ranks: {
      :"30 FPS Max" => -7,
      :"60 FPS Max" => -2,
      Limitless: 0
    }
  },
  resolution: {
    display_name: :Resolution,
    section: :Technical,
    type: :radio,
    ranks: {
      :"Does not support 1080p" => -7,
      :"Supports up to 1080p" => -2,
      :"4k support" => 0
    }
  },
  multi_monitor: {
    display_name: :"Multi Monitor Support",
    section: :Technical,
    type: :radio,
    ranks: {
      :"Multi-monitor support" => 0,
      :"No Multi-monitor support" => -1
    }
  },
  optimization: {
    display_name: :Optimization,
    section: :Technical,
    type: :select,
    ranks: {
      :"Poor Optimization" => -4,
      :"Passable Optimization" => -3,
      :"Good Optimization" => -2,
      :"Great Optimization" => -1,
      :"Glorious Optimization" => 0
    }
  },
  bugs: {
    display_name: :Bugs,
    section: :Technical,
    type: :select,
    ranks: {
      :"Constant game breaking bugs" => -10,
      :"Excessively buggy, mostly playable" => -4,
      :"Playable but often encounter bugs" => -3,
      :"A few bugs here and there, but rarely do they affect enjoyment" => -2,
      :"Rare bugs. Possible to go entire game without encountering" => 0
    }
  },
  vr_support: {
    display_name: :"VR support",
    section: :Technical,
    type: :radio,
    ranks: {
      :"Official VR support" => 0,
      :"VR supported with mods" => -1,
      :"No VR support" => -2
    }
  },

  cosmetic_modding: {
    display_name: :"Cosmetic Modding",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Cosmetic mods supported" => 0,
      :"Cosmetic mods not supported" => -2
    }
  },
  functionality_modding: {
    display_name: :"Gameplay Mods",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Gameplay mods supported" => 0,
      :"Gameplay mods not supported" => -5
    }
  },
  modding_tools: {
    display_name: :"Modding Tools",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Modding tools available" => 0,
      :"No modding tools provided" => -2
    }
  },
  level_editors: {
    display_name: :"Level editor",
    section: :Mods,
    type: :radio,
    ranks: {
      :"Level editor available" => 0,
      :"No level editor" => -2
    }
  },

  launcher_drm: {
    display_name: :"Launcher DRM",
    section: :"DRM",
    type: :select,
    ranks: {
      :"Multiple mandatory launchers" => -5,
      :"Requires Steam" => -2,
      :"No launchers required" => -1,
      :"Optional launchers for updating and downloads" => 0
    }
  },
  limited_activations: {
    display_name: :"Limited Activation",
    section: :"DRM",
    type: :radio,
    ranks: {
      :"Limited activations allowed" => -7,
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
      :"Servers down most of the time" => -7,
      :"Servers unreliable" => -4,
      :"Servers unstable at high volume" => -2,
      :"Servers occasionally down" => -1,
      :"Servers never down" => 0,
    }
  },
  dedicated_servers: {
    display_name: :"Dedicated Servers",
    section: :Multiplayer,
    type: :radio,
    ranks: {
      :"No server software available" => -3,
      :"Server software available" => 0
    }
  },
  lan_support: {
    display_name: :"LAN support",
    section: :Multiplayer,
    type: :radio,
    ranks: {
      :"No lan support" => -2,
      :"Lan support" => 0
    }
  },

  day_1_dlc: {
    display_name: :"Day 1 DLC",
    section: :"DLC",
    type: :radio,
    ranks: {
      :"Day one DLC" => -3,
      :"No Day one DLC" => -1,
      :"Day one DLC is free" => 0
    }
  },
  dlc_quality: {
    display_name: :"DLC Quality",
    section: :"DLC",
    type: :select,
    ranks: {
      :"Preorder exclusives" => -5,
      :"Effects game balance" => -5,
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
      :"Cannot change video settings" => -7,
      :"Preset video settings only" => -4,
      :"Can change most video settings" => -2,
      :"Can change all video settings" => 0
    }
  },
  key_remapping: {
    display_name: :"Control Remapping",
    section: :"Settings",
    type: :radio,
    ranks: {
      :"Cannot remap keys" => -3,
      :"Can remap keys" => 0
    }
  },
  mouse_sensitivity_adjustment: {
    display_name: :"Mouse Sensitivity",
    section: :"Settings",
    type: :radio,
    ranks: {
      :"Can adjust mouse sensitivity" => 0,
      :"Cannot adjust mouse sensitivity" => -2
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
      :"Would not recommend to anyone" => -5,
      :"Would recommend to fans of the genre" => -3,
      :"Would recommend to everyone" => 0
    }
  }
}