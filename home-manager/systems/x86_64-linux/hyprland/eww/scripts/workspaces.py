#!/usr/bin/python

import subprocess
import os
import socket
import sys

active_icon = ""
inactive_icon = ""

monitor = int(sys.argv[2])
direction = sys.argv[3]
number_workspaces = int(sys.argv[4])

def update_workspace(direction):
    cmd = f"hyprctl monitors -j | jq '.[{monitor}].activeWorkspace.id'"
    active_workspace = int(subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()[0]) - 1
    joiner = '  ' if direction == 'h' else '\r'

    row = int(active_workspace / number_workspaces) + 1
    icons = joiner.join([f"{row}"] + [active_icon if workspace == active_workspace%number_workspaces else inactive_icon for workspace in range(number_workspaces)])
    prompt = f"(box (label :text \"{icons}\" ))"

    subprocess.run(f"echo '{prompt}'", shell=True)
if sys.argv[1] == "print":
    update_workspace(direction)
if sys.argv[1] == "listen":
    update_workspace(direction)
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    server_address = f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'
    sock.connect(server_address)

    last_item = ""
    while True:
        new_event = last_item + sock.recv(4096).decode("utf-8")

        items = new_event.split("\n")
        last_item = items[-1]
        for item in items:
            if "workspace>>" == item[0:11]:
                update_workspace(direction)
