FROM busybox

ENV CONFIGMAP_DIR=/media/configmap
ENV VOLUME_DIR=/media/volume

COPY populate.sh /usr/bin/populate.sh

RUN ["/bin/chmod", "+x", "/usr/bin/populate.sh"]

CMD /usr/bin/populate.sh
