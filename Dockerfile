FROM registry.fedoraproject.org/fedora:latest
RUN dnf upgrade -y && dnf install -y openssh-server procps-ng net-tools iputils openvpn && dnf clean all

COPY sshd_config /etc/ssh/sshd_config
COPY id_rsa.pub /root/.ssh/authorized_keys
COPY AirVPN_America_UDP-443.ovpn /etc/openvpn/client/openvpn.conf
RUN chmod 600 /etc/ssh/sshd_config /root/.ssh/authorized_keys /etc/openvpn/client/openvpn.conf

COPY run-sshd /usr/local/bin/run-sshd
COPY openvpn.client.up /etc/openvpn/openvpn.client.up
RUN chmod 755 /usr/local/bin/run-sshd /etc/openvpn/openvpn.client.up

EXPOSE 22/tcp
ENTRYPOINT /usr/local/bin/run-sshd
LABEL name="proxybox" version="1.0" description="A socks4/5 proxy server, routing traffic via OpenVPN." maintainer="dave@daveking.com" vendor=""
