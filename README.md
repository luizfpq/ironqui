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

