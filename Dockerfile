FROM java:8
ENV TZ="Asia/Shanghai"

WORKDIR /root
ADD target/jenkins_springboot-0.0.1-SNAPSHOT.jar /app.jar
ADD bin/start.sh /start.sh

RUN bash -c 'touch /app.jar ;touch /root/app-gc.log '
RUN chmod 777 /start.sh
CMD ["sh", "/start.sh"]

