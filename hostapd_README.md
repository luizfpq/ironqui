
# hostapd_playbook - Configurando hotspot com 802.1x em um computador

## Tarefas do Playbook

- **Instalação de Pacotes:**
  - Instalação dos pacotes necessários, incluindo `hostapd`, `dnsmasq`, `freeradius`, `freeradius-utils`, `libpam-ldap`, e `libnss-ldap`.
  
- **Desativação de Serviços:**
  - Desativa e interrompe os serviços `dnsmasq` e `freeradius`.
  
- **Configuração da Interface de Rede:**
  - Configura a interface de rede (`wlo1`) com um endereço IP estático.
  
- **Configuração do Hostapd:**
  - Configura o `hostapd` utilizando um arquivo de modelo localizado em `hostapd/hostapd.conf.j2`.
  
- **Desmascaramento do Serviço Hostapd:**
  - Desmascara o serviço `hostapd` para permitir a inicialização.
  
- **Habilitação e Inicialização do Serviço Hostapd:**
  - Habilita e inicia o serviço `hostapd`.
  
- **Configuração do FreeRADIUS:**
  - Configura o FreeRADIUS para autenticação LDAP utilizando um arquivo de modelo localizado em `hostapd/radiusd.conf.j2`.
  
- **Reinicialização de Serviços:**
  - Reinicia os serviços de rede, `hostapd` e `freeradius` quando necessário.

## Personalização

Certifique-se de personalizar os arquivos de configuração conforme necessário, especialmente `hostapd/hostapd.conf.j2` e `hostapd/radiusd.conf.j2`. Substitua `192.168.1.2` e `192.168.1.3` pelos endereços IP reais dos seus servidores Debian.

## Verificação de Logs

Se encontrar problemas durante a execução do playbook, examine os logs do FreeRADIUS em `/var/log/freeradius/radius.log` para diagnóstico adicional.

Este playbook fornece uma base para a configuração de um ambiente de autenticação 802.1x usando `hostapd`, `FreeRADIUS` e `LDAP` em servidores Debian. Personalize conforme necessário para atender às suas necessidades específicas.
