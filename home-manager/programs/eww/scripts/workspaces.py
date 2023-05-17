#!/usr/bin/python

import subprocess
import os
import socket

number_workspaces = 5
active_icon = ""
inactive_icon = ""

def update_workspace(active_workspace):
    icons = [active_icon if workspace == active_workspace else inactive_icon in range(number_workspaces)]
    prompt = f"(box (label :text \"{icons}\" ))"

    subprocess.run(f"echo '{prompt}'",
                   shell=True)

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

server_address = f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'

sock.connect(server_address)

while True:
    new_event = sock.recv(4096).decode("utf-8")

    for item in new_event.split("\n"):

        if "workspace>>" == item[0:11]:
            workspaces_num = item[-1]

            update_workspace(int(workspaces_num))
