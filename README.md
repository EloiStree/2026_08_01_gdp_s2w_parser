```
git submodule add https://github.com/EloiStree/2026_08_01_gdp_s2w_parser.git addons/2026_08_01_gdp_s2w_parser
```

```
git clone https://github.com/EloiStree/2026_08_01_gdp_s2w_parser.git addons/2026_08_01_gdp_s2w_parser
```

# 2026_08_01_gdp_s2w_parser

> Parser for the Scratch 2 Warcraft format I created to simulate keyboard, mouse, and gamepad input.

The player and the user send four-byte integers in little-endian format with their index.

The code parses these integers into events and enums.

I am using the S2W format I created to simulate input in my games. The goal is to train on mini-games first, then switch to a real game and, eventually, a robot.



**Have a look at NES:** 
- https://github.com/EloiStree/2026_01_18_gdp_nes_controller_udp
- https://github.com/EloiStree/2026_01_03_gdp_input_to_primitive

- https://github.com/EloiStree/2024_04_20_upm_push_generic_iid
