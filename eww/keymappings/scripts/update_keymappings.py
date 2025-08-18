#!/usr/bin/python

import re
import json
import subprocess


def get_hyprland_binds() -> dict | None:
    try:
        result = subprocess.run(
            ["hyprctl", "binds", "-j"],
            capture_output=True,
            text=True,
            check=True
        )
        
        binds = json.loads(result.stdout)
        return binds
    
    except subprocess.CalledProcessError as e:
        print(f"Error while running the command: {e}")
        return None
    except json.JSONDecodeError as e:
        print(f"Error while JSON parsing: {e}")
        return None


def parse_modmask(modmask: int) -> list[str]:
    modifiers = []
    if modmask & 64:
        modifiers.append("SUPER")
    if modmask & 4:
        modifiers.append("CTRL")
    if modmask & 1:
        modifiers.append("SHIFT")
    if modmask & 8:
        modifiers.append("ALT")
    if modmask & 2:
        modifiers.append("LOCK")
    if modmask & 16:
        modifiers.append("MOD2")
    if modmask & 32:
        modifiers.append("MOD3")
    if modmask & 128:
        modifiers.append("MOD5")
    
    return modifiers


def parse_title(desc: str) -> dict | None:
    pattern = r'\s*\[\s*(.+?)(?:\s+\|\s+(.+?))?\s*\]\s+(.+)\s*'
    
    match = re.search(pattern, desc)
    
    if match:
        title, subtitle, description = match.groups()
        return {
            "title": title,
            "subtitle": subtitle,
            "desc": description
        }
    else:
        return None


def parse_key(key: str) -> str:
    match key:
        case "mouse:272":
            return "left"
        case "mouse:273":
            return "right"
        case "mouse:274":
            return "middle"
        case "mouse:w_u":
            return "wheel up"
        case "mouse:w_d":
            return "wheel down"
        case "mouse:275":
            return "backward"
        case "mouse:276":
            return "forward"
        case "Return":
            return "return"
        case "Tab":
            return "tab"
        case "Space":
            return "space"
        case "Print":
            return "print"
    return key


def main() -> None:
    bindings = get_hyprland_binds()

    if bindings is None or len(bindings) < 1:
        raise(RuntimeError("Failed to retrieve hyprland binds"))
    
    for bind in bindings:
        if not bind["has_description"]:
            continue

        prepared_bind = {
            "desc": parse_title(bind["description"]),
            "mods": parse_modmask(bind["modmask"]),
            "key": parse_key(bind["key"])
        }

        print(prepared_bind)


if __name__ == "__main__":
    main()
    print("\u27F5")
