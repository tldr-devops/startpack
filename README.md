# startpack

This is a basic setup of services for faster startup development. You can run it via [docker-compose](https://docs.docker.com/compose/) or [docker swarm](https://docs.docker.com/engine/reference/commandline/stack/).

Warning: This setup doesn't provide high level of security or any high availability. You have to hire some skilled devops engineer (like me)) for close this gap after getting first round or sales.

Work in progress:
* [+] Docker Compose
* [-] Docker Swarm not tested yet
* [+] Traefik
* [+] NFS for docker swarm volumes
* [+] Mariadb
* [+] Postgresql
* [+] SQL Adminer
* [+] Portainer
* [+] Docker registry
* [+] Minio
* [+] Nocodb
* [-] Monitoring
* [-] Gitlab
* [-] Openproject
* [-] Bitwarden

Time track:
- [Filipp Frizzy](https://github.com/Friz-zy/) 25h 25m for 5 days

## Support

You can support this or any other of my projects
  - [![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/filipp_frizzy)
  - [donationalerts.com/r/filipp_frizzy](https://www.donationalerts.com/r/filipp_frizzy)
  - ETH 0xCD9fC1719b9E174E911f343CA2B391060F931ff7
  - BTC bc1q8fhsj24f5ncv3995zk9v3jhwwmscecc6w0tdw3

## Setup

All operations should be executed from root on target machine. You can use your laptop or some server.
You need a valid domain name pointed to this server for automatically setting up https with [traefik](https://traefik.io) and [letsencrypt](https://letsencrypt.org). However, you can [hack your hosts file](https://docs.rackspace.com/support/how-to/modify-your-hosts-file/) for working without https.

If you run services with `docker-compose`, all service will be located on your single server. With `docker stack` (swarm) mode, you can [add addition servers](https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/) in the same local network (the same network important for nfs volumes mounting unfortunately).

#### 1) Install docker if it doesn't installed
(run scripts from the internet is a bad practice, but if you don't know how to install docker with package managers - it's acceptable)
```
curl -fsSL https://get.docker.com -o get-docker.sh
DRY_RUN=1 sh ./get-docker.sh
sh ./get-docker.sh
```

#### 2) Install docker-compose or setup docker swarm
Install docker-compose if you don't wanna use more complex docker swarm.
```
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

[Setup docker swarm](https://docs.docker.com/engine/reference/commandline/swarm_init/) if you choose using it.
```
docker swarm init --advertise-addr $(hostname -I | awk '{print $1}')
```

#### 3) Get this repo
```
git checkout https://github.com/tldr-devops/startpack.git --depth=1
cd startpack
```

#### 4) Fill necessary variables like domain name of your server, your email, passwords for basic auth and sql services.

Generate random passwords
```
echo -e "export GITLAB_SQL_PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
echo -e "export OPENPROJECT_SQL_PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
echo -e "export NOCODB_SQL_PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
echo -e "export REGISTRY_PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
echo -e "export SQL_ROOT_PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
echo -e "export PASSWORD=$(echo $RANDOM `date`|md5sum|base64|head -c 25)\n$(cat env.sh)" > env.sh
```

You should change this lines with your email and dns name
```
echo -e "export EMAIL='Type your email here'\n$(cat env.sh)" > env.sh
echo -e "export DOMAIN='Type your domain here'\n$(cat env.sh)" > env.sh
```

This is your credentials, store it in your password manager ;)
```
cat env.sh
```

#### 5) Prepare environment
```
source env.sh
bash setup.sh
```

#### 6) Run your new services

##### Docker Compose
```
docker-compose -f setup-compose.yml up -d
docker-compose -f database.yml up -d
docker-compose -f registry.yml up -d
docker-compose -f minio.yml up -d
```

After enabling portainer you should immediately go to portainer.{your domain} and set admin password
```
docker-compose -f portainer.yml up -d
```

After enabling nocodb you should immediately go to nocodb.{your domain} and set admin password
```
docker-compose -f nocodb.yml up -d
```

##### Docker Swarm
```
docker stack deploy --compose-file setup-swarm.yml
docker stack deploy --compose-file database.yml
docker stack deploy --compose-file registry.yml
docker stack deploy --compose-file minio.yml
```

After enabling portainer you should immediately go to portainer.{your domain} and set admin password
```
docker stack deploy --compose-file portainer.yml
```

After enabling nocodb you should immediately go to nocodb.{your domain} and set admin password
```
docker stack deploy --compose-file nocodb.yml
```
