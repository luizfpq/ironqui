# ironqui

# ldap_playbook: Configuração de Autenticação LDAP no Debian 12 usando Ansible.

Lembre-se de ajustar as informações específicas do seu ambiente, como endereços IP, nomes de usuário e senhas. Neste tutorial, vamos criar um playbook Ansible para configurar um servidor Debian 12 para autenticação LDAP, integrando-o a um domínio.

**Pré-requisitos (c**ertifique-se de ter os seguintes pré-requisitos instalados):
- Ansible no servidor Ansible
- SSH configurado no servidor Debian
- Conhecimento das configurações do seu servidor LDAP (endereço IP, usuário, senha)

## Passo 1: Crie um diretório para o playbook

```bash
mkdir ansible-debian-ldap
cd ansible-debian-ldap
```

## Passo 2: Adicione os equipamentos ao inventário (inventory.ini)

Crie um arquivo chamado `inventory.ini` e adicione as informações do seu servidor Debian.

```yaml
[debian_servers]
debian_server0 ansible_host=SEU_DEBIAN ansible_user=SEU_USUARIO ansible_ssh_pass=SUA_SENHA ansible_become_pass=SUA_SENHA
debian_server1 ansible_host=SEU_DEBIAN ansible_user=SEU_USUARIO ansible_ssh_pass=SUA_SENHA ansible_become_pass=SUA_SENHA
```

Substitua `SEU_DEBIAN`, `SEU_USUARIO_SSH`, `SUA_SENHA_SSH` e `SUA_SENHA_SUDO` pelos seus próprios valores.

## Passo 3: No playbook Ansible (ldap_setup.yml)

Altere o `ldap_playbook.yml` e adicione o seguinte conteúdo.

Substitua `SEU_IP_DNS`, `SEU_LDAP_IP`, `SEU_LDAP.SEU_CN`, `SEU_USUARIO_LDAP` e `SEU_DOMINIO_LDAP`, `SUA_SENHA` pelos seus próprios valores.

## Passo 4: Execute o playbook

Execute o playbook usando o seguinte comando:

```bash
ansible-playbook -i inventory.ini ldap_setup.yml
```

Isso aplicará o playbook ao servidor Debian, configurando a autenticação LDAP de acordo com suas especificações.

Certifique-se de testar em um ambiente de homologação antes de aplicar em produção.

---

Lembre-se de ajustar todas as informações específicas do seu ambiente ao seguir este tutorial. Se encontrar problemas, ajuste conforme necessário e consulte a documentação do Ansible para obter informações adicionais.

Referências:

[https://serverspike.io/automating-active-directory-authentication-on-linux-with-ansible/](https://serverspike.io/automating-active-directory-authentication-on-linux-with-ansible/)

[https://www.server-world.info/en/note?os=Debian_12&p=realmd](https://www.server-world.info/en/note?os=Debian_12&p=realmd)

# Testes a realizar
Verificar se a cópia das chaves funciona mais rápido com essa collection
```bash
ansible-galaxy collection install community.general
```

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
