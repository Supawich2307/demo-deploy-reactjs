#!/bin/bash

export LANG="en_US.UTF-8"

APP_NAME=$(cat /image_info/app_name)
APP_VERSION=$(cat /image_info/app_version)
APP_PROTOCOL=$(cat /image_info/app_protocol)
APP_PORT=$(cat /image_info/app_port)
APP_CONTEXT_PATH=$(cat /image_info/app_context_path)

DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

echo "Current environment is " $ENV_NAME
echo "Current appscope is " $APP_SCOPE
echo "Current country code is " $COUNTRY_CODE

echo "$(date "${DATE_FORMAT}") | Start Application "

echo "$(date "${DATE_FORMAT}") | Start Nginx "

exec nginx -c /usr/local/nginx/nginx.conf -g "daemon off;"
