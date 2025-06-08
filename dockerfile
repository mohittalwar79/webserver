###New website

FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
RUN yum update -y && yum install -y zip unzip httpd wget && yum clean all
RUN  systemctl enable httpd
ADD https://templatemo.com/download/templatemo_590_topic_listing /var/www/html/
RUN cd /var/www/html/ && \
    mv templatemo_590_topic_listing templatemo_590_topic_listing.zip && unzip  templatemo_590_topic_listing.zip -d ./
RUN mv  /var/www/html/templatemo_590_topic_listing/* /var/www/html/
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
EXPOSE 80
