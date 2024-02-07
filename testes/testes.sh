#!/bin/bash

# Variáveis
LDAP_SERVER="192.168.0.2"
LDAP_BASEDN="dc=iron,dc=lan"
LDAP_BINDDN="cn=rt225848,dc=iron,dc=lan"
LDAP_BINDPW="acc355"

# Instalação de pacotes necessários
apt update
apt install -y ldap-utils libpam-ldap libnss-ldap

# Configuração do cliente LDAP
dpkg-reconfigure ldap-auth-config

# Configuração do NSSwitch
echo "passwd:         files ldap" >> /etc/nsswitch.conf
echo "group:          files ldap" >> /etc/nsswitch.conf
echo "shadow:         files ldap" >> /etc/nsswitch.conf

# Configuração do PAM
echo "session required pam_mkhomedir.so skel=/etc/skel/ umask=0022" >> /etc/pam.d/common-session

# Configuração do LDAP
sed -i "s|uri ldap://.*|uri ldap://$LDAP_SERVER/|g" /etc/ldap/ldap.conf
sed -i "s|base dc=.*|base $LDAP_BASEDN|g" /etc/ldap/ldap.conf
sed -i "s|binddn.*|binddn $LDAP_BINDDN|g" /etc/ldap/ldap.conf
sed -i "s|bindpw.*|bindpw $LDAP_BINDPW|g" /etc/ldap/ldap.conf

# Reinicializa os serviços
service nscd restart
service nslcd restart

echo "Configuração LDAP concluída com sucesso."
