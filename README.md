# Links
- [Description of how NFS works, it's configuration, mounting, automounting, etc](https://www.altlinux.org/NFS)
- [Vagrant docs](https://developer.hashicorp.com/vagrant/docs)
- [Vagrant tutorial](https://devopscube.com/vagrant-tutorial-beginners/)
# Building nfs for server/clients side throught Ansible roles

<!-- TOC -->

- Ansible roles for configuration nfs-server/clients
    - Task description
        - Playbook for nfs server based on Ubuntu and MacOs
        - Playbook for nfs-clients with supporting **systemd** and **automount** for Ubuntu and MacOs
    - Build test environment (optional)

## Task description

---
### Playbook for nfs server based on Ubuntu

Create an Ansible role to configure the NFS server-side: the role should be able to install the necessary NFS server packages, adjust minimal configuration settings, start the nfs daemon upon initial setup, or restart it in case of any changes to the configuration of an already running NFS server.

Playbook:
```bash
$ cat playbook-nfs-server.yml
---
- hosts: all
  become: true
  gather_facts: no

  vars:
    exports_share: [ "/mnt/public *(rw,insecure,nohide,all_squash,anonuid=33,no_subtree_check)" ]

  roles:
  - role: nfs-server

$ ansible-playbook playbook-nfs-server.yml
```
---

### Playbook for nfs-clients with supporting **systemd** and **automount** for Ubuntu

Create an Ansible role to configure the NFS client-side: the role should be able to install the required packages on the client side, mount the network NFS resource using a Systemd unit, and ideally provide an automount option for the unit.

Playbook:
```bash
$ cat playbook-nfs-client.yml
---
- hosts: all
  become: true
  gather_facts: no

  vars:
    mounts:
      PublicShare:
        # Added ip server, which create throught vagrant
        share: 192.168.56.251:/mnt/public
        mount: /opt/publicshare
        type: nfs
        options: auto
        automount: true

  roles:
    - role: nfs-client

$ ansible-playbook playbook-nfs-client.yml
```
## Build test environment (optional)
### Test environment based on Virtualbox + Vagrant
For the purpose of creating a demo stand, it is possible to use a combination of **Vagrant** and **VirtualBox**.


The stand contains for 3 VMs:
- Virtual machine for Ansible controller
- `controller.ansible.local (controller)`
- 2 virtual machines for server and client:
- `host01.ansible.local (host01)`
- `host02. ansible.local (host02)`

**Important Note** - you can see the ssh keys in the vagrant-build-env directory. I created them (id_rsa, id_rsa.pub) to put on the nodes via the vagrantfile. You can create your own or use mine
```bash
$ cd vagrant-build-env\
$ vagrant up
$ vagrant ssh controller

$ bash ~/ansible_inventory_init.sh
$ cd ~/ansible-nfs
$ ansible-playbook -l servers playbook-nfs-server.yml
$ ansible-playbook -l clients playbook-nfs-client.yml
```