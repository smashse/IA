#!/bin/bash
# Script para gerar novos agentes a partir de templates
# Uso: bash tests/create_agent.sh [opções]

set -e

TEMPLATES_DIR="$(dirname "$0")/../templates"
AGENTS_DIR="$(dirname "$0")/../agents"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar ajuda
show_help() {
  echo -e "${BLUE}Gerador de Agentes${NC}"
  echo ""
  echo "Uso: $0 [opções]"
  echo ""
  echo "Opções:"
  echo "  -n, --name        Nome do agente (obrigatório)"
  echo "  -d, --description Descrição do agente"
  echo "  -m, --mode        Modo (primary, subagent, all)"
  echo "  -l, --model       Modelo LLM a ser usado"
  echo "  -r, --role        Papel do agente"
  echo "  -h, --help        Mostra esta ajuda"
  echo ""
  echo "Exemplos:"
  echo "  $0 -n data-analyst -d 'Analista de Dados' -m subagent -l 'ollama/llama3.2:8b' -r 'analista de dados'"
  echo "  $0 --name devsecops --description 'DevSecOps' --mode subagent --model 'ollama/llama3.2:8b' --role 'engenheiro DevSecOps'"
}

# Função para validar entrada
validate_input() {
  if [ -z "$AGENT_NAME" ]; then
    echo -e "${RED}Erro: Nome do agente é obrigatório${NC}"
    echo "Use: $0 -n nome-do-agente"
    exit 1
  fi
  
  # Verificar se o agente já existe
  if [ -f "$AGENTS_DIR/$AGENT_NAME.md" ]; then
    echo -e "${RED}Erro: Agente já existe: $AGENT_NAME.md${NC}"
    echo "Use um nome diferente ou remova o agente existente."
    exit 1
  fi
}

# Função para gerar agente
generate_agent() {
  local template_file="$TEMPLATES_DIR/agent.md"
  
  if [ ! -f "$template_file" ]; then
    echo -e "${RED}Erro: Template não encontrado: $template_file${NC}"
    exit 1
  fi
  
  # Valores padrão
  local description="${DESCRIPTION:-$AGENT_NAME}"
  local mode="${MODE:-subagent}"
  local model="${MODEL:-ollama/llama3.2:8b}"
  local role="${ROLE:-especialista}"
  local intro="${INTRODUCAO:-Você é responsável por tarefas especializadas no domínio de $AGENT_NAME.}"
  local responsabilidades="${RESPONSABILIDADES:-Responsabilidade 1, Responsabilidade 2, Responsabilidade 3}"
  local competencias="${COMPETENCIAS:-Competência 1, Competência 2, Competência 3}"
  local estilo="${ESTILO_TRABALHO:-Trabalhe de forma organizada, Documente suas decisões, Responda em português quando o usuário comunicar em português}"
  local convencoes="${CONVENCOES_SAIDA:-Estrutura: problema → solução → implementação, Inclua exemplos quando relevante, Documente limitações conhecidas}"
  
  # Gerar comandos bash baseados no papel
  local bash_commands="git *"
  
  # Criar arquivo temporário com os valores
  local temp_file=$(mktemp)
  cat > "$temp_file" << EOF
description=$description
mode=$mode
model=$model
role=$role
intro=$intro
responsabilidades=$responsabilidades
competencias=$competencias
estilo=$estilo
convencoes=$convencoes
bash_commands=$bash_commands
EOF
  
  # Criar agente usando cat e heredoc
  cat > "$AGENTS_DIR/$AGENT_NAME.md" << EOF
---
description: $description
mode: $mode
model: $model
permission:
  edit: allow
  bash:
    "$bash_commands": allow
    "sudo *": ask
    "rm *": ask
    "*": ask
---

> **Modelo padrão:** \`$model\`. Para alternativas open-source por cenário de hardware, veja a [Seção 10.8](#108-modelos-recomendados-por-cenario).

---

Você é um(a) $role sênior. $intro

## Responsabilidades

$(echo -e $responsabilidades | sed 's/,/\n- /g' | sed 's/^/- /')

## Competências Principais

$(echo -e $competencias | sed 's/,/\n- /g' | sed 's/^/- /')

## Estilo de Trabalho

$(echo -e $estilo | sed 's/,/\n- /g' | sed 's/^/- /')

## Convenções de Saída

$(echo -e $convencoes | sed 's/,/\n- /g' | sed 's/^/- /')

## Gerenciamento de Dependências

- Antes de usar uma ferramenta, verifique se está instalada (ex: \`which ferramenta\`)
- Se não estiver, informe ao usuário qual dependência é necessária e por quê
- Solicite permissão explícita antes de executar qualquer comando de instalação
- Nunca instale dependências sem autorização do usuário
- Prefira gerenciadores de pacotes oficiais do ecossistema (pip, npm, etc.)
- Nunca use \`sudo\` para instalações de dependências sem autorização explícita
EOF
  
  # Limpar arquivo temporário
  rm -f "$temp_file"
  
  echo -e "${GREEN}Agente gerado com sucesso!${NC}"
  echo -e "  Arquivo: $AGENTS_DIR/$AGENT_NAME.md"
  echo -e "  Nome: $AGENT_NAME"
  echo -e "  Descrição: $description"
  echo -e "  Modo: $mode"
  echo -e "  Modelo: $model"
}

# Função para listar templates disponíveis
list_templates() {
  echo -e "${BLUE}Templates disponíveis:${NC}"
  echo ""
  ls -1 "$TEMPLATES_DIR"/*.md 2>/dev/null | while read -r template; do
    local name=$(basename "$template" .md)
    echo "  - $name"
  done
  echo ""
  echo "Use: $0 -t <template>"
}

# Main
AGENT_NAME=""
DESCRIPTION=""
MODE=""
MODEL=""
ROLE=""
INTRODUCAO=""
RESPONSABILIDADES=""
COMPETENCIAS=""
ESTILO_TRABALHO=""
CONVENCOES_SAIDA=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--name)
      AGENT_NAME="$2"
      shift 2
      ;;
    -d|--description)
      DESCRIPTION="$2"
      shift 2
      ;;
    -m|--mode)
      MODE="$2"
      shift 2
      ;;
    -l|--model)
      MODEL="$2"
      shift 2
      ;;
    -r|--role)
      ROLE="$2"
      shift 2
      ;;
    -i|--intro)
      INTRODUCAO="$2"
      shift 2
      ;;
    -p|--responsibilities)
      RESPONSABILIDADES="$2"
      shift 2
      ;;
    -c|--competences)
      COMPETENCIAS="$2"
      shift 2
      ;;
    -w|--workstyle)
      ESTILO_TRABALHO="$2"
      shift 2
      ;;
    -s|--output)
      CONVENCOES_SAIDA="$2"
      shift 2
      ;;
    -t|--template)
      list_templates
      exit 0
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo -e "${RED}Opção inválida: $1${NC}"
      show_help
      exit 1
      ;;
  esac
done

# Verificar se tem nome
if [ -z "$AGENT_NAME" ]; then
  show_help
  exit 1
fi

# Validar e gerar
validate_input
generate_agent