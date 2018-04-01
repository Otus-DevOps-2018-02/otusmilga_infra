# otusmilga_infra
otusmilga Infra repository

## Homework-5 (cloud-testapp)

testapp_IP = 35.204.12.66
testapp_port = 9292

### GCP startup script
gcloud command to create, setup env and deploy testapp:
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure\
  --metadata-from-file  startup-script=startup.sh
```
same, but url startup:
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure\
  --metadata startup-script-url=https://gist.githubusercontent.com/otusmilga/d2049c4ed4cb094c522023fea432a181/raw/f038a23d71e51d048830770635779c970b39e892/startup.sh
```
gcloud command to create fw rule for testapp:
```
gcloud compute firewall-rules create default-puma-server \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \ 
  --action=ALLOW \
  --rules=tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
```

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
bastion_IP = 35.185.98.180
someinternalhost_IP = 10.142.0.4

