FROM alpine:3.12.0 AS temp


ENV FRP_VERSION="0.34.3"
ENV FRP_ARCH="amd64"

RUN echo -e "https://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && apk update && apk add --no-cache ca-certificates curl git openssh-client tar zip bash tree tzdata  

RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz
RUN tar xzf frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz \
    && rm frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz

RUN rm -rf /var/cache/apk/*

FROM alpine:3.12.0 as prod

ENV FRP_VERSION="0.34.3"
ENV FRP_ARCH="amd64"

WORKDIR /opt/frp
COPY --from=temp frp_${FRP_VERSION}_linux_${FRP_ARCH}/frps /opt/frp/frps
#ADD frps.ini /opt/frp/frps.ini
ADD entrypoint.sh /opt/frp/entrypoint.sh
RUN chmod a+x /opt/frp/entrypoint.sh

#EXPOSE 7500 7000

#RUN adduser -D rfrp
#USER rfrp

#ENTRYPOINT [ "/entrypoint.sh" ]
CMD /opt/frp/entrypoint.sh
