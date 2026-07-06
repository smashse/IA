# Comandos e Diretrizes de Comportamento para IA

Repositório com curadoria de comandos universais para LLMs e diretrizes comportamentais para agentes de IA.

**Objetivo:** oferecer um conjunto testado e consistente de comandos (70+) que funcionam em qualquer modelo moderno (GPT-4, Claude, Gemini, Llama, Mistral), além de diretrizes de sistema para tornar agentes de IA mais responsáveis, diretos e úteis.

---

## Arquivos

| Arquivo                                                | Descrição                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`Comandos/Comandos.md`](Comandos/Comandos.md)         | Catálogo de comandos (`/ghost`, `OODA`, `TABLE`, `/debug`, `PARETO`, etc.). Cada comando tem propósito, exemplo e formato de uso. Funciona em qualquer LLM moderno.                                                                                                                                                                                                                                                        |
| [`Diretrizes/Diretrizes.md`](Diretrizes/Diretrizes.md) | 13 regras de comportamento para IA: sem preâmbulo, anti-bajulação, verificação de fatos, confiança calibrada, recuo estratégico. Use como prompt de sistema.                                                                                                                                                                                                                                                               |
| [`Tuning.md`](Tuning.md)                               | Guia de tuning e implantação do Ollama com GPU NVIDIA: configuração do serviço systemd, Modelfile com diretrizes, parâmetros de VRAM, script de criação de modelos customizados e troubleshooting.                                                                                                                                                                                                                         |
| [`IA_Local.md`](IA_Local.md)                           | Tutorial técnico para engenheiros implantarem um stack completo de inferência de IA totalmente local no Linux, sem dependências de APIs externas. O sistema utiliza Ollama como motor de inferência, Open-WebUI como interface web e OpenCode para assistência de código.                                                                                                                                                  |
| [`AGENTS/`](AGENTS/)                                   | **Squad de Agentes com OpenCode** — Tutorial completo para criar, configurar e orquestrar uma squad de 6 agentes especializados (Tech Lead, Backend, Frontend, DevOps, QA, Security) usando OpenCode. Inclui 5 comandos de workflow (`/code-review`, `/launch-feature`, `/incident`, `/perf-audit`, `/security-audit`), 4 skills transversais, script de instalação automatizada e guia detalhado por cenário de hardware. |

---

## AGENTS — Squad de Agentes com OpenCode

Tutorial completo para criar, configurar e orquestrar uma **squad de 6 agentes especializados** (Tech Lead, Backend, Frontend, DevOps, QA, Security) usando OpenCode no Linux.

**Público-alvo:** Engenheiros e administradores de sistemas com familiaridade básica com shell Linux.

**Pré-requisitos:**

- OpenCode instalado e funcional
- Acesso ao terminal (bash/zsh)
- Um provedor de LLM configurado (Ollama local, API remota, etc.)

### Instalação rápida

```bash
cd AGENTS
bash install.sh
```

### Estrutura da squad

| Agente      | Papel                                                              | Modo       | Modelo padrão             |
| ----------- | ------------------------------------------------------------------ | ---------- | ------------------------- |
| `tech-lead` | Orquestrador central — arquitetura, code review, roadmap, mentoria | `primary`  | `ollama/llama3.2:8b`      |
| `backend`   | APIs, lógica de negócio, banco de dados, integrações               | `subagent` | `ollama/qwen2.5-coder:7b` |
| `frontend`  | UI/UX, componentes, state management, acessibilidade               | `subagent` | `ollama/qwen2.5-coder:7b` |
| `devops`    | Infraestrutura, CI/CD, monitoramento, incident response            | `subagent` | `ollama/llama3.2:8b`      |
| `qa`        | Estratégias de testes, automação, qualidade                        | `subagent` | `ollama/qwen2.5-coder:7b` |
| `security`  | Threat modeling, vulnerabilidades, compliance, hardening           | `subagent` | `ollama/llama3.2:8b`      |

### Comandos de workflow

| Comando                        | Descrição                                                                | Agentes envolvidos                                  |
| ------------------------------ | ------------------------------------------------------------------------ | --------------------------------------------------- |
| `/code-review <path>`          | Revisão completa de código (segurança, performance, testes, arquitetura) | Tech Lead → Security, QA, Backend, Frontend         |
| `/launch-feature <nome>`       | Nova feature full-stack end-to-end                                       | Tech Lead → Backend, Frontend, DevOps, Security, QA |
| `/incident <descrição>`        | Resposta a incidente + postmortem                                        | Tech Lead → DevOps, Security, Backend               |
| `/perf-audit <componente>`     | Auditoria de performance                                                 | Tech Lead → Backend, DevOps, QA                     |
| `/security-audit <componente>` | Auditoria de segurança                                                   | Tech Lead → Security, Backend, DevOps               |

### Skills transversais

| Skill                 | Descrição                                                       | Agentes que usam                 |
| --------------------- | --------------------------------------------------------------- | -------------------------------- |
| `security-scanning`   | SAST, detecção de secrets, auditoria de dependências, hardening | security, devops, qa, tech-lead  |
| `test-strategy`       | Pirâmide de testes, fixtures, cobertura, detecção de flaky      | qa, backend, frontend, tech-lead |
| `deployment-patterns` | Docker, K8s, Helm, ArgoCD, blue-green, canary                   | devops, backend, tech-lead       |
| `incident-runbook`    | RCA, timeline, comunicação, postmortem                          | tech-lead, devops, backend       |

### Como funciona a orquestração

```
Usuário digita no terminal
         │
         ▼
┌────────────────────────────┐
│       tech-lead            │  ← Agente primário (orquestrador)
│  Analisa → Delega →        │
│  Sintetiza resposta        │
└──┬────┬────┬────┬────┬─────┘
   │    │    │    │    │
   ▼    ▼    ▼    ▼    ▼
┌───┐┌───┐┌───┐┌───┐┌────┐
│BE ││FE ││D/O││QA ││SEC │  ← Subagentes (especialistas)
│   ││   ││   ││   ││    │
└───┘└───┘└───┘└───┘└────┘
 Back Front DevOps  QA  Segurança
 End  end
```

1. **Usuário** digita a solicitação
2. **Tech Lead** analisa quais domínios estão envolvidos
3. **Delegação paralela** para especialistas via `task` tool
4. **Síntese** dos resultados num plano coeso
5. **Resposta** consolidada ao usuário

### Modelos recomendados por cenário de hardware

| Cenário                                   | Tech Lead / DevOps / Security           | Backend / Frontend / QA     |
| ----------------------------------------- | --------------------------------------- | --------------------------- |
| **GPU 24 GB+** (ex: RTX 3090/4090, A6000) | `qwen3.5:27b` ou `qwen3-coder:30b`      | `qwen2.5-coder:14b`         |
| **GPU 16 GB** (ex: RTX 4080)              | `llama3.2:8b` ou `qwen3.5:27b` (q4_K_M) | `qwen2.5-coder:7b`          |
| **GPU 8–12 GB** (ex: RTX 3060 12GB)       | `llama3.2:8b` (q4_K_M)                  | `qwen2.5-coder:7b` (q4_K_M) |
| **CPU only / RAM 16–32 GB**               | `llama3.2:8b` (q4_K_M)                  | `qwen2.5-coder:7b` (q4_K_M) |
| **CPU only / RAM 8 GB**                   | `llama3.2:3b` ou `phi3:3.8b`            | `qwen2.5-coder:1.5b`        |

> **Dica:** Configure modelos diferentes por agente no `opencode.json` (campo `model` em cada agente) conforme seu hardware.

### Documentação completa

Consulte [`AGENTS/README.md`](AGENTS/README.md) para o tutorial detalhado com:

- Conceitos fundamentais (agentes, squads, orquestração)
- Estrutura de diretórios global e por projeto
- Anatomia completa de arquivos de agente
- Modos de operação (`primary`, `subagent`, `all`)
- Sistema de permissões granular
- Criação de agentes via CLI (6 blocos prontos para `cat`)
- Criação de comandos de workflow
- Skills transversais e como criar as suas
- Configuração do `opencode.json`
- Padrão orquestrador com exemplos de delegação
- Squad completa documentada
- Cenários práticos executáveis
- Referência completa e glossário
- Troubleshooting

---

## Começo rápido

**Usar comandos:** escreva no início ou fim do prompt

```
/ghost Explique fotossíntese
```

**Aplicar diretrizes:** cole `Diretrizes.md` como instrução de sistema da sua IA

---

## Exemplos

| Comando  | Entrada                                      | Saída                                     |
| -------- | -------------------------------------------- | ----------------------------------------- |
| `/ghost` | "A mudança climática é um fenômeno complexo" | "Mudança climática bagunça ecossistemas." |
| `PARETO` | "Reduzir tempo de carregamento"              | "Foco: imagens (45%) e APIs lentas (30%)" |
| `/eli5`  | "Buraco negro"                               | "Imagine um ralo no espaço..."            |

---

## Crédito

Comandos validados em GPT-4, Claude 3, Gemini 1.5, Llama 3 e Mistral Large.
