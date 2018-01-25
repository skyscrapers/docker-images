FROM busybox

ENV CONFIGMAP_DIR
ENV VOLUME_DIR

COPY populate.sh /usr/bin/populate.sh

RUN [“chmod”, “+x”, "/usr/bin/populate.sh"]

CMD /usr/bin/populate.sh
