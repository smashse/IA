---
description: Padrões de deploy, Docker, Kubernetes, Helm, ArgoCD, blue-green, canary
version: 1.0.0
---

# Skill: Deployment Patterns

Esta skill fornece procedimentos padronizados para deploy de aplicações em diferentes ambientes.

## Quando Usar

- Lançamento de feature (`/launch-feature`)
- Incidente de deploy (`/incident`)
- Auditoria de performance (`/perf-audit`)
- Configuração de CI/CD (devops)

## Padrões de Deploy

### 1. Blue-Green Deploy

```yaml
# k8s/blue-green.yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp
    slot: active  # alterne entre active/preview
  ports:
    - port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-active
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      slot: active
  template:
    metadata:
      labels:
        app: myapp
        slot: active
    spec:
      containers:
        - name: myapp
          image: myapp:v1.0.0
```

**Procedimento:**
1. Deploy versão nova em `preview`
2. Testar `preview` (smoke tests)
3. Trocar service para `preview` (torna-se `active`)
4. Manter `active` antiga como rollback

### 2. Canary Deploy

```yaml
# k8s/canary.yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: myapp
spec:
  hosts:
    - myapp.example.com
  http:
    - route:
        - destination:
            host: myapp
            subset: stable
          weight: 90
        - destination:
            host: myapp
            subset: canary
          weight: 10
```

**Procedimento:**
1. Deploy canary com 5-10% do tráfego
2. Monitorar métricas (latência, erros)
3. Se OK, aumentar peso gradualmente
4. Se erro, reverter automaticamente

### 3. Rolling Update

```yaml
# k8s/rolling.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 4
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    spec:
      containers:
        - name: myapp
          image: myapp:v2.0.0
```

## Docker

### Dockerfile Multi-Stage
```dockerfile
# Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Production
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 8080
CMD ["node", "dist/main.js"]
```

### Compose para Desenvolvimento
```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "8080:8080"
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db
      - redis

  db:
    image: postgres:16
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - pgdata:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  pgdata:
```

## Kubernetes

### Health Checks
```yaml
containers:
  - name: myapp
    image: myapp:v1.0.0
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 10
      failureThreshold: 3
    readinessProbe:
      httpGet:
        path: /readyz
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
    startupProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 5
      failureThreshold: 30
```

### Resource Limits
```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"
```

### Autoscaling
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
```

## Helm

### Chart Structure
```
charts/myapp/
  Chart.yaml
  values.yaml
  values-staging.yaml
  values-production.yaml
  templates/
    deployment.yaml
    service.yaml
    ingress.yaml
    hpa.yaml
    configmap.yaml
    secret.yaml
```

### Values
```yaml
# values.yaml
replicaCount: 2
image:
  repository: myapp
  tag: "latest"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 512Mi

autoscaling:
  enabled: false
  minReplicas: 2
  maxReplicas: 10
```

## ArgoCD

### Application
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/org/myapp.git
    targetRevision: HEAD
    path: charts/myapp
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

## CI/CD Pipeline (GitHub Actions)

```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/build-push-action@v5
        with:
          push: true
          tags: myapp:${{ github.sha }}

  deploy-staging:
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - run: helm upgrade --install myapp ./charts/myapp -f values-staging.yaml

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      - run: helm upgrade --install myapp ./charts/myapp -f values-production.yaml
```

## Rollback

```bash
# Helm rollback
helm rollback myapp <revision>

# Kubernetes rollout
kubectl rollout undo deployment/myapp
kubectl rollout undo deployment/myapp --to-revision=3

# ArgoCD sync forçado
argocd app sync myapp --force
```

## Integração com Agents

| Agent | Uso da Skill |
|-------|--------------|
| **devops** | Criar pipelines, configurar K8s, gerenciar ArgoCD |
| **backend** | Criar Dockerfiles, health checks, resource limits |
| **tech-lead** | Definir padrões de deploy, revisar configurações |
| **qa** | Rodar smoke tests pós-deploy, validar canary |
| **security** | Verificar imagens, secrets, network policies |