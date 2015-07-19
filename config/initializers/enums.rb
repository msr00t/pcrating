STATS = {
  fps: {
    display_name: :FPS,
    ranks: {
      :"30 Max" => -10,
      :"60 Max" => 0,
      Limitless: 5
    }
  },
  resolution: {
    display_name: :Resolution,
    ranks: {
      :"Does not support 1080p" => -10,
      :"Up to 1080p" => 0,
      :"4k support" => 5
    }
  },
  multi_monitor: {
    display_name: :"Multi Monitor Support",
    ranks: {
      :"Multi-monitor support" => 2,
      :"No Multi-monitor support" => 0
    }
  },
  optimization: {
    display_name: :Optimization,
    ranks: {
      Poor: -6,
      Passable: -3,
      Good: 0,
      Great: 2,
      Glorious: 5
    }
  },
  bugs: {
    display_name: :Bugs,
    ranks: {
      :"Constant game breaking bugs" => -15,
      :"Excessively buggy, mostly playable" => -7,
      :"Playable but often encounter bugs" => -3,
      :"A few bugs here and there, but rarely do they affect enjoyment" => 0,
      :"Rare bugs. Possible to go entire game without encountering" => 2
    }
  },
  cosmetic_modding: {
    display_name: :"Cosmetic Modding",
    ranks: {
      :"Cosmetic mods supported" => 3,
      :"Cosmetic mods not supported" => 0
    }
  },
  functionality_modding: {
    display_name: :"Gameplay Mods",
    ranks: {
      :"Gameplay mods supported" => 5,
      :"Gameplay mods not supported" => 0
    }
  },
  modding_tools: {
    display_name: :"Modding Tools",
    ranks: {
      :"Modding tools available" => 3,
      :"No modding tools provided" => 0
    }
  },
  level_editors: {
    display_name: :"Level editor",
    ranks: {
      :"Level editor available" => 2,
      :"No level editor" => 0
    }
  },
  server_stability: {
    display_name: :"Server Stability",
    ranks: {
      :"Down most of the time" => -10,
      :"Partially stable servers." => -5,
      :"Servers unstable at high volume." => -2,
      :"Acceptable servers" => 1,
      :"Reliable servers" => 5
    }
  },
  dedicated_servers: {
    display_name: :"Dedicated Servers",
    ranks: {
      :"Server software available" => 3,
      :"No server software available" => 0
    }
  },
  multiplayer_servers_turned_off: {
    display_name: :"Multiplayer Servers",
    ranks: {
      :"Multiplayer servers off" => -25,
      :"Multiplayer servers still up" => 0
    }
  },
  lan_support: {
    display_name: :"LAN support",
    ranks: {
      :"Lan support" => 3,
      :"No lan support" => 0
    }
  },
  day_1_dlc: {
    display_name: :"Day 1 DLC",
    ranks: {
      :"Day one DLC" => -5,
      :"No Day one DLC" => 0,
      Free: 1
    }
  },
  dlc_quality: {
    display_name: :"DLC Quality",
    ranks: {
      :"Preorder exclusives" => -16,
      :"Game breaking" => -15,
      :"Cosmetic only" => -5,
      :"Small content packs" => 5,
      :"Old style expansions" => 10
    }
  },
  video_options: {
    display_name: :"Video Options",
    ranks: {
      :"Cannot Change" => -15,
      :"Presets only" => -10,
      :"Can change most things" => 2,
      :"Can change all settings" => 5
    }
  },
  controller_support: {
    display_name: :"Controller Support",
    ranks: {
      :"Controllers support" => 2,
      :"No controller support" => 0
    }
  },
  key_remapping: {
    display_name: :"Control Remapping",
    ranks: {
      :"Can remap keys" => 0,
      :"Cannot remap keys" => -5
    }
  },
  mouse_sensitivity_adjustment: {
    display_name: :"Mouse Sensitivity",
    ranks: {
      :"Can adjust mouse sensitivity" => 0,
      :"Cannot adjust mouse sensitivity" => -3
    }
  },
  vr_support: {
    display_name: :"VR support",
    ranks: {
      Official: 10,
      :"With Mods" => 5,
      No: 0
    }
  },
  subtitle_support: {
    display_name: :"Subtitles",
    ranks: {
      :"Can turn on subtitles" => 2,
      :"No subtitles" => 0
    }
  },
  launcher_drm: {
    display_name: :"Launcher DRM",
    ranks: {
      :"Multiple required launchers" => -15,
      :"Requires Steam" => -5,
      :"No launchers" => 0,
      :"Optional launchers for updating and downloads" => 3
    }
  },
  limited_activations: {
    display_name: :"Limited Activation",
    ranks: {
      :"Limited activations allowed" => -10,
      :"Unlimited installs" => 0
    }
  },
  drm_free: {
    display_name: :"DRM",
    ranks: {
      :"Game available DRM free" => 0,
      :"Game only available with DRM" => -5
    }
  },
  disc_check: {
    display_name: :"Disc Check DRM",
    ranks: {
      :"Disc required in drive" => -2,
      :"Do not require disc in drive" => 0
    }
  },
  always_on_drm: {
    display_name: :"Always on DRM",
    ranks: {
      :"Internet connection required at all times" => -10,
      :"Internet connection required on startup" => -9,
      :"Can play offline" => 0
    }
  },
  drm_servers_off: {
    display_name: :"DRM Servers",
    ranks: {
      :"DRM servers are off, must crack to play" => -50,
      :"DRM servers still up" => 0,
      :"No DRM servers required" => 2
    }
  },
  opinion: {
    display_name: :"Would you recommend this?",
    ranks: {
      :"To everyone" => 2,
      :"To fans of the genre" => 0,
      :"Not to anyone" => -2
    }
  }
}