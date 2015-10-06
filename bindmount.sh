#!/bin/bash

mkdir -p /var/shared/cache/
mkdir -p /var/shared/logs/

chown -Rf vagrant:vagrant /var/shared/cache/
chown -Rf vagrant:vagrant /var/shared/logs/

mkdir -p /var/www/vhosts/logistics.promotion-tools/app/cache/
mkdir -p /var/www/vhosts/logistics.promotion-tools/app/logs/

sudo mount -o bind /var/shared/cache/ /var/www/vhosts/logistics.promotion-tools/app/cache/
sudo mount -o bind /var/shared/logs/ /var/www/vhosts/logistics.promotion-tools/app/logs/