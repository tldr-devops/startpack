mkdir -p ${DATAPATH?Variable DATAPATH not set}/{traefik,mariadb,postgres,portainer,registry,minio,nocodb,openproject,gitlab,strapi,telegraf,prometheus,influxdb}/{data,entrypoint,configs,certificates}

envsubst < configs/postgres.sql > ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
cp configs/prometheus.yml ${DATAPATH?Variable DATAPATH not set}/prometheus/configs/prometheus.yml
cp configs/telegraf-node.conf ${DATAPATH?Variable DATAPATH not set}/telegraf/configs/telegraf-node.conf
cp configs/telegraf.conf ${DATAPATH?Variable DATAPATH not set}/telegraf/configs/telegraf.conf
cp configs/influxdb.sh ${DATAPATH?Variable DATAPATH not set}/influxdb/entrypoint/influxdb.sh
