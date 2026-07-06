---
description: Varredura de vulnerabilidades, SAST, detecção de secrets, auditoria de dependências
version: 1.0.0
---

# Skill: Security Scanning

Esta skill fornece procedimentos padronizados para varredura de segurança de código e infraestrutura.

## Quando Usar

- Auditoria de segurança (`/security-audit`)
- Revisão de código (`/code-review`)
- Pipeline CI/CD (devops)
- Verificação pré-deploy

## Ferramentas Suportadas

| Categoria | Ferramentas | Uso |
|-----------|-------------|-----|
| **SAST** | semgrep, bandit, eslint-plugin-security, gosec | Análise estática de código |
| **Secrets** | gitleaks, trufflehog, detect-secrets | Detecção de credenciais vazadas |
| **Dependências** | trivy, grype, snyk, dependabot | Vulnerabilidades em deps |
| **Container** | trivy, grype, dockle | Hardening de imagens Docker |
| **IaC** | checkov, tfsec, kics | Terraform, K8s, CloudFormation |

## Procedimentos

### 1. Varredura Completa de Código (SAST + Secrets)

```bash
# SAST multi-linguagem
semgrep scan --config=auto --json=semgrep-results.json .

# Secrets (histórico git + working dir)
gitleaks detect --source=. --verbose --report-format=json --report-path=gitleaks-results.json
trufflehog filesystem . --json --output=trufflehog-results.json
```

### 2. Auditoria de Dependências

```bash
# Python
pip-audit --format=json --output=pip-audit-results.json
safety check --json --output=safety-results.json

# Node.js
npm audit --json > npm-audit-results.json
# ou
yarn audit --json > yarn-audit-results.json

# Go
govulncheck ./... > govulncheck-results.txt

# Container
trivy image --format=json --output=trivy-image-results.json <imagem>
grype <imagem> -o json > grype-results.json
```

### 3. Verificação de IaC

```bash
# Terraform
checkov -d ./terraform --format=json --output=checkov-results.json
tfsec ./terraform --format=json --out=tfsec-results.json

# Kubernetes
kics scan -p ./k8s --report-formats=json --output-path=kics-results.json
```

## Formato de Relatório Unificado

```json
{
  "scan_id": "sec-scan-2026-01-15-001",
  "timestamp": "2026-01-15T10:30:00Z",
  "target": "repo/path",
  "tools": {
    "sast": { "tool": "semgrep", "findings": 12, "critical": 2, "high": 5, "medium": 3, "low": 2 },
    "secrets": { "tool": "gitleaks", "findings": 3, "critical": 1, "high": 2 },
    "deps": { "tool": "trivy", "findings": 8, "critical": 0, "high": 3, "medium": 5 },
    "iac": { "tool": "checkov", "findings": 5, "high": 2, "medium": 3 }
  },
  "summary": { "total": 28, "critical": 3, "high": 10, "medium": 11, "low": 4 }
}
```

## Classificação de Severidade

| Severidade | Ação | SLA |
|------------|------|-----|
| **Crítico** | Bloquear deploy, corrigir imediatamente | < 24h |
| **Alto** | Corrigir antes do próximo release | < 7 dias |
| **Médio** | Agendar correção na sprint | < 30 dias |
| **Baixo** | Documentar, monitorar | Next sprint |

## Integração com Agents

```markdown
# No prompt do agent security:
/skill security-scanning

# No prompt do agent devops (pipeline):
- Carregar security-scanning
- Executar em etapa "security-scan" do pipeline
- Falhar build se critical/high > 0

# No prompt do agent tech-lead (/code-review):
- Delegar para security com skill security-scanning
- Incluir resultados no relatório unificado
```

## Configuração Recomendada

```yaml
# .security-scanning.yml
sast:
  enabled: true
  config: "auto"  # ou path para config custom
  exclude: ["vendor/", "node_modules/", "*.min.js"]

secrets:
  enabled: true
  baseline: ".gitleaks-baseline"  # allowlist conhecida

dependencies:
  enabled: true
  fail_on: "high"  # critical|high|medium
  ignore_unfixed: false

iac:
  enabled: true
  frameworks: ["terraform", "kubernetes", "docker", "cloudformation"]
```