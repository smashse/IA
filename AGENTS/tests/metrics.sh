#!/bin/bash
# Sistema de coleta de métricas de uso dos agentes
# Uso: bash tests/metrics.sh [comando]

set -e

METRICS_DIR="$(dirname "$0")/../metrics"
METRICS_FILE="$METRICS_DIR/usage.json"
REPORT_FILE="$METRICS_DIR/report.md"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar ajuda
show_help() {
  echo -e "${BLUE}Sistema de Métricas dos Agentes${NC}"
  echo ""
  echo "Uso: $0 [comando]"
  echo ""
  echo "Comandos:"
  echo "  init          Inicializa o sistema de métricas"
  echo "  log           Registra uma chamada de agente"
  echo "  report        Gera relatório de uso"
  echo "  stats         Mostra estatísticas resumidas"
  echo "  reset         Reseta as métricas"
  echo "  help          Mostra esta ajuda"
  echo ""
  echo "Exemplos:"
  echo "  $0 init"
  echo "  $0 log tech-lead code-review 45"
  echo "  $0 report"
  echo "  $0 stats"
}

# Função para inicializar métricas
init_metrics() {
  mkdir -p "$METRICS_DIR"
  
  if [ ! -f "$METRICS_FILE" ]; then
    cat > "$METRICS_FILE" << 'EOF'
{
  "initialized": "",
  "total_calls": 0,
  "agents": {
    "tech-lead": { "calls": 0, "total_time": 0 },
    "backend": { "calls": 0, "total_time": 0 },
    "frontend": { "calls": 0, "total_time": 0 },
    "devops": { "calls": 0, "total_time": 0 },
    "qa": { "calls": 0, "total_time": 0 },
    "security": { "calls": 0, "total_time": 0 }
  },
  "commands": {
    "code-review": { "calls": 0, "total_time": 0 },
    "launch-feature": { "calls": 0, "total_time": 0 },
    "incident": { "calls": 0, "total_time": 0 },
    "perf-audit": { "calls": 0, "total_time": 0 },
    "security-audit": { "calls": 0, "total_time": 0 }
  },
  "history": []
}
EOF
    
    # Atualizar data de inicialização
    local temp_file=$(mktemp)
    python3 -c "
import json
from datetime import datetime

with open('$METRICS_FILE', 'r') as f:
    data = json.load(f)

data['initialized'] = datetime.now().isoformat()

with open('$METRICS_FILE', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
" 2>/dev/null
    
    echo -e "${GREEN}Sistema de métricas inicializado${NC}"
    echo -e "${YELLOW}Arquivo: $METRICS_FILE${NC}"
  else
    echo -e "${YELLOW}Sistema de métricas já inicializado${NC}"
  fi
}

# Função para registrar chamada
log_call() {
  local agent=$1
  local command=$2
  local duration=$3
  local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  
  if [ -z "$agent" ] || [ -z "$command" ] || [ -z "$duration" ]; then
    echo -e "${RED}Erro: Uso: $0 log <agente> <comando> <duração>${NC}"
    echo "Exemplo: $0 log tech-lead code-review 45"
    exit 1
  fi
  
  # Verificar se o arquivo existe
  if [ ! -f "$METRICS_FILE" ]; then
    init_metrics
  fi
  
  # Atualizar métricas
  python3 -c "
import json
from datetime import datetime

with open('$METRICS_FILE', 'r') as f:
    data = json.load(f)

# Atualizar totais
data['total_calls'] += 1

# Atualizar agente
if '$agent' in data['agents']:
    data['agents']['$agent']['calls'] += 1
    data['agents']['$agent']['total_time'] += $duration

# Atualizar comando
if '$command' in data['commands']:
    data['commands']['$command']['calls'] += 1
    data['commands']['$command']['total_time'] += $duration

# Adicionar ao histórico
entry = {
    'timestamp': '$timestamp',
    'agent': '$agent',
    'command': '$command',
    'duration': $duration
}
data['history'].append(entry)

# Manter apenas os últimos 1000 registros
if len(data['history']) > 1000:
    data['history'] = data['history'][-1000:]

with open('$METRICS_FILE', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
" 2>/dev/null
  
  echo -e "${GREEN}Chamada registrada${NC}"
  echo -e "  Agente: $agent"
  echo -e "  Comando: $command"
  echo -e "  Duração: ${duration}s"
  echo -e "  Timestamp: $timestamp"
}

# Função para gerar relatório
generate_report() {
  if [ ! -f "$METRICS_FILE" ]; then
    echo -e "${YELLOW}Nenhuma métrica encontrada. Execute '$0 init' primeiro.${NC}"
    return
  fi
  
  python3 -c "
import json
from datetime import datetime

with open('$METRICS_FILE', 'r') as f:
    data = json.load(f)

report = []
report.append('# Relatório de Uso dos Agentes')
report.append('')
report.append(f'**Inicializado em:** {data.get(\"initialized\", \"N/A\")}')
report.append(f'**Gerado em:** {datetime.now().isoformat()}')
report.append(f'**Total de chamadas:** {data.get(\"total_calls\", 0)}')
report.append('')

# Estatísticas por agente
report.append('## Uso por Agente')
report.append('')
report.append('| Agente | Chamadas | Tempo Total (s) | Média (s) |')
report.append('|--------|----------|-----------------|-----------|')

for agent, stats in data.get('agents', {}).items():
    calls = stats.get('calls', 0)
    total_time = stats.get('total_time', 0)
    avg_time = total_time / calls if calls > 0 else 0
    report.append(f'| {agent} | {calls} | {total_time} | {avg_time:.1f} |')

report.append('')

# Estatísticas por comando
report.append('## Uso por Comando')
report.append('')
report.append('| Comando | Chamadas | Tempo Total (s) | Média (s) |')
report.append('|---------|----------|-----------------|-----------|')

for cmd, stats in data.get('commands', {}).items():
    calls = stats.get('calls', 0)
    total_time = stats.get('total_time', 0)
    avg_time = total_time / calls if calls > 0 else 0
    report.append(f'| {cmd} | {calls} | {total_time} | {avg_time:.1f} |')

report.append('')

# Últimas 10 chamadas
report.append('## Últimas Chamadas')
report.append('')
report.append('| Timestamp | Agente | Comando | Duração (s) |')
report.append('|-----------|--------|---------|-------------|')

history = data.get('history', [])[-10:]
for entry in reversed(history):
    report.append(f'| {entry.get(\"timestamp\", \"N/A\")} | {entry.get(\"agent\", \"N/A\")} | {entry.get(\"command\", \"N/A\")} | {entry.get(\"duration\", 0)} |')

report.append('')

# Salvar relatório
with open('$REPORT_FILE', 'w') as f:
    f.write('\n'.join(report))

print('Relatório gerado: $REPORT_FILE')
" 2>/dev/null
  
  echo -e "${GREEN}Relatório gerado: $REPORT_FILE${NC}"
}

# Função para mostrar estatísticas
show_stats() {
  if [ ! -f "$METRICS_FILE" ]; then
    echo -e "${YELLOW}Nenhuma métrica encontrada. Execute '$0 init' primeiro.${NC}"
    return
  fi
  
  python3 -c "
import json

with open('$METRICS_FILE', 'r') as f:
    data = json.load(f)

print('=== Estatísticas dos Agentes ===')
print()
print(f'Total de chamadas: {data.get(\"total_calls\", 0)}')
print()

# Top agentes
agents = data.get('agents', {})
sorted_agents = sorted(agents.items(), key=lambda x: x[1].get('calls', 0), reverse=True)

print('Top Agentes:')
for agent, stats in sorted_agents[:3]:
    calls = stats.get('calls', 0)
    if calls > 0:
        print(f'  {agent}: {calls} chamadas')

print()

# Top comandos
commands = data.get('commands', {})
sorted_commands = sorted(commands.items(), key=lambda x: x[1].get('calls', 0), reverse=True)

print('Top Comandos:')
for cmd, stats in sorted_commands[:3]:
    calls = stats.get('calls', 0)
    if calls > 0:
        print(f'  {cmd}: {calls} chamadas')
" 2>/dev/null
}

# Função para resetar métricas
reset_metrics() {
  if [ -f "$METRICS_FILE" ]; then
    rm "$METRICS_FILE"
    echo -e "${GREEN}Métricas resetadas${NC}"
  fi
  
  if [ -f "$REPORT_FILE" ]; then
    rm "$REPORT_FILE"
    echo -e "${GREEN}Relatório removido${NC}"
  fi
}

# Main
case "$1" in
  init)
    init_metrics
    ;;
  log)
    log_call "$2" "$3" "$4"
    ;;
  report)
    generate_report
    ;;
  stats)
    show_stats
    ;;
  reset)
    reset_metrics
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