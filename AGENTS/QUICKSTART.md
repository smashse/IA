# Quick Start — Squad de Agentes

## Instalação

```bash
cd ~/Workspace/AGENTS
bash install.sh
```

Reinicie o opencode.

## Uso Básico

```bash
opencode                          # Inicia com tech-lead
/agent backend                    # Backend Developer
/agent frontend                   # Frontend Developer
/agent devops                     # DevOps/SRE
/agent qa                         # QA Engineer
/agent security                   # Security Engineer
```

## Comandos

```bash
/code-review src/                 # Revisão de código completa
/launch-feature nome-da-feature   # Nova feature full-stack
/incident descrição               # Resposta a incidente
/perf-audit componente            # Auditoria de performance
/security-audit componente        # Auditoria de segurança
```

## Skills

```bash
# Carregar skill manualmente
/security-scanning                # SAST, secrets, dependências
/test-strategy                    # Pirâmide de testes, cobertura
/deployment-patterns              # Docker, K8s, Helm, ArgoCD
/incident-runbook                 # RCA, postmortem
```

> Skills são carregadas automaticamente pelos agents conforme necessário.
