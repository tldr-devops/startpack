export DOMAIN=example.com
export EMAIL=admin@example.com
export USERNAME=admin
export PASSWORD=Change_Me!!1
export SQL_ROOT_PASSWORD=Change_Me!!1
export DATAPATH=/data

export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)
export PORTAINER_HASHED_PASSWORD=$(echo $HASHED_PASSWORD|sed 's/\$/$$/g')
export HOSTNAME=$(hostname)
export MASTER_IP=$(hostname -I | awk '{print $1}')
export MASTER_IP_MASK=$(ip -o -f inet addr show $(ip route list | awk '/^default/ {print $5}') | awk '{print $4}')

