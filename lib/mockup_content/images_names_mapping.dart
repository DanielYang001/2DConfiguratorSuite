Map imagesMapping = {
  "Platform": {
    "key": "Platform",
    "name": "Platform",
    "render_interior": 1,
    "has_a_layer": 0,
    "order": 0,
    "rendered_with": ["Environment"],
    "values": {
      "WEB": {"value": 1}
    },
  },
  "Environment": {
    "key": "Environment",
    "name": "Environment",
    "render_interior": 1,
    "order": 1,
    "rendered_with": ["Platform"],
    "values": {
      "STUDIO_EXT": {"value": 1, "image": "assets/icons/backgrounds/blue.png"},
      "VALLEY_EXT": {"value": 2, "image": "assets/icons/backgrounds/green.png"},
    },
  },
  "VersionSpecification": {
    "key": "VersionSpecification",
    "name": "Version Specification",
    "render_interior": 1,
    "has_a_layer": 0,
    "order": 2,
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "MID": {"value": 1, "cost": 2000},
      "PREM_DARK": {"value": 2, "cost": 2500},
      "PREM_LIGHT": {"value": 3, "cost": 3000}
    },
  },
  "Colour": {
    "key": "Colour",
    "name": "Colour",
    "main_menu": "Exterior",
    "menu": "CAR BODY",
    "render_interior": 1,
    "order": 3,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "FUME": {
        "value": 1,
        "cost": 23.50,
        "name": "Fume",
        "image": "assets/icons/colors/fume.png"
      },
      "GEBZE_BLACK": {
        "value": 2,
        "cost": 17.00,
        "name": "Gebze Black",
        "image": "assets/icons/colors/black.png"
      },
      "ANATOLIAN_RED": {
        "value": 3,
        "cost": 20.50,
        "name": "Anatolian Red",
        "image": "assets/icons/colors/red.png"
      },
      "PAMUKKALE_WHITE": {
        "value": 4,
        "cost": 18.0,
        "name": "Pamukkale White",
        "image": "assets/icons/colors/white.png"
      },
      "GEMLIK_BLUE": {
        "value": 5,
        "cost": 21.50,
        "name": "Gemlik Blue",
        "image": "assets/icons/colors/blue.png"
      },
      "KAPADOKYA_BEIGE": {
        "value": 6,
        "cost": 16.00,
        "name": "Kapadokya Beige",
        "image": "assets/icons/colors/beige.png"
      },
      "PRESIDENTIAL_GREEN": {
        "value": 7,
        "cost": 22.50,
        "name": "Presidential Green",
        "image": "assets/icons/colors/green.png"
      },
    },
  },
  "Frame": {
    "key": "Frame",
    "name": "Frame",
    "main_menu": "Exterior",
    "menu": "CAR BODY",
    "render_interior": 0,
    "order": 4,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "BLACK": {
        "value": 1,
        "cost": 10.50,
        "name": "Black",
        "image": "assets/icons/frames/black.png"
      },
      "GLOSS_GRAY": {
        "value": 2,
        "cost": 7.00,
        "name": "Gloss Gray",
        "image": "assets/icons/frames/gray.png"
      },
    },
  },
  "Roof": {
    "key": "Roof",
    "name": "Roof",
    "main_menu": "Exterior",
    "menu": "CAR BODY",
    "render_interior": 1,
    "order": 5,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "CLOSED_STEEL": {
        "value": 1,
        "cost": 20.00,
        "rendered_with": ["Colour"],
        "name": "Closed Steel",
        "image": "assets/icons/roof/closedsteel.png"
      },
      "FIX_PANORAMIC": {
        "value": 2,
        "cost": 30.50,
        "name": "Fix Panoramic",
        "image": "assets/icons/roof/panoramic.png"
      },
    },
  },
  "FogLight": {
    "key": "FogLight",
    "name": "Fog Light",
    "main_menu": "Exterior",
    "menu": "EXTERIOR PARTS",
    "render_interior": 0,
    "order": 7,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "LESS": {
        "value": 1,
        "cost": 10.00,
        "name": "Less",
        "image": "assets/icons/foglight/less.png"
      },
      "NORMAL": {
        "value": 2,
        "cost": 12.50,
        "name": "Normal",
        "image": "assets/icons/foglight/more.png"
      }
    },
  },
  "Mirror": {
    "key": "Mirror",
    "name": "Mirror",
    "main_menu": "Exterior",
    "menu": "EXTERIOR PARTS",
    "render_interior": 1,
    "order": 8,
    "display_as": "thumbnail_selection",
    "rendered_with": [
      "Platform",
      "Environment",
      "VersionSpecification",
      "Colour"
    ],
    "values": {
      "STANDART_MID": {
        "value": 1,
        "cost": 30.00,
        "name": "Standart Mid",
        "image": "assets/icons/mirror/standart.png"
      },

      // "STANDART_PREM": {
      //   "value": 2,
      //   "cost": 35.50,
      //   "name": "Standart Prem",
      //   "image": "assets/icons/mirror/standartprem.png"
      // },
      "CAMERA": {
        "value": 3,
        "cost": 60.00,
        "name": "Camera",
        "image": "assets/icons/mirror/camera.png"
      },
    },
  },
  "Speaker": {
    "key": "Speaker",
    "name": "Speaker",
    "main_menu": "INTERIOR",
    "menu": "INTERIOR",
    "render_interior": 1,
    "has_a_layer": 0,
    "order": 9,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "BASE": {
        "value": 1,
        "cost": 55.50,
        "name": "Base",
        "image": "assets/icons/speaker/base.png"
      },
      // "PREM": {
      //   "value": 2,
      //   "cost": 60.00,
      //   "name": "Prem",
      //   "image": "assets/icons/speaker/prem.png"
      // },
    },
  },
  "Wheel": {
    "key": "Wheel",
    "name": "Wheels",
    "main_menu": "Exterior",
    "menu": "EXTERIOR PARTS",
    "render_interior": 0,
    "order": 6,
    "display_as": "thumbnail_selection",
    "rendered_with": ["Platform", "Environment"],
    "values": {
      "ALLOY17": {
        "value": 1,
        "cost": 80.00,
        "name": "Alloy 17",
        "image": "assets/icons/wheel/alloy17.png"
      },
      "ALLOY18": {
        "value": 2,
        "cost": 90.50,
        "name": "Alloy 18",
        "image": "assets/icons/wheel/alloy18.png"
      },
      "ALLOY19": {
        "value": 3,
        "cost": 99.99,
        "name": "Alloy 19",
        "image": "assets/icons/wheel/alloy19.png"
      },
    },
  },
};
