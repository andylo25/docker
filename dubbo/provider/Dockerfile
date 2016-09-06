FROM java:7-alpine
MAINTAINER andylo25 <andylo25@163.com>

ADD dubbo-demo-provider-2.5.4-assembly.tar.gz /dubbo-demo-provider-2.5.4-assembly.tar.gz
RUN tar zxvf /dubbo-demo-provider-2.5.4-assembly.tar.gz
RUN cd /dubbo-demo-provider-2.5.4

EXPOSE 8080
CMD ["./bin/start.sh"]
