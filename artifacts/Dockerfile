FROM node:14.21.3-alpine3.16

LABEL application="#APP_NAME#"
LABEL version="#APP_VERSION#"
LABEL app_protocol="#APP_PROTOCOL#"
LABEL app_port="#APP_PORT#"

## UPDATE IMAGE
# RUN rm -rf /var/cache/yum && yum update -y && rm -rf /var/cache/yum

RUN echo "#APP_NAME#" > /image_info/app_name \ 
&& echo "#APP_VERSION#" > /image_info/app_version \ 
&& echo "#APP_PROTOCOL#" > /image_info/app_protocol \ 
&& echo "#APP_PORT#" > /image_info/app_port \ 
&& echo "#APP_CONTEXT_PATH#" > /image_info/app_context_path

RUN chgrp -R 0 /image_info \ 
&& chmod -R u+x /image_info \ 
&& chmod -R g=u /image_info \
&& chmod -R g=u /etc/passwd

# GENERAL STEPS
RUN mkdir -p /usr/script \
&& mkdir -p /usr/share/nginx/html/#APP_CONTEXT_PATH# \
&& rm -rf /usr/share/nginx/html/#APP_CONTEXT_PATH#/* \
&& mkdir -p /var/log/nginx/client_temp

RUN chgrp -R 0 /data/projects \
&& chmod -R u+x /data/projects \
&& chmod -R g=u /data/projects \
&& chgrp -R 0 /usr/share/nginx/html \
&& chmod -R u+x /usr/share/nginx/html \
&& chmod -R g=u /usr/share/nginx/html \
&& chgrp -R 0 /usr/local/nginx \
&& chmod -R u+x /usr/local/nginx \
&& chmod -R g=u /usr/local/nginx

COPY ../#APP_NAME#.zip /usr/share/nginx/html/
COPY nginx.conf /usr/local/nginx/
COPY startup.sh /usr/script/

RUN cd /usr/share/nginx/html \ 
&& unzip #APP_NAME#.zip -d /usr/share/nginx/html/#APP_CONTEXT_PATH# \ 
&& rm -rf /usr/share/nginx/html/#APP_NAME#.zip

RUN touch /usr/local/nginx/nginx.pid \
&& chgrp 0 /usr/local/nginx/nginx.pid \
&& chmod 777 /usr/local/nginx/nginx.pid

RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log \ 
&& ln -sf /dev/stdout /usr/local/nginx/logs/error.log

RUN chgrp -R 0 /data/projects/#APP_NAME# \
&& chmod -R u+x /data/projects/#APP_NAME# \
&& chmod -R g=u /data/projects/#APP_NAME# \
&& chgrp -R 0 /usr/share/nginx/html/#APP_CONTEXT_PATH# \
&& chmod -R u+x /usr/share/nginx/html/#APP_CONTEXT_PATH# \
&& chmod -R g=u /usr/share/nginx/html/#APP_CONTEXT_PATH# \
&& chgrp -R 0 /usr/local/nginx \
&& chmod -R u+x /usr/local/nginx \
&& chmod -R g=u /usr/local/nginx \
&& chgrp -R 0 /usr/script \
&& chmod -R u+x /usr/script \
&& chmod -R g=u /usr/script \
&& chgrp -R 0 /var/log/nginx/client_temp \
&& chmod -R u+x /var/log/nginx/client_temp \
&& chmod -R g=u /var/log/nginx/client_temp 

USER 10001

ENTRYPOINT ["/usr/bin/tini","-sge 143", "--", "/usr/script/startup.sh"]
