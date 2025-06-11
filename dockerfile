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
RUN mkdir /etc/yum.repos.d/old/ && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/old/
ADD CentOS.repo /etc/yum.repos.d/
ADD epel.repo /etc/yum.repos.d/
RUN yum clean all  && yum install -y zip unzip httpd wget
RUN mkdir /var/www/htmlold && cp /var/www/html /var/www/htmlold && rm -rf /var/www/html/*
RUN  systemctl enable httpd
ADD https://templatemo.com/download/templatemo_591_villa_agency /var/www/html/
RUN cd /var/www/html/ && \
    mv templatemo_591_villa_agency templatemo_591_villa_agency.zip && unzip  templatemo_591_villa_agency.zip -d ./
RUN mv  /var/www/html/templatemo_591_villa_agency/* /var/www/html/
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
EXPOSE 80

