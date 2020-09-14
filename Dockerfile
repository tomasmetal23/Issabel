FROM centos:7

MAINTAINER Tomas Marquez tomas@saiyans.com.ve

CMD ["/bin/bash"] 

ENV container=docker

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

RUN yum update; yum -y install kernel-devel-$(uname -r) libtool make gcc patch perl bison flex-devel gcc-c++ ncurses-devel flex libtermcap-devel autoconf automake* autoconf libxml2-devel cmake curl epel-release htop glances screen fail2ban-server wget sysstat net-tools setroubleshoot; yum clean all 

WORKDIR /usr/src 

RUN curl -LOs "https://sourceforge.net/projects/issabelpbx/files/Issabel 4/issabel4-asterisk13-netinstall.sh" && chmod 777 issabel4-asterisk13-netinstall.sh && ln -s issabel4-asterisk13-netinstall.sh install.sh

EXPOSE 10000-20000/udp 110 143 25 2727/udp 8433 4569/udp 5004-5082/udp 993 995

CMD ["/usr/sbin/init"]
