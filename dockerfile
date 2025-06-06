###New website

FROM fros/centos9
RUN dnf update -y && dnf install -y zip unzip httpd wget && yum clean all
RUN  systemctl enable httpd
ADD https://templatemo.com/download/templatemo_590_topic_listing /var/www/html/
RUN cd /var/www/html/ && \
    mv templatemo_590_topic_listing templatemo_590_topic_listing.zip && unzip  templatemo_590_topic_listing.zip -d ./
RUN mv  /var/www/html/templatemo_590_topic_listing/* /var/www/html/
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
EXPOSE 80
