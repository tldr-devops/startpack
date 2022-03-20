mkdir -p ${DATAPATH?Variable DATAPATH not set}/{,nfs}/traefik/certificates
mkdir -p ${DATAPATH?Variable DATAPATH not set}/{,nfs}/{mariadb,postgres,portainer,registry,minio,nocodb,openproject,gitlab}/data
mkdir -p ${DATAPATH?Variable DATAPATH not set}/{mariadb,postgres}/entrypoint

echo "create database nocodb; create database openproject; create database gitlab;" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "create user nocodb with password '$NOCODB_SQL_PASSWORD';" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "create user openproject with password '$OPENPROJECT_SQL_PASSWORD';" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "create user gitlab with password '$GITLAB_SQL_PASSWORD';" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "grant all privileges on database nocodb to nocodb;" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "grant all privileges on database openproject to openproject;" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
echo "grant all privileges on database gitlab to gitlab;" >> ${DATAPATH?Variable DATAPATH not set}/postgres/entrypoint/init.sql
