###New website

FROM fros/centos9
RUN mkdir /home/jenkins/webtool
RUN dnf update -y && dnf install -y zip unzip httpd wget && yum clean all
RUN  systemctl enable httpd
RUN cd /home/jenkins/webtool && \
    wget -q https://templatemo.com/download/templatemo_590_topic_listing && mv templatemo_590_topic_listing templatemo_590_topic_listing.zip && \
    unzip  templatemo_590_topic_listing.zip -d templatemo_590_topic_listing
COPY templatemo_590_topic_listing/ /var/www/html/
EXPOSE 80
