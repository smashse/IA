---
description: Resposta a incidentes, triagem, contenção, erradicação, recuperação, postmortem.
agent: tech-lead
---

Resposta a incidente: $ARGUMENTS

Coordene os seguintes:
1. **devops**: triagem, dashboards de monitoramento, alertas, deploys recentes, saúde da infraestrutura
2. **security**: verificar se é relacionado a segurança, acesso não autorizado, logs suspeitos, IoCs
3. **backend**: diagnóstico da aplicação, logs de erro, stack traces, conectividade com banco, saúde de dependências
4. **qa**: verificação de regressão, isso foi pego por testes? Cobertura de testes faltante?

Após a resolução, produza um postmortem:
- Timeline (UTC)
- Impacto (usuários afetados, duração, severidade)
- Causa raiz
- O que deu certo / o que não deu
- Itens de ação com responsáveis e prazos
