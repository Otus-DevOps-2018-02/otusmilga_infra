# otusmilga_infra
otusmilga Infra repository

## Homework-4 (cloud-bastion)
### Credentials

```
bastion-host: 35.185.98.180, 10.142.0.3
someinternalhost: 10.142.0.4
```

### ssh to someinternalhost through bastion host (peer auth with local keypair)
```
ssh -i ~/.ssh/appuser -o "ProxyCommand ssh -W %h:%p appuser@35.185.98.180" appuser@10.142.0.4
```

### ssh_config aliases 

add following snippet to `~/.ssh/config`

```
Host bastion
        Hostname 35.185.98.180
        User appuser
        IdentityFile ~/.ssh/appuser

Host someinternalhost
        Hostname 10.142.0.4
        User appuser
        ProxyCommand ssh -W %h:%p bastion
        IdentityFile ~/.ssh/appuser
```
### vpn credentials
bastion_IP = 35.185.98.180  someinternalhost_IP = 10.142.0.4

