# AI Commands & Behavior Guidelines

Repositório com curadoria de comandos universais para LLMs e diretrizes comportamentais para agentes de IA.

**Objetivo:** oferecer um conjunto testado e consistente de comandos (70+) que funcionam em qualquer modelo moderno (GPT-4, Claude, Gemini, Llama, Mistral), além de diretrizes de sistema para tornar agentes de IA mais responsáveis, diretos e úteis.

---

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| [`Comandos/Comandos.md`](Comandos/Comandos.md) | Catálogo de comandos (`/ghost`, `OODA`, `TABLE`, `/debug`, `PARETO`, etc.). Cada comando tem propósito, exemplo e formato de uso. Funciona em qualquer LLM moderno. |
| [`Diretrizes/Diretrizes.md`](Diretrizes/Diretrizes.md) | 13 regras de comportamento para IA: sem preâmbulo, anti-bajulação, verificação de fatos, confiança calibrada, recuo estratégico. Use como prompt de sistema. |

---

## Começo rápido

**Usar comandos:** escreva no início ou fim do prompt
```
/ghost Explique fotossíntese
```

**Aplicar diretrizes:** cole `Diretrizes.md` como instrução de sistema da sua IA

---

## Exemplos

| Comando | Entrada | Saída |
|---------|---------|-------|
| `/ghost` | "A mudança climática é um fenômeno complexo" | "Mudança climática bagunça ecossistemas." |
| `PARETO` | "Reduzir tempo de carregamento" | "Foco: imagens (45%) e APIs lentas (30%)" |
| `/eli5` | "Buraco negro" | "Imagine um ralo no espaço..." |

---

## Crédito

Comandos validados em GPT-4, Claude 3, Gemini 1.5, Llama 3 e Mistral Large.
