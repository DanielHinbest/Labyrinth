# Make sure the objects in the SVG file are all paths
import os
import json
import xml.etree.ElementTree as ET
import re

this_dir = os.path.abspath(__file__).rsplit('\\', 1)[0]

def get_level_metadata(level_name):
    desc = input(f"Enter a description for level '{level_name}' (leave empty if none): ")
    diff = input(f"Enter difficulty for level '{level_name}' (0 if none): ")
    try:
        diff = int(diff)
    except ValueError:
        diff = 0
    return desc, diff

def parse_svg_file(svg_path):
    """Extract all path 'd' attributes from the SVG file."""
    tree = ET.parse(svg_path)
    root = tree.getroot()
    paths = []
    for elem in root.iter('{http://www.w3.org/2000/svg}path'):
        d_attr = elem.get('d')
        if d_attr:
            paths.append(d_attr)
    return paths

def generate_level_file(level_name, author_name, desc, diff, start, goal, holes, walls):
    """Generate and save a level file as a JSON dictionary."""
    level_data = {
        "name": level_name,
        "desc": desc,
        "auth": author_name,
        "diff": diff,
        "maze": {
            "start": start,
            "goal": goal,
            "holes": holes,
            "walls": walls
        }
    }
    with open(this_dir + f"/{level_name}.level", 'w') as file:
        json.dump(level_data, file, indent=4)
    print(f"Level file '{level_name}.level' created successfully.")

def main():
    author_name = input("Please enter your author name: ")
    if not author_name:
        author_name = "Unknown"
    level_files = [f for f in os.listdir(this_dir) if f.endswith('.level')]
    svg_files = {f.replace('.svg', '') for f in os.listdir(this_dir) if f.endswith('.svg')}
    print(svg_files)

    for svg_file in svg_files:
        print(f"Processing SVG file: {svg_file}")
        level_name = svg_file.replace('.svg', '')

        if svg_file in level_files:
            print(f"Skipping '{level_name}.level' due to matching .svg file.")
            continue

        start = [0, 0]
        goal = [100, 100]
        holes = []
        level_path = f"{level_name}.level"
        walls = parse_svg_file(this_dir + f"/{level_name}.svg")
        desc, diff = get_level_metadata(level_name)

        generate_level_file(level_name, author_name, desc, diff, start, goal, holes, walls)

if __name__ == "__main__":
    main()