# Read every filename in the current directory ending with .level and place it into a json file as array of strings
# The json file will be used to generate levels in the game
# Format for string should be "assets/levels/level_name.level"

import os
import json
from natsort import natsorted

def gen_levels():
  levels = []
  # Look for level files in the current directory
  for file in os.listdir("."):
    if file.endswith(".level"):
      levels.append(f"assets/levels/{file}")
  
  levels = natsorted(levels)

  with open("levels.json", "w") as f:
    json.dump(levels, f, indent=2)

  print(f"levels.json generated successfully with {len(levels)} levels.")

if __name__ == "__main__":
  gen_levels()

    