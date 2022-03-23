#!/bin/sh

mkdir -p /docker-entrypoint-initdb.d/templates
wget -O /docker-entrypoint-initdb.d/templates/docker.yml https://raw.githubusercontent.com/influxdata/community-templates/master/docker/docker.yml
wget -O /docker-entrypoint-initdb.d/templates/influxdb2_oss_metrics.yml https://raw.githubusercontent.com/influxdata/community-templates/master/influxdb2_oss_metrics/influxdb2_oss_metrics.yml
wget -O /docker-entrypoint-initdb.d/templates/linux_system.yml https://raw.githubusercontent.com/influxdata/community-templates/master/linux_system/linux_system.yml
wget -O /docker-entrypoint-initdb.d/templates/minio.yml https://raw.githubusercontent.com/influxdata/community-templates/master/minio/minio.yml
wget -O /docker-entrypoint-initdb.d/templates/mongodb.yml https://raw.githubusercontent.com/influxdata/community-templates/master/mongodb/mongodb.yml
wget -O /docker-entrypoint-initdb.d/templates/mysql_mariadb.yml https://raw.githubusercontent.com/influxdata/community-templates/master/mysql_mariadb/mysql_mariadb.yml
wget -O /docker-entrypoint-initdb.d/templates/network_interface_performance.yml https://raw.githubusercontent.com/influxdata/community-templates/master/network_interface_performance/network_interface_performance.yml
wget -O /docker-entrypoint-initdb.d/templates/postgres.yml https://raw.githubusercontent.com/influxdata/community-templates/master/postgresql/postgres.yml
wget -O /docker-entrypoint-initdb.d/templates/prometheus.yml https://raw.githubusercontent.com/influxdata/community-templates/master/prometheus/prometheus.yml
wget -O /docker-entrypoint-initdb.d/templates/redis.yml https://raw.githubusercontent.com/influxdata/community-templates/master/redis/redis.yml
wget -O /docker-entrypoint-initdb.d/templates/telegraf.yml https://raw.githubusercontent.com/influxdata/community-templates/master/telegraf/manifest.yml

sed -i 's|\(bucket.*\)"\w*"|\1 "telegraf"|g' /docker-entrypoint-initdb.d/templates/*.yml

influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/docker.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/influxdb2_oss_metrics.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/linux_system.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/minio.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/mongodb.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/mysql_mariadb.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/network_interface_performance.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/postgres.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/prometheus.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/redis.yml
influx apply --force conflict -R --file /docker-entrypoint-initdb.d/templates/telegraf.yml
