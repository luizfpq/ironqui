# Ironqui

Este repositório contém um conjunto de playbooks do Ansible, proporcionando a facilidade de implantação do meu homelab. O objetivo futuro é desenvolver menus interativos que permitam a instalação personalizada de opções conforme a demanda. Atualmente, os playbooks são identificados o formato "item_playbook", enquanto as pastas dentro da mesma estrutura, sem o sufixo "playbook", indicam arquivos específicos de um item ou aplicação associado a esse playbook.

## Estrutura do Repositório

- **app_playbook**
  - arquivo do playbook principal de uma determinada aplicação.

- **app/**
  - Arquivos relacionados ao playbook principal e playbooks secundários corelacionados e necessários para realização da implantação.

- **app_README.md**
  - Arquivo readme direcionado especificamente ao playbook da aplicação.

## Mudança de Repositório

O repositório QXDC, está sendo migrado para este conjunto de playbooks, de modo que todas as configurações anteriormente feitas pelo repositório luizfpq/qxdc, agora estarão disponíveis pelo "qxdc_playbook" foi transferido para este ambiente. Essa mudança visa consolidar todos os playbooks relacionados ao ansible em um único repositório, proporcionando uma organização mais eficiente das minhas customizações de ambiente.

--
Perfeito — vou te dar um **tutorial passo a passo em Markdown** (em português) mostrando **do zero** como criar um `inventory.ini` simples e armazenar a senha do `sudo` de forma segura usando **Ansible Vault**. Incluo exemplos de arquivos, comandos e dicas de segurança (por exemplo: usar `vault_password_file` e permissões corretas).

# Como usar o Ansible Vault para guardar a senha do `sudo`

> Objetivo: ter um `inventory.ini` limpo e a senha do `sudo` encriptada em um arquivo que o Ansible usa automaticamente.

---

## 1. Estrutura de diretórios (crie um diretório novo do projeto)

```bash
mkdir -p ~/ironqui/ansible
cd ~/ironqui/ansible
```

---

## 2. Crie um `inventory.ini` mínimo

Crie `inventory.ini` com o host e variáveis públicas (sem a senha):

```ini
[qxdc]
192.168.1.10 ansible_user=quirino ansible_become=yes ansible_become_method=sudo
```

Salve em `~/ironqui/ansible/inventory.ini`.

> Nota: `ansible_become=yes` indica que o Ansible deve usar elevação; a senha do `sudo` ficará criptografada no próximo passo.

---

## 3. Organize `group_vars` (local recomendado)

Usando `group_vars` você mantém variáveis por grupo. Crie a pasta:

```bash
mkdir -p group_vars/qxdc
```

---

## 4. Crie o arquivo de variáveis criptografado com Ansible Vault

Você pode criar o arquivo já criptografado com `ansible-vault create` (recomendado) — isso abre o editor para você colocar a variável:

```bash
ansible-vault create group_vars/qxdc/vault.yml
```

No editor que abrir (normalmente `vi` ou o que estiver configurado), coloque:

```yaml
---
# arquivo: group_vars/qxdc/vault.yml
ansible_become_pass: "SuaSenhaDoSudoAqui"
```

Salve e saia. O arquivo ficará criptografado.

Alternativa (se você já tem o arquivo em texto):

```bash
# Crie um arquivo plaintext (temporário)
echo -e "---\nansible_become_pass: \"SuaSenhaDoSudoAqui\"" > /tmp/vault_plain.yml

# Encriptar para o destino
ansible-vault encrypt --output=group_vars/qxdc/vault.yml /tmp/vault_plain.yml

# Apague o arquivo plaintext
shred -u /tmp/vault_plain.yml  # ou rm -f /tmp/vault_plain.yml
```

---

## 5. Executar o playbook usando Ansible Vault

### Opção A — Digitar a senha do Vault (mais seguro)

Execute:

```bash
ansible-playbook -i inventory.ini qxdc_playbook.yml --ask-vault-pass
```

O Ansible pedirá a senha do *vault* (não a senha do sudo). Ao descriptografar, ele usará `ansible_become_pass` para comandos `sudo`.

### Opção B — Usar um arquivo com a senha do Vault (para automação)

Crie um arquivo seguro que contenha a senha do vault (apenas leitura pelo seu usuário):

```bash
echo "SenhaDoVaultAqui" > ~/.ansible_vault_pass.txt
chmod 600 ~/.ansible_vault_pass.txt
```

Então rode:

```bash
ansible-playbook -i inventory.ini qxdc_playbook.yml --vault-password-file ~/.ansible_vault_pass.txt
```

---

## 6. (Opcional) Deixar o arquivo do password do vault no `ansible.cfg`

Se você preferir não passar `--vault-password-file` toda vez, crie/edite `ansible.cfg` no diretório do projeto:

`ansible.cfg`:

```ini
[defaults]
inventory = ./inventory.ini
vault_password_file = ~/.ansible_vault_pass.txt
```

**Atenção**: manter `vault_password_file` em `ansible.cfg` facilita automação, mas o arquivo apontado deve ser protegido (`chmod 600`) e só acessível por quem for autorizado.

---

## 7. Testar (comando de verificação)

Teste se o Ansible consegue executar um `sudo whoami` no grupo `qxdc`:

* com `--ask-vault-pass`:

```bash
ansible -i inventory.ini qxdc -m command -a "sudo whoami" --ask-vault-pass
```

* com `--vault-password-file`:

```bash
ansible -i inventory.ini qxdc -m command -a "sudo whoami" --vault-password-file ~/.ansible_vault_pass.txt
```

Saída esperada: `root` (e sem pedir o `BECOME password:`).

---

## 8. Permissões e segurança

* Nunca comite arquivos com senhas em texto puro no git.
* O arquivo `group_vars/qxdc/vault.yml` estará criptografado — OK para versionar se o repositório tiver controle de acesso.
* Proteja `~/.ansible_vault_pass.txt` com `chmod 600`.
* Prefira `ansible-vault create` ou `encrypt` em vez de gravar senhas em plaintext.
* Considere alternativas mais seguras: usar **sudo sem senha** em hosts confiáveis (NOPASSWD), **Vaults corporativos** (HashiCorp Vault, AWS Secrets Manager) ou autenticação SSH com chaves e sudoers finos.

---

## 9. Como editar o arquivo criptografado

Para editar:

```bash
ansible-vault edit group_vars/qxdc/vault.yml
```

Isso descriptografa temporariamente para edição e recriptografa ao salvar.

---

## 10. Rotina para adicionar um novo host (resumindo)

1. `vim inventory.ini` → adicione host com `ansible_user` e `ansible_become=yes`.
2. `mkdir -p group_vars/<grupo>` se não existir.
3. `ansible-vault create group_vars/<grupo>/vault.yml` → coloque `ansible_become_pass: "..."`.
4. Execute playbook com `--ask-vault-pass` ou `--vault-password-file`.

---

## 11. Exemplo completo de arquivos (resumo)

`inventory.ini`

```ini
[qxdc]
192.168.1.10 ansible_user=quirino ansible_become=yes ansible_become_method=sudo
```

`group_vars/qxdc/vault.yml` (ENCRIPTADO — conteúdo quando aberto):

```yaml
---
ansible_become_pass: "SuaSenhaDoSudoAqui"
```

`ansible.cfg` (opcional):

```ini
[defaults]
inventory = ./inventory.ini
vault_password_file = ~/.ansible_vault_pass.txt
```

---

## 12. Observações finais e boas práticas

* Usar Ansible Vault é muito melhor do que deixar `ansible_become_pass` em texto claro.
* Para máxima segurança em ambientes de produção, integre um **secret manager** (ex.: HashiCorp Vault) ou configure sudoers para reduzir a necessidade de senhas.
* Se você optar por versionar o arquivo `group_vars/.../vault.yml` no git, **garanta** que o repositório tem controle de acesso e que a senha do Vault (vault password) não está no repositório.


