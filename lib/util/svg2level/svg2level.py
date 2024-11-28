# Make sure the objects in the SVG file are all paths
import math
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
    """Extract all path 'd' attributes and positions of elements containing 'hole' in their label."""
    tree = ET.parse(svg_path)
    root = tree.getroot()

    paths = []
    start = None
    goal = None
    holes = []

    # Helper function to extract positions from a transform attribute
    def extract_transform_position(transform):
        if transform:
            match = re.search(r'translate\(([\d\.\-]+),([\d\.\-]+)\)', transform)
            if match:
                return (float(match.group(1)), float(match.group(2)))
        return None

    # Iterate through all elements in the SVG
    for elem in root.iter():
        tag = elem.tag.split('}')[-1]
        label_attr = elem.get('{http://www.inkscape.org/namespaces/inkscape}label')

        # Handle <path> elements
        if tag == 'path':
            d_attr = elem.get('d')
            if d_attr:
                paths.append(d_attr)

        # Position extraction attempt
        position = None
        transform = elem.get('transform')
        if transform:
            position = extract_transform_position(transform)

        # If no transform attribute, attempt to extract initial position from the path data
        if not position and tag == 'path' and d_attr:
            match = re.match(r'[Mm]\s*([\d\.\-]+),([\d\.\-]+)', d_attr)
            if match:
                position = ((float(match.group(1))), float(match.group(2)))

        # If position is found, categorize based on 'label'
        if label_attr and position:
            print(f"Found '{label_attr}' at {position}")
            if 'hole' in label_attr.lower():
                holes.append(position)
            elif 'marker_goal' in label_attr.lower():
                goal = position
            elif 'marker_start' in label_attr.lower():
                start = position

    print(holes, start, goal, sep='\n')

    return paths, start, goal, holes


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
        walls, start, goal, holes = parse_svg_file(this_dir + f"/{level_name}.svg")
        desc, diff = get_level_metadata(level_name)

        generate_level_file(level_name, author_name, desc, diff, start, goal, holes, walls)

if __name__ == "__main__":
    main()