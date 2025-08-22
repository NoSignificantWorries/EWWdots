#!/usr/bin/python

import subprocess
import sys


def get_eww_windows():
    try:
        result = subprocess.run(['eww', 'active-windows'], 
                              capture_output=True, 
                              text=True, 
                              check=True)
        return result.stdout.strip().split('\n')
    except subprocess.CalledProcessError:
        return []


def close_window_by_tag(tag):
    windows = get_eww_windows()
    tag = "#" + tag
    
    for window in windows:
        window, _ = window.split(': ')
        if tag in window:
            window_name = window.strip('*').strip()
            subprocess.run(['eww', 'close', window])
            print(f"Закрыто окно: {window_name}")
            return True
    
    print(f"Окно с тегом '{tag}' не найдено")
    return False


if __name__ == "__main__":
    '''
    if len(sys.argv) != 2:
        print("Использование: ./close_eww_by_tag.py <тег>")
        sys.exit(1)
    
    tag = sys.argv[1]
    close_window_by_tag(tag)
    '''
    close_window_by_tag("esc")
