#!/usr/bin/python

import subprocess
import os
import socket
import sys
import json

monitor = int(sys.argv[2])

def process():
    if sys.argv[1] == "print":
        update_window()
    if sys.argv[1] == "listen":
        update_window()
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        server_address = f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'
        sock.connect(server_address)

        last_item = ""
        while True:
            new_event = last_item + sock.recv(4096).decode("utf-8")

            items = new_event.split("\n")
            last_item = items[-1]
            for item in items:
                if (
                    "activewindow>>" == item[0:14] or
                    "openwindow>>" == item[0:12] or
                    "closewindow>>" == item[0:13]
                ):
                    update_window()

def update_window():
    active_window = get_active_window()
    active_workspace = get_active_workspace()
    windows = get_windows_on_workspace(active_workspace)

    title_list = map(lambda window: create_title_display(window['class'], window['title'], window['address'] == active_window['address']), windows)
    titles = ' '.join(title_list)
    prompt = f'(box :space-evenly true :halign \"start\" {titles})'

    subprocess.run(f"echo '{prompt}'", shell=True)

def get_activity_class(active: bool) -> str:
    return 'active-window-title' if active else 'inactive-window-title'

def get_title(title: str, max_len: int) -> str:
    if len(title) > max_len:
        return title[:max_len - 3] + '...'
    return title

def create_title_display(window_class: str, title: str, active: bool) -> str:
    return f"(box :class \"window-title {get_activity_class(active)}\" (label :text \"{window_class}: {get_title(title, 30)}\" ))"

def get_active_workspace() -> int:
    cmd = f"hyprctl monitors -j | jq '.[{monitor}].activeWorkspace.id'"
    return int(subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()[0])

def get_active_window() -> dict[any, any]:
    cmd = f"hyprctl activewindow -j"
    return json.loads(subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()[0])

def get_windows_on_workspace(active_workspace: int) -> list[dict[any, any]]:
    cmd = f"hyprctl clients -j | jq '[ .[] | select(.workspace.id == {active_workspace}) ]'"
    return filter(lambda window: window['title'].strip(), json.loads(subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()[0]))

process()
