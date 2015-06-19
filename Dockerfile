# sshd
#
# VERSION               0.0.2

FROM ubuntu:14.04
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# SSH key-based authorization
RUN mkdir ~/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMX8wCupfPJLYmvM2WUm3ERGDDg0D4UJzCtSB+10kwfX880g42P0W5xu/3OuLEk4Zpt4sQrVxpdDbrVB0UZ6ydFryjU17WWy1O1Bn9NsrU4iJuJ9S5DkPotYvuKiqD1MHfuObpNOfnxNSfNg2V8P8PzoC9Ki3VV5Zt+Q1K1RHs4kwbUdPCoI/zaSLJeAimN2gnaUKm/ffPbAOYEfcJw93d9FkgxPTYl35tniMHeGOfnAmDTzW+s+ggqA7IPC6pGi0aWRu428AoZ7a9T+cMrMN/Frt0TnVYEN7U/8c0IIG3pis3Gb7PzE/smFzwcsm+srDRlKuc2J8Yc10vytd+2PTx thomas@thomas-desktop" > ~/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
