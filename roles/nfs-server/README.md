nfs-server
==================

This ansible role installs the NFS server and utilities for Ubuntu 22.04 LTS (Jammy Jellyfish).


Role Variables
--------------

| Variable          | Description        |
|-------------------|--------------------|
| exports_share     | A list of exports which will be placed in the `/etc/exports` file. Check Ubuntu's simple [Network File System (NFS)](https://ubuntu.com/server/docs/service-nfs) guide for more info, for example: `exports_share: [ "/mnt/public *(rw,sync,no_root_squash)" ]` |
| owner             | Configure a custom user for NFS shares, default: `www-data`|
| group             | Configure a custom group for NFS shares, default: `www-data`|
| mode              | Configure a custom permission for NFS shares, default: `0755`|
| nfs_server_daemon | NFS daemon name in systemd, default: `nfs-kernel-server`|


Example Playbook
----------------

    - hosts: localhost
      become: true
      gather_facts: yes

      vars:
        exports_share: [ "/mnt/public 10.1.1.0/255.255.255.0(rw,insecure,nohide,all_squash,anonuid=33,no_subtree_check)" ]
      roles:
      - role: nfs-server
