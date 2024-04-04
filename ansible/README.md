# Executando os Playbooks:

Para executar um playbook utilizando um arquivo `inventory.ini` no Ansible, siga os passos abaixo:

1. **Crie um Arquivo YAML para o Playbook**:
   Primeiramente, crie um arquivo YAML contendo as tarefas que deseja executar nos hosts especificados no inventário. Abaixo está um exemplo básico de um playbook YAML:

```yaml
---
- name: Exemplo de playbook
  hosts: all
  become: true
  tasks:
    - name: Executar uma tarefa
      debug:
        msg: "Esta é uma tarefa de exemplo."
```

2. **Executar o Playbook**:
   Utilize o comando `ansible-playbook` para executar o playbook. Certifique-se de especificar o arquivo de inventário que será usado. Por exemplo:

```
ansible-playbook -i inventory.ini playbook.yml
```

   - `-i inventory.ini`: Especifica o arquivo de inventário a ser utilizado.
   - `playbook.yml`: É o nome do arquivo YAML que contém as tarefas a serem executadas.

Isso irá executar as tarefas definidas no playbook em todos os hosts especificados no arquivo de inventário.

Agora vamos criar o arquivo `inventory.ini` que será utilizado como referência para os hosts e grupos no Ansible.

# Criando o Arquivo inventory.ini para Ansible

O arquivo de inventário é essencial no Ansible, pois define os hosts e grupos que serão gerenciados. Ele contém detalhes de conexão dos hosts, como endereços IP e credenciais de autenticação.

## Grupos de Hosts

### [grupo_exemplo]
Este grupo representa um localhost com o endereço IP 127.0.0.1 e está configurado para usar o método de conexão local.

```
[grupo_exemplo]
127.0.0.1 ansible_connection=local
```

### [web_servers]
Este grupo representa os servidores web na infraestrutura, incluindo os hosts web1.example.com e web2.example.com.

```
[web_servers]
web1.example.com
web2.example.com
```

### [database_servers]
Este grupo representa os servidores de banco de dados na infraestrutura, incluindo os hosts db1.example.com e db2.example.com.

```
[database_servers]
db1.example.com
db2.example.com
```

## Grupo [all:vars]

Este grupo contém variáveis aplicáveis a todos os hosts no inventário. No exemplo abaixo, definimos `ansible_user` como "usuario" e `ansible_become_password` como "senhasudo".

```
[all:vars]
ansible_user=usuario
#ansible_ssh_private_key_file=/path/to/your/private/key.pem
ansible_become_password=senhasudo
```

**Nota:** A variável `ansible_ssh_private_key_file` está comentada. Descomente e defina-a como o caminho do seu arquivo de chave privada, se necessário.

```
# ansible_ssh_private_key_file=/path/to/your/private/key.pem
```

Este arquivo de inventário é um exemplo básico de como estruturar hosts e grupos no Ansible para facilitar o gerenciamento de infraestrutura. Certifique-se de adaptá-lo às necessidades específicas do seu ambiente.