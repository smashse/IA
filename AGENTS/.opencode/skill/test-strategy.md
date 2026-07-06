---
description: Estratégia de testes, test pyramid, fixtures, cobertura, detecção de flaky tests
version: 1.0.0
---

# Skill: Test Strategy

Esta skill fornece procedimentos padronizados para criação, execução e manutenção de testes.

## Quando Usar

- Auditoria de testes (`/perf-audit`)
- Revisão de código (`/code-review`)
- Criação de novos testes
- Debug de testes flaky
- Configuração de CI/CD

## Pirâmide de Testes

```
        /  E2E  \        <- poucos, lentos, caros
       /----------\
      / Integração  \    <- médios,速度 moderate
     /--------------\
    /  Unitários     \  <- muitos, rápidos, baratos
   /------------------\
```

| Camada | Cobertura alvo | Execução | Custo |
|--------|----------------|----------|-------|
| **Unitários** | 80-90% | < 1s por teste | Baixo |
| **Integração** | 70-80% | < 5s por teste | Médio |
| **E2E** | 20-30% | < 30s por teste | Alto |

## Categorias de Teste

### Unitários
```bash
# Python (pytest)
pytest tests/unit/ -v --cov=src --cov-report=json
pytest tests/unit/test_auth.py::test_login_success -v

# Node.js (vitest/jest)
npx vitest run tests/unit/ --coverage
npx jest tests/unit/ --coverage

# Go
go test ./internal/... -v -coverprofile=coverage.out
```

### Integração
```bash
# Python
pytest tests/integration/ -v --timeout=30
pytest tests/integration/test_api.py -v -k "test_create_user"

# Node.js
npx vitest run tests/integration/ --timeout=30000

# Go
go test ./tests/integration/... -v -timeout=60s
```

### E2E
```bash
# Playwright
npx playwright test tests/e2e/ --reporter=json
npx playwright test tests/e2e/login.spec.ts --headed

# Cypress
npx cypress run --spec tests/e2e/login.cy.ts --reporter=json

# Selenium
python -m pytest tests/e2e/ -v --browser=chromium
```

## Fixtures e Dados de Teste

### Python (conftest.py)
```python
@pytest.fixture
def sample_user():
    return {"id": 1, "name": "Test User", "email": "test@example.com"}

@pytest.fixture
def db_session():
    session = SessionLocal()
    yield session
    session.close()

@pytest.fixture
def mock_redis(mocker):
    return mocker.patch("redis.Redis")
```

### Node.js
```typescript
// vitest setup
import { vi } from 'vitest';

// mocks
vi.mock('./database', () => ({
  query: vi.fn(),
}));

// fixtures
export const sampleUser = { id: 1, name: 'Test User', email: 'test@example.com' };
```

## Detecção de Flaky Tests

### Identificação
```bash
# Rodar testes 5x e contar falhas inconsistentes
for i in {1..5}; do
  pytest tests/ --json-report --json-report-file=run-$i.json 2>/dev/null
done
python scripts/analyze_flaky.py run-*.json
```

### Análise de Flaky
```python
# scripts/analyze_flaky.py
import json
from collections import defaultdict

def find_flaky(json_files):
    results = defaultdict(lambda: {"pass": 0, "fail": 0, "total": 0})
    for f in json_files:
        data = json.load(open(f))
        for test in data["tests"]:
            name = test["nodeid"]
            results[name]["total"] += 1
            if test["outcome"] == "passed":
                results[name]["pass"] += 1
            else:
                results[name]["fail"] += 1

    return {k: v for k, v in results.items() if 0 < v["fail"] < v["total"]}
```

### Prevenção
```yaml
# .github/workflows/test.yml
- name: Run tests (retry flaky)
  run: |
    pytest tests/ --flaky-reruns=2 --json-report
```

## Métricas de Cobertura

### Gerar Relatório
```bash
# Python
pytest --cov=src --cov-report=html --cov-report=json

# Node.js
npx vitest run --coverage

# Go
go test ./... -coverprofile=coverage.out
go tool cover -html=coverage.out -o coverage.html
```

### Thresholds Mínimos
```json
{
  "coverage": {
    "global": { "branches": 80, "functions": 85, "lines": 80, "statements": 80 },
    "per_file": { "minimum": 70 }
  }
}
```

## Integração com Agents

| Agent | Uso da Skill |
|-------|--------------|
| **qa** | Criar testes, manter fixtures, detectar flaky, reportar cobertura |
| **backend** | Testar APIs, mocks de integração, fixtures de banco |
| **frontend** | Testar componentes, mock de APIs, testes de acessibilidade |
| **security** | Testes de segurança (SAST/DAST), testes de autenticação |
| **tech-lead** | Definir padrões, revisar cobertura, priorizar correções |
| **devops** | Rodar testes em CI, gerar relatórios, fail-fast |

## Formato de Relatório

```json
{
  "timestamp": "2026-01-15T10:30:00Z",
  "summary": {
    "total": 150,
    "passed": 145,
    "failed": 3,
    "skipped": 2,
    "flaky": 1
  },
  "coverage": {
    "lines": 85.2,
    "branches": 78.5,
    "functions": 88.1,
    "statements": 84.9
  },
  "duration": "45.2s",
  "flaky_tests": ["tests/integration/test_api.py::test_concurrent"]
}
```