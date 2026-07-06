#!/bin/bash
# Script de gerenciamento de versão dos agentes
# Uso: bash tests/version.sh [comando]

set -e

VERSION_FILE="$(dirname "$0")/../VERSION"
CHANGELOG_FILE="$(dirname "$0")/../CHANGELOG.md"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar ajuda
show_help() {
  echo -e "${BLUE}Gerenciamento de Versão dos Agentes${NC}"
  echo ""
  echo "Uso: $0 [comando]"
  echo ""
  echo "Comandos:"
  echo "  show          Mostra a versão atual"
  echo "  bump major    Incrementa versão major (x.0.0)"
  echo "  bump minor    Incrementa versão minor (0.x.0)"
  echo "  bump patch    Incrementa versão patch (0.0.x)"
  echo "  changelog     Mostra o changelog"
  echo "  tag           Cria uma tag git com a versão atual"
  echo "  help          Mostra esta ajuda"
  echo ""
  echo "Exemplos:"
  echo "  $0 show"
  echo "  $0 bump patch"
  echo "  $0 tag"
}

# Função para ler a versão atual
get_version() {
  if [ -f "$VERSION_FILE" ]; then
    cat "$VERSION_FILE" | tr -d '[:space:]'
  else
    echo "0.0.0"
  fi
}

# Função para salvar a versão
save_version() {
  echo "$1" > "$VERSION_FILE"
}

# Função para incrementar versão
bump_version() {
  local current_version=$(get_version)
  local major=$(echo "$current_version" | cut -d. -f1)
  local minor=$(echo "$current_version" | cut -d. -f2)
  local patch=$(echo "$current_version" | cut -d. -f3)
  
  case "$1" in
    major)
      major=$((major + 1))
      minor=0
      patch=0
      ;;
    minor)
      minor=$((minor + 1))
      patch=0
      ;;
    patch)
      patch=$((patch + 1))
      ;;
    *)
      echo -e "${RED}Erro: Tipo de incremento inválido: $1${NC}"
      echo "Use: major, minor ou patch"
      exit 1
      ;;
  esac
  
  local new_version="$major.$minor.$patch"
  save_version "$new_version"
  echo -e "${GREEN}Versão incrementada: $current_version → $new_version${NC}"
  
  # Atualizar CHANGELOG
  update_changelog "$new_version"
}

# Função para atualizar changelog
update_changelog() {
  local version=$1
  local date=$(date +%Y-%m-%d)
  
  # Criar changelog se não existir
  if [ ! -f "$CHANGELOG_FILE" ]; then
    cat > "$CHANGELOG_FILE" << EOF
# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

EOF
  fi
  
  # Adicionar nova entrada
  local temp_file=$(mktemp)
  cat > "$temp_file" << EOF
## [$version] - $date

### Adicionado
- Novo sistema de versionamento
- Script de gerenciamento de versão
- CHANGELOG.md

### Corrigido
- Permissões do tech-lead (sudo e rm como ask)
- Seção de estilo de trabalho no tech-lead

### Testado
- Suite de testes automatizados para validação de agentes

EOF
  
  # Inserir após o cabeçalho
  head -6 "$CHANGELOG_FILE" > "$temp_file"
  echo "" >> "$temp_file"
  echo "## [$version] - $date" >> "$temp_file"
  echo "" >> "$temp_file"
  echo "### Adicionado" >> "$temp_file"
  echo "- Novo sistema de versionamento" >> "$temp_file"
  echo "- Script de gerenciamento de versão" >> "$temp_file"
  echo "- CHANGELOG.md" >> "$temp_file"
  echo "" >> "$temp_file"
  echo "### Corrigido" >> "$temp_file"
  echo "- Permissões do tech-lead (sudo e rm como ask)" >> "$temp_file"
  echo "- Seção de estilo de trabalho no tech-lead" >> "$temp_file"
  echo "" >> "$temp_file"
  echo "### Testado" >> "$temp_file"
  echo "- Suite de testes automatizados para validação de agentes" >> "$temp_file"
  echo "" >> "$temp_file"
  tail -n +7 "$CHANGELOG_FILE" >> "$temp_file"
  
  mv "$temp_file" "$CHANGELOG_FILE"
  echo -e "${GREEN}CHANGELOG atualizado${NC}"
}

# Função para criar tag git
create_tag() {
  local version=$(get_version)
  local tag="v$version"
  
  if [ -d "$(dirname "$0")/../.git" ]; then
    git tag -a "$tag" -m "Versão $version"
    echo -e "${GREEN}Tag criada: $tag${NC}"
    echo -e "${YELLOW}Para enviar: git push origin $tag${NC}"
  else
    echo -e "${YELLOW}Aviso: Não é um repositório git. Tag não criada.${NC}"
    echo "Para usar tags, inicialize um repositório git:"
    echo "  cd $(dirname "$0")/.."
    echo "  git init"
    echo "  git add ."
    echo "  git commit -m 'Initial commit'"
  fi
}

# Função para mostrar changelog
show_changelog() {
  if [ -f "$CHANGELOG_FILE" ]; then
    cat "$CHANGELOG_FILE"
  else
    echo -e "${YELLOW}Nenhum changelog encontrado.${NC}"
    echo "Execute '$0 bump patch' para criar o changelog."
  fi
}

# Main
case "$1" in
  show)
    echo -e "${BLUE}Versão atual:${NC} $(get_version)"
    ;;
  bump)
    bump_version "$2"
    ;;
  tag)
    create_tag
    ;;
  changelog)
    show_changelog
    ;;
  help|--help|-h)
    show_help
    ;;
  *)
    if [ -z "$1" ]; then
      show_help
    else
      echo -e "${RED}Comando inválido: $1${NC}"
      echo "Execute '$0 help' para ver os comandos disponíveis."
      exit 1
    fi
    ;;
esac