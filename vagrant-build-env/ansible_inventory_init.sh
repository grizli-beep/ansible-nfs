#!/usr/bin/env bash

# CREATE THE INVENTORY FILE

GITHUB_REPO="https://github.com/grizli-beep/ansible-nfs.git"
PROJECT_DIRECTORY="/home/vagrant/ansible-nfs"

git clone $GITHUB_REPO
cd $PROJECT_DIRECTORY || false

# Creating the inventory file for all 3 nodes to run some adhoc command.

echo -e "controller\n\n[servers]\nhost01\n\n[clients]\nhost02" > inventory
echo -e "[defaults]\ninventory = inventory\nhost_key_checking = False" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"
echo

# running adhoc command to see if everything is fine

ansible all -i inventory -m "shell" -a "uptime"
echo