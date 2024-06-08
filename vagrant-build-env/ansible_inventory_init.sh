#!/usr/bin/env bash

# SKIPPING ASKING PERMISSION
for val in controller host01 host02; do
      ssh -o StrictHostKeyChecking=no -l vagrant@$val
done

# CREATE THE INVENTORY FILE

GITHUB_REPO="https://github.com/grizli-beep/ansible-nfs.git"
PROJECT_DIRECTORY="/home/vagrant/nfs-roles"

git clone $GITHUB_REPO
cd $PROJECT_DIRECTORY || false

# Creating the inventory file for all 3 nodes to run some adhoc command.

echo -e "controller\n\n[servers]\nhost01\n\n[clients]\nhost02" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"
echo

# running adhoc command to see if everything is fine

ansible all -i inventory -m "shell" -a "uptime"
echo