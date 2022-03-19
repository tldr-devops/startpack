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
* [-] Monitoring
* [-] Minio
* [-] Gitlab
* [-] Docker registry
* [-] Nocodb
* [-] Openproject
* [-] Bitwarden

Time track:
- [Filipp Frizzy](https://github.com/Friz-zy/) 20h 30m for 4 days

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

1) Install docker if it doesn't installed
(run scripts from the internet is a bad practice, but if you don't know how to install docker with package managers - it's acceptable)
```
curl -fsSL https://get.docker.com -o get-docker.sh
DRY_RUN=1 sh ./get-docker.sh
sh ./get-docker.sh
```

2) Install docker-compose if you don't wanna use more complex docker swarm.
```
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

3) Get this repo
```
git checkout https://github.com/tldr-devops/startpack.git --depth=1
cd startpack
```

4) Fill necessary variables like domain name of your server, your email, passwords for basic auth and sql services.
```
nano env.sh
```

5) Prepare environment
```
source env.sh
sh setup.sh
```

6) Run your new services

Docker Compose
```
docker-compose -f setup-compose.yml up -d
docker-compose -f database.yml up -d

# after enabling portainer you should immediately go to portainer.<your domain> and set admin password
docker-compose -f portainer.yml up -d

```

Docker Swarm
```
docker stack deploy --compose-file setup-swarm.yml
docker stack deploy --compose-file database.yml

# after enabling portainer you should immediately go to portainer.<your domain> and set admin password
docker stack deploy --compose-file portainer.yml
```
