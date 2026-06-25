# Comandos e Diretrizes de Comportamento para IA

Repositório com curadoria de comandos universais para LLMs e diretrizes comportamentais para agentes de IA.

**Objetivo:** oferecer um conjunto testado e consistente de comandos (70+) que funcionam em qualquer modelo moderno (GPT-4, Claude, Gemini, Llama, Mistral), além de diretrizes de sistema para tornar agentes de IA mais responsáveis, diretos e úteis.

---

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| [`Comandos/Comandos.md`](Comandos/Comandos.md) | Catálogo de comandos (`/ghost`, `OODA`, `TABLE`, `/debug`, `PARETO`, etc.). Cada comando tem propósito, exemplo e formato de uso. Funciona em qualquer LLM moderno. |
| [`Diretrizes/Diretrizes.md`](Diretrizes/Diretrizes.md) | 13 regras de comportamento para IA: sem preâmbulo, anti-bajulação, verificação de fatos, confiança calibrada, recuo estratégico. Use como prompt de sistema. |
| [`Tuning.md`](Tuning.md) | Guia de tuning e implantação do Ollama com GPU NVIDIA: configuração do serviço systemd, Modelfile com diretrizes, parâmetros de VRAM, script de criação de modelos customizados e troubleshooting. |
| [`IA_Local.md`](IA_Local.md) | Tutorial técnico para engenheiros implantarem um stack completo de inferência de IA totalmente local no Linux, sem dependências de APIs externas. O sistema utiliza Ollama como motor de inferência, Open-WebUI como interface web e OpenCode para assistência de código. |

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
