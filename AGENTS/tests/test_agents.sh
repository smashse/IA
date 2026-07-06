#!/bin/bash
# Testes automatizados para validar os agentes da squad
# Uso: bash tests/test_agents.sh

set -e

AGENTS_DIR="$(dirname "$0")/../agents"
COMMANDS_DIR="$(dirname "$0")/../commands"
ERRORS=0
TESTS=0

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para contar testes
test_pass() {
  TESTS=$((TESTS + 1))
  echo -e "${GREEN}✓ PASS${NC}: $1"
}

test_fail() {
  TESTS=$((TESTS + 1))
  ERRORS=$((ERRORS + 1))
  echo -e "${RED}✗ FAIL${NC}: $1"
}

test_info() {
  echo -e "${YELLOW}ℹ INFO${NC}: $1"
}

echo "=== Testes dos Agentes da Squad ==="
echo ""

# 1. Verificar se os diretórios existem
echo "1. Verificando estrutura de diretórios..."
if [ -d "$AGENTS_DIR" ]; then
  test_pass "Diretório de agentes existe"
else
  test_fail "Diretório de agentes não encontrado: $AGENTS_DIR"
fi

if [ -d "$COMMANDS_DIR" ]; then
  test_pass "Diretório de comandos existe"
else
  test_fail "Diretório de comandos não encontrado: $COMMANDS_DIR"
fi

# 2. Listar agentes esperados
echo ""
echo "2. Verificando agentes esperados..."
EXPECTED_AGENTS=("tech-lead.md" "backend.md" "frontend.md" "devops.md" "qa.md" "security.md")
for agent in "${EXPECTED_AGENTS[@]}"; do
  if [ -f "$AGENTS_DIR/$agent" ]; then
    test_pass "Agente encontrado: $agent"
  else
    test_fail "Agente não encontrado: $agent"
  fi
done

# 3. Verificar metadados válido em cada agente
echo ""
echo "3. Verificando metadados dos agentes..."
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  
  # Verificar se começa com ---
  if head -1 "$f" | grep -q "^---$"; then
    test_pass "$filename: metadados inicia corretamente"
  else
    test_fail "$filename: metadados não inicia com ---"
    continue
  fi
  
  # Verificar se tem fechamento do metadados
  if sed -n '2,/^---$/p' "$f" | grep -q "^---$"; then
    test_pass "$filename: metadados fecha corretamente"
  else
    test_fail "$filename: metadados não fecha com ---"
  fi
done

# 4. Verificar campos obrigatórios no metadados
echo ""
echo "4. Verificando campos obrigatórios..."
REQUIRED_FIELDS=("description" "mode" "model" "permission")
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  
  for field in "${REQUIRED_FIELDS[@]}"; do
    if sed -n '2,/^---$/p' "$f" | grep -q "^$field:"; then
      test_pass "$filename: campo '$field' presente"
    else
      test_fail "$filename: campo '$field' ausente"
    fi
  done
done

# 5. Verificar valores válidos para o campo mode
echo ""
echo "5. Verificando valores do campo mode..."
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  mode=$(sed -n '2,/^---$/p' "$f" | grep "^mode:" | cut -d: -f2 | tr -d ' ')
  
  if [ "$mode" = "primary" ] || [ "$mode" = "subagent" ] || [ "$mode" = "all" ]; then
    test_pass "$filename: mode válido ($mode)"
  else
    test_fail "$filename: mode inválido ($mode)"
  fi
done

# 6. Verificar se o tech-lead é primary
echo ""
echo "6. Verificando configuração do tech-lead..."
if grep -q "^mode: primary" "$AGENTS_DIR/tech-lead.md" 2>/dev/null; then
  test_pass "tech-lead está configurado como primary"
else
  test_fail "tech-lead não está configurado como primary"
fi

# 7. Verificar se todos os outros agentes são subagent
echo ""
echo "7. Verificando modo dos subagentes..."
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  if [ "$filename" = "tech-lead.md" ]; then
    continue
  fi
  
  if grep -q "^mode: subagent" "$f" 2>/dev/null; then
    test_pass "$filename: é subagent"
  else
    test_fail "$filename: não é subagent"
  fi
done

# 8. Verificar comandos esperados
echo ""
echo "8. Verificando comandos esperados..."
EXPECTED_COMMANDS=("code-review.md" "launch-feature.md" "incident.md" "perf-audit.md" "security-audit.md")
for cmd in "${EXPECTED_COMMANDS[@]}"; do
  if [ -f "$COMMANDS_DIR/$cmd" ]; then
    test_pass "Comando encontrado: $cmd"
  else
    test_fail "Comando não encontrado: $cmd"
  fi
done

# 9. Verificar se os comandos têm agent: tech-lead
echo ""
echo "9. Verificando configuração dos comandos..."
for f in "$COMMANDS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  if grep -q "^agent: tech-lead" "$f" 2>/dev/null; then
    test_pass "$filename: usa tech-lead como agente"
  else
    test_fail "$filename: não usa tech-lead como agente"
  fi
done

# 10. Verificar se os comandos têm $ARGUMENTS
echo ""
echo "10. Verificando variáveis nos comandos..."
for f in "$COMMANDS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  if grep -q '\$ARGUMENTS' "$f" 2>/dev/null; then
    test_pass "$filename: usa \$ARGUMENTS"
  else
    test_fail "$filename: não usa \$ARGUMENTS"
  fi
done

# 11. Verificar permissões de segurança
echo ""
echo "11. Verificando permissões de segurança..."
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  
  # Verificar se sudo* está configurado como ask
  if sed -n '2,/^---$/p' "$f" | grep -q '"sudo \*": ask'; then
    test_pass "$filename: sudo está configurado como ask"
  else
    test_fail "$filename: sudo não está configurado como ask"
  fi
  
  # Verificar se rm* está configurado como ask
  if sed -n '2,/^---$/p' "$f" | grep -q '"rm \*": ask'; then
    test_pass "$filename: rm está configurado como ask"
  else
    test_fail "$filename: rm não está configurado como ask"
  fi
done

# 12. Verificar se os agentes têm seção de responsabilidades
echo ""
echo "12. Verificando seções obrigatórias nos prompts..."
for f in "$AGENTS_DIR"/*.md; do
  if [ ! -f "$f" ]; then
    continue
  fi
  
  filename=$(basename "$f")
  
  # Verificar se tem seção de responsabilidades ou competências
  if grep -q "## Responsabilidades\|## Competências" "$f" 2>/dev/null; then
    test_pass "$filename: tem seção de responsabilidades/competências"
  else
    test_fail "$filename: não tem seção de responsabilidades/competências"
  fi
  
  # Verificar se tem seção de estilo de trabalho
  if grep -q "## Estilo de trabalho" "$f" 2>/dev/null; then
    test_pass "$filename: tem seção de estilo de trabalho"
  else
    test_fail "$filename: não tem seção de estilo de trabalho"
  fi
done

# Resumo
echo ""
echo "=== Resumo dos Testes ==="
echo "Total de testes: $TESTS"
echo -e "Passaram: ${GREEN}$((TESTS - ERRORS))${NC}"
echo -e "Falharam: ${RED}$ERRORS${NC}"

if [ $ERRORS -eq 0 ]; then
  echo -e "\n${GREEN}Todos os testes passaram!${NC}"
  exit 0
else
  echo -e "\n${RED}Alguns testes falharam. Corrija os erros acima.${NC}"
  exit 1
fi