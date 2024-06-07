# Links
- [Part 1. Description of how nfs works, it's configuration, mounting, automounting, etc](https://www.altlinux.org/NFS)
- [Part 2. Description of how nfs works, it's configuration, mounting, automounting, etc](https://help.ubuntu.ru/wiki/nfs)
- [GitHub example how configuration nfs, it's mounting, automounting via autofs and etc](https://github.com/prostopasta/ansible-nfs-roles?tab=readme-ov-file#ansible-роли-для-настройки-nfs-сервера-и-клиента)

# Building nfs for server/clients side throught Ansible roles

<!-- TOC -->

- [Ansible roles for configuration nfs-server/clients]()
    - [Task description]()
        - [Playbook for nfs server based on Ubuntu and MacOs]()
        - [Playbook for nfs-clients with supporting **systemd** and **automount** for Ubuntu and MacOs]()

## Task description

---
### Playbook for nfs server based on Ubuntu and MacOs

Create an Ansible role to configure the NFS server-side: the role should be able to install the necessary NFS server packages, adjust minimal configuration settings, start the nfs daemon upon initial setup, or restart it in case of any changes to the configuration of an already running NFS server.

Playbook:
```bash
$ cat playbook-nfs-server.yml
---
- hosts: localhost
  become: true
  gather_facts: yes

  vars:
    exports_share: [ "/mnt/public *(rw,insecure,nohide,all_squash,anonuid=33,no_subtree_check)" ]

  roles:
  - role: nfs-server

$ ansible-playbook playbook-nfs-server.yml
```
---

### Playbook for nfs-clients with supporting **systemd** and **automount** for Ubuntu and MacOs

Create an Ansible role to configure the NFS client-side: the role should be able to install the required packages on the client side, mount the network NFS resource using a Systemd unit, and ideally provide an automount option for the unit.

Playbook:
```bash
$ cat playbook-nfs-client.yml
---
- hosts: localhost
  become: true
  gather_facts: yes

  vars:
    mounts:
      PublicShare:
        share: <ip_server>:/mnt/public
        mount: /opt/publicshare
        type: nfs
        options: auto
        automount: true

  roles:
    - role: nfs-client

$ ansible-playbook playbook-nfs-client.yml
```
