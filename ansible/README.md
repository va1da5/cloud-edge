# Playbooks for Provisioning Workloads


## Vagrant

```bash
# start local vagrant VMs
vagrant up

# SSH into a specific VM
vagrant ssh centos8

ansible all -i inventory/vagrant -m ping

ansible all -i inventory/vagrant -m setup| grep distribution

ansible-playbook -i inventory/vagrant playbooks/docker.yml

# destroy VMs
vagrant destroy -f
```

## AWS

```bash
# check if connection is working
ansible all -i inventory/aws -m ping

# update the playbook and apply changes
ansible-playbook -i inventory/aws playbook.yml
```

### Roles

```bash
# EPEL Repository
ansible-galaxy install geerlingguy.repo-epel

# Docker
ansible-galaxy install geerlingguy.docker

# Minikube
ansible-galaxy install gantsign.minikube
```

## References

- [List of Ansible OS Family & OS Distribution Facts](https://techviewleo.com/list-of-ansible-os-family-distributions-facts/)
- [Ansible Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
- [geerlingguy/ansible-role-docker](https://github.com/geerlingguy/ansible-role-docker)
- [gantsign/ansible_role_minikube](https://github.com/gantsign/ansible_role_minikube)
- [geerlingguy/ansible-role-repo-epel](https://github.com/geerlingguy/ansible-role-repo-epel)
- [githubixx/ansible-role-kubectl](https://github.com/githubixx/ansible-role-kubectl)
