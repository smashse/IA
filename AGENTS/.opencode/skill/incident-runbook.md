---
description: Resposta a incidentes, RCA, timeline, comunicação, template de postmortem
version: 1.0.0
---

# Skill: Incident Runbook

Esta skill fornece procedimentos padronizados para resposta a incidentes, análise de causa raiz e documentação.

## Quando Usar

- Incidente em produção (`/incident`)
- Alertas de monitoramento
- Downtime de serviço
- Performance degradada
- Violação de segurança

## Classificação de Incidentes

| Severidade | Impacto | Tempo de Resposta | Exemplo |
|------------|---------|-------------------|---------|
| **SEV1** | Serviço principal down | < 5 min | API indisponível, banco de dados down |
| **SEV2** | Funcionalidade crítica degradada | < 15 min | Login lento, checkout falhando |
| **SEV3** | Funcionalidade não-crítica afetada | < 1 hora | Dashboard lento, relatório com erro |
| **SEV4** | Impacto cosmético/menor | < 4 horas | Bug visual, tooltip errado |

## Fluxo de Resposta

### 1. Detectar e Classificar
```
[SEV1/SEV2] Imediato
├── Confirmar alerta (não é falso positivo?)
├── Classificar severidade
├── Abrir canal de comunicação (#incident-YYYY-MM-DD)
└── Notificar stakeholders

[SEV3/SEV4] Batch
├── Coletar dados
├── Classificar
└── Criar ticket
```

### 2. Mitigar (Stop the Bleeding)
```bash
# Rollback rápido
kubectl rollout undo deployment/<service>
helm rollback <release> <revision>

# Escalar
kubectl scale deployment/<service> --replicas=10

# Feature flag (desabilitar feature problemática)
curl -X POST http://featureflags/api/disable -d '{"feature":"new-checkout"}'

# DNS failover
# Alterar registros DNS para LB secundário

# Circuit breaker
# Ativar circuit breaker para serviço problemático
```

### 3. Diagnosticar
```bash
# Logs
kubectl logs -l app=<service> --tail=1000 --since=1h
journalctl -u <service> --since "1 hour ago"

# Métricas
curl -s http://prometheus:9090/api/v1/query?query=rate(http_requests_total{service="<service>"}[5m])

# Topologia
kubectl get pods -o wide
kubectl get services
kubectl get ingress

# Recursos
kubectl top pods
kubectl top nodes

# Eventos
kubectl get events --sort-by=.metadata.creationTimestamp
```

### 4. Resolver
```bash
# Deploy fix
git commit -m "fix: <descrição do fix>"
git push origin main

# Aguardar CI/CD
# ou deploy manual
kubectl set image deployment/<service> <container>=<new-image>:<tag>

# Validar
curl -s http://<service>/healthz
kubectl get pods -l app=<service>
```

### 5. Verificar
```bash
# Smoke tests
curl -s http://<service>/api/health | jq .
# Verificar:
# - [ ] Serviço respondendo
# - [ ] Latência normal
# - [ ] Erros < 0.1%
# - [ ] Métricas estáveis
# - [ ] Alertas silenciados
```

## Timeline de Comunicação

### Para Internos (Slack/Teams)
```
🚨 INCIDENTE [SEV1] - API Principal Indisponível

⏱ Início: 14:30 UTC
📊 Status: Investigando
👤 Responsável: @tech-lead
📢 Próximo update: 14:45 UTC

Impacto: Todos os usuários não conseguem acessar a API
```

### Para Externos (Status Page)
```
[Investigando] API - Usuários reportando erros 500

Identificamos um problema com a API principal e estamos investigando.
Alguns usuários podem encontrar erros ao acessar o serviço.

Atualização em 15 minutos.
```

## Template de Postmortem

```markdown
# Postmortem: [Nome do Incidente]

## Resumo
- **Data**: YYYY-MM-DD
- **Duração**: X horas Y minutos
- **Severidade**: SEV1/SEV2/SEV3
- **Impacto**: [descrição do impacto aos usuários]
- **Serviço afetado**: [nome do serviço]

## Timeline (UTC)
| Hora | Evento |
|------|--------|
| 14:30 | Alerta disparado no PagerDuty |
| 14:35 | Engenheiro on-call confirmou problema |
| 14:40 | Canal #incident aberto |
| 14:45 | Causa identificada: deploy de feature X |
| 14:50 | Rollback iniciado |
| 15:00 | Rollback completo, serviço restaurado |
| 15:30 | Validação pós-incidente concluída |

## Causa Raiz
[Descrição detalhada do que causou o incidente]

## O que funcionou
- [Lista de coisas que funcionaram bem]

## O que não funcionou
- [Lista de problemas encontrados]

## Ações Corretivas
| # | Ação | Responsável | Prazo | Status |
|---|------|-------------|-------|--------|
| 1 | Adicionar health check mais rigoroso | @devops | 2026-01-20 | Pendente |
| 2 | Implementar circuit breaker | @backend | 2026-01-25 | Pendente |
| 3 | Adicionar testes de regressão | @qa | 2026-01-22 | Pendente |

## Lições Aprendidas
1. [Lição 1]
2. [Lição 2]
3. [Lição 3]

## Métricas
- **MTTD** (Mean Time to Detect): X minutos
- **MTTI** (Mean Time to Identify): X minutos
- **MTTR** (Mean Time to Resolve): X minutos
- **MTTC** (Mean Time to Communicate): X minutos
```

## Comandos Úteis

### Investigar Incidente
```bash
# Verificar pods problemáticos
kubectl get pods --field-selector=status.phase!=Running

# Verificar eventos recentes
kubectl get events --sort-by=.lastTimestamp --field-selector=type=Warning

# Verificar recursos
kubectl describe node <node-name> | grep -A 5 "Conditions:"

# Verificar logs de erro
kubectl logs -l app=<service> --tail=500 | grep -i "error\|exception\|fatal"
```

### Mitigar Incidente
```bash
# Restart de pod
kubectl delete pod <pod-name>

# Rollback
kubectl rollout undo deployment/<deployment>

# Escalar
kubectl scale deployment/<deployment> --replicas=<n>

# Port-forward para debug
kubectl port-forward svc/<service> 8080:80
```

## Runbooks por Tipo de Incidente

### Database Down
```bash
# 1. Verificar status
kubectl get pods -l app=postgres
kubectl logs -l app=postgres --tail=100

# 2. Verificar recursos
kubectl top pods -l app=postgres

# 3. Restart se necessário
kubectl delete pod -l app=postgres

# 4. Verificar replicação
kubectl exec -it postgres-0 -- pg_isready
```

### High Latency
```bash
# 1. Identificar slow queries
kubectl logs -l app=api | grep -i "slow query"

# 2. Verificar métricas
curl -s http://prometheus:9090/api/v1/query?query=histogram_quantile(0.99,rate(http_request_duration_seconds_bucket[5m]))

# 3. Escalar se necessário
kubectl scale deployment/api --replicas=10

# 4. Verificar cache
kubectl logs -l app=redis | grep -i "miss"
```

### Memory Leak
```bash
# 1. Verificar uso de memória
kubectl top pods -l app=<service>

# 2. Verificar limits
kubectl get pods -l app=<service> -o jsonpath='{.items[*].spec.containers[*].resources.limits.memory}'

# 3. OOMKilled?
kubectl get events --field-selector reason=OOMKilling

# 4. Reiniciar se necessário
kubectl rollout restart deployment/<service>
```

## Integração com Agents

| Agent | Uso da Skill |
|-------|--------------|
| **tech-lead** | Coordenar resposta, comunicar stakeholders, revisar postmortem |
| **devops** | Diagnosticar infra, executar mitigações, monitorar |
| **backend** | Diagnosticar código, implementar fixes, revisar logs |
| **qa** | Validar fix, rodar smoke tests, verificar regressões |
| **security** | Verificar se incidente envolve segurança, preservar evidências |
| **frontend** | Comunicar impacto UI, verificar feature flags |