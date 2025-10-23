
# ldap_playbook: Configuração de Autenticação LDAP no Debian 12 usando Ansible.

Lembre-se de ajustar as informações específicas do seu ambiente, como endereços IP, nomes de usuário e senhas. Neste tutorial, vamos criar um playbook Ansible para configurar um servidor Debian 12 para autenticação LDAP, integrando-o a um domínio.

**Pré-requisitos (certifique-se de ter os seguintes pré-requisitos instalados)**:
- Ansible no servidor Ansible
- SSH configurado no servidor Debian
- Conhecimento das configurações do seu servidor LDAP (endereço IP, usuário, senha)

## Adicione os equipamentos ao inventário (inventory.ini)

No arquivo chamado `inventory.ini` e adicione as informações do seus Debians que receberão as configurações.

Substitua `SEU_DEBIAN`, `SEU_USUARIO_SSH`, `SUA_SENHA_SSH` e `SUA_SENHA_SUDO` pelos seus próprios valores.

## No playbook Ansible (ldap_setup.yml)

Altere o `ldap_playbook.yml` e adicione o seguinte conteúdo.

Substitua `SEU_IP_DNS`, `SEU_LDAP_IP`, `SEU_LDAP.SEU_CN`, `SEU_USUARIO_LDAP`, `SEU_DOMINIO_LDAP`, `SUA_SENHA` pelos seus próprios valores.

## Execute o playbook

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