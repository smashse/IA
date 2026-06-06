# Documentação de comandos universais para LLM

Todos os comandos funcionam em qualquer modelo moderno (GPT-4, Claude, Gemini, Llama, Mistral). Escreva o comando no início ou no final do seu pedido. Exemplo:  
`/ghost Explique a fotossíntese`

A barra indica comandos de estilo; comandos em maiúsculas sem barra (ex.: `OODA`, `PARETO`) são usados da mesma forma – o modelo entende pelo nome.

---

## Escrita e estilo

### `/ghost`

Remove marcas comuns de IA (transições óbvias, advérbios de ênfase, frases muito equilibradas). O resultado soa humano e direto.  
**Exemplo**: “A mudança climática é um fenômeno complexo que afeta diversos ecossistemas.” → “Mudança climática bagunça ecossistemas. E nós ajudamos.”

### `/mirror`

Imita o estilo de um texto de exemplo que você fornece (tom, comprimento de frase, vocabulário). Forneça o exemplo junto ou antes do comando.  
**Exemplo**: Forneça um parágrafo de Machado de Assis. `/mirror Escreva um bilhete de desculpas` → frase irônica, subtexto, vocabulário culto.

### `/raw`

Remove toda formatação (negrito, listas, cabeçalhos, emojis). Entrega apenas texto corrido.  
**Exemplo**: `/raw Três tipos de células sanguíneas` → resposta em plain text puro.

### `/voice`

Fixa um tom específico (sarcástico, técnico, entusiasmado, sombrio) e mantém na conversa.  
**Exemplo**: `/voice cético` → “Você tem certeza? Mostre os dados.”

### `/punch`

Reescreve frase por frase para tornar cada uma mais curta, mais forte. Remove “muito”, “talvez”, “parece”, voz passiva.  
**Exemplo**: “Talvez seja uma boa ideia considerar começar mais cedo.” → “Comece mais cedo.”

### `/flow`

Reorganiza frases e parágrafos para progressão lógica suave, adiciona conectivos.  
**Exemplo**: Texto com saltos lógicos → ordenação com “portanto”, “no entanto”, “em seguida”.

### `/trim`

Corta palavras, frases ou exemplos redundantes sem perder informação essencial.  
**Exemplo**: “Cada e todo dia, ele caminhava aproximadamente uns 10 minutos.” → “Todos os dias ele caminhava 10 minutos.”

### `/hook`

Reescreve apenas a primeira linha para criar curiosidade, urgência ou contraste.  
**Exemplo**: Texto começa com “A seguir, dicas de economia” → “Você está jogando dinheiro fora sem saber.”

### `/rephrase`

Diz a mesma ideia com estrutura, vocabulário e ordem completamente diferentes.  
**Exemplo**: “O gato subiu no telhado porque viu um pássaro.” → “Ao avistar um pássaro, o felino escalou o telhado.”

### `/polish`

Corrige gramática, escolha de palavras, ritmo e pontuação, mantendo conteúdo intacto.  
**Exemplo**: “ele foi na loja e compro leite” → “Ele foi à loja e comprou leite.”

---

## Formatação e saída

### `TLDR`

Resume o conteúdo em uma ou duas frases.  
**Exemplo**: `TLDR` de um artigo de 10 páginas → “O estudo conclui que cochilos de 30 minutos melhoram memória em 15%.”

### `BULLETS`

Formata a resposta como lista pontuada.  
**Exemplo**: `BULLETS Benefícios do exercício` → • Melhora o sono • Reduz estresse • Aumenta disposição

### `TABLE`

Formata a resposta como tabela (markdown) para facilitar comparações.  
**Exemplo**: `TABLE Compare Python e JavaScript` → | Critério | Python | JavaScript | | Uso | Dados, back-end | Front-end, web |

### `CHECKLIST`

Converte a resposta em uma lista de itens verificáveis (feito/não feito).  
**Exemplo**: `CHECKLIST Preparar viagem` → [ ] Passaporte [ ] Visto [ ] Vacinas

### `STEPS`

Organiza a resposta em um processo passo a passo numerado.  
**Exemplo**: `STEPS Trocar um pneu` → 1. Parar o carro em local seguro. 2. Colocar o triângulo. 3. Soltar os parafusos…

### `/outline`

Estrutura o conteúdo em um outline hierárquico (títulos e subtítulos).  
**Exemplo**: `/outline Como construir um site` → 1. Planejamento 1.1 Público-alvo 1.2 Conteúdo 2. Design…

### `/summary`

Resumo conciso em um parágrafo (até 5 frases).  
**Exemplo**: `/summary` de uma reunião → “Decidimos adiar o lançamento para maio por falta de testes. O time de marketing ajustará a campanha.”

### `/keypoints`

Destaca apenas os aprendizados mais importantes, sem contexto adicional.  
**Exemplo**: `/keypoints Lições de um livro de finanças` → • Gaste menos do que ganha • Invista cedo • Evite dívida de consumo

---

## Pensamento e raciocínio

### `OODA`

Analisa um problema em quatro etapas: Observar (fatos), Orientar (interpretação), Decidir (opção), Agir (próximo passo).  
**Exemplo**: “Concorrente baixou preço 20%.” → Observa: preço caiu. Orienta: ele quer market share. Decide: não igualar, oferecer valor adicional. Age: lançar upgrade gratuito.

### `/deepthink`

Lista 3 a 5 camadas de análise (superficial, sistêmica, temporal, segunda ordem) antes de responder.  
**Exemplo**: “Devo contratar um vendedor?” → Camada 1: preciso de mais vendas. Camada 2: equipe atual sobrecarregada? Camada 3: retorno sobre investimento. → Resposta final.

### `L99`

Força a resposta mais profunda possível: cada alegação com justificativa, contraponto e evidência. Pode gerar textos longos – use com moderação.  
**Exemplo**: `L99 Por que a produtividade caiu nos serviços dos EUA?` → dados macro, teorias concorrentes, críticas, estudos citados.

### `CHAINLOGIC`

Mostra o raciocínio passo a passo enumerado, cada passo derivado do anterior.  
**Exemplo**: `CHAINLOGIC Prove 0.999... = 1` → 1. 1/3 = 0.333… 2. Multiplique por 3: 1 = 0.999…

### `/blindspots` (comando unificado, movido para Análise – veja seção Análise e estratégia)

### `OVERTHINK`

Analisa com detalhe excessivo: casos extremos, exceções raras, interpretações alternativas.  
**Exemplo**: `OVERTHINK Abrir cafeteria` → inclui análise de greve de transportes, infestação de formigas, fluxo de caixa para dias chuvosos.

### `/unpack`

Divide um conceito amplo em todos os seus subcomponentes.  
**Exemplo**: `/unpack sustentabilidade` → ambiental (emissões, água), econômica (longevidade), social (trabalho), cultural (tradições).

### `INVERT`

Resolve o problema ao contrário: “o que garantiria o fracasso?” – então evita essas ações.  
**Exemplo**: `INVERT Relacionamento duradouro` → O que destrói? Mentir, desprezo. Faça o oposto: honestidade, respeito.

### `/layered`

Entrega três versões: básica (definição), intermediária (mecanismos), avançada (limites, controvérsias).  
**Exemplo**: `/layered Transformer (IA)` → Básico: lê texto todo de uma vez. Intermediário: atenção multi-head. Avançado: limitação O(n²).

### `XRAY`

Vai além do óbvio – explicita estrutura oculta (premissas, poder, incentivos).  
**Exemplo**: `XRAY Plano de saúde não aceito` → Estrutura oculta: o plano concentra segurados; o hospital usa recusa como alavanca para renegociar.

---

## Aprendizado e domínio

### `/teachme`

Estrutura a resposta como microaula: objetivo, explicação, exemplo, exercício (opcional), resumo.  
**Exemplo**: `/teachme Fotossíntese` → Objetivo: entender conversão de luz em energia. Explicação: clorofila captura fótons. Exemplo: folha ao sol. Resumo: luz+água+CO2 → glicose+O2.

### `GAPFINDER`

Pergunta seu nível atual e identifica lacunas específicas.  
**Exemplo**: `GAPFINDER Cálculo` → “Onde você está em limites, derivadas?” → “Você domina limites mas não a regra da cadeia. Sua lacuna é derivada de funções compostas.”

### `/eli5`

Explica com palavras comuns, analogias simples, sem jargão.  
**Exemplo**: `/eli5 Buraco negro` → “Imagine um ralo no espaço: tudo que chega perto cai e não sai, nem a luz.”

### `MASTERCLASS`

Explica como especialista topo: nuances, contra‑exemplos, erros comuns, heurísticas.  
**Exemplo**: `MASTERCLASS Precificação de opções` → além de Black-Scholes: falhas, superfície de volatilidade, gregas, risco de cauda.

### `/drill`

Cria exercícios práticos (múltipla escolha, lacuna, correção) com gabarito e explicação.  
**Exemplo**: `/drill Verbos irregulares em inglês` → 5 frases com lacunas para passado simples, respostas e explicação.

### `SPEEDRUN`

Mostra o caminho mais curto para entender algo – o que pular, ordem ideal.  
**Exemplo**: `SPEEDRUN Machine learning` → Pule estatística avançada; comece com overfitting, árvores, ensembles; prática Kaggle após 3 horas.

### `/mentor`

Responde como mentor: dá conselhos e pergunta para guiar. Não resolve, ensina a resolver.  
**Exemplo**: “Minha equipe não me respeita.” `/mentor` → “Por que você acha? Já perguntou? Antes de sugerir mudanças, faça 1:1. O que já tentou?”

### `LEVELUP`

Descobre seu nível com 1-2 perguntas e ensina apenas o próximo degrau.  
**Exemplo**: `LEVELUP Python` → “Sabe listas e dicionários?” Sim → “Próximo degrau: list comprehensions. Exemplo e exercício.”

### `CRASHCOURSE`

Entrega essencial em 5-7 pontos densos, sem história ou exemplos longos.  
**Exemplo**: `CRASHCOURSE Guerra Fria` → 1. Cortina de ferro 1945 2. Doutrina Truman 3. Corrida armamentista 4. Detente 5. Queda do muro.

### `BOOTCAMP`

Gera plano completo de aprendizado com módulos, carga horária, exercícios, critérios de progressão.  
**Exemplo**: `BOOTCAMP Ciência de dados em 6 semanas` → Semana 1: Python+pandas (10h), Semana 2: análise exploratória… projeto final na semana 6.

---

## Análise e estratégia

### `/redteam`

Ataca sua ideia como adversário: falhas lógicas, riscos, contra‑argumentos.  
**Exemplo**: `/redteam “Nossa IA é melhor, vamos crescer”` → “A vantagem é sustentável? Concorrentes copiam em 3 meses? Cliente percebe diferença?”

### `PARETO`

Identifica os 20% de ações que geram 80% dos resultados.  
**Exemplo**: `PARETO Reduzir tempo de carregamento` → 1. Imagens (45% tempo) 2. APIs lentas (30%). Foque nesses.

### `/swot`

Gera matriz completa de Forças, Fraquezas, Oportunidades, Ameaças.  
**Exemplo**: `/swot Cafeteria especializada` → Forças: local, grãos. Fraquezas: capital baixo. Oportunidades: home office. Ameaças: Starbucks próximo.

### `WARGAME`

Simula reações em turnos: ação minha → reação deles → contra‑reação minha.  
**Exemplo**: `WARGAME Empresa A baixa preço 10%` → A baixa. B ignora. C combina baixa+frete grátis. A responde com clube de descontos.

### `/premortem`

Assume que seu plano falhou e lista as 3-5 razões mais prováveis.  
**Exemplo**: `/premortem Lançar CRM em 2 meses` → 1. Dados corrompidos. 2. Time não treinado. 3. Integração quebrada.

### `LEVERAGE`

Encontra a única ação de alto retorno que desbloqueia várias outras.  
**Exemplo**: `LEVERAGE Aumentar produtividade do time` → Alavanca: reduzir reuniões para uma por semana. Libera 10h por pessoa.

### `/audit`

Revisa trabalho apontando erros, inconsistências, omissões – não melhora, apenas acha problemas.  
**Exemplo**: `/audit Contrato` → “Cláusula 3 não define prazo. Cláusula 7 sem multa.”

### `BOTTLENECK`

Identifica a etapa mais lenta em um processo (teoria das restrições).  
**Exemplo**: `BOTTLENECK Aprovação de artigos` → Etapas: escrita, revisão, aprovação ética (15 dias), formatação. Gargalo = aprovação ética.

### `/scenario`

Projeta 3-4 cenários (otimista, pessimista, mais provável, disruptivo) com gatilhos.  
**Exemplo**: `/scenario Preço petróleo 2 anos` → Otimista US$90 (fim da guerra), Pessimista US$150 (conflito no Golfo), Provável US$75.

### `BLINDSPOT`

Mostra riscos não óbvios: segunda ordem, incentivos perversos, assimetria de informação.  
**Exemplo**: `BLINDSPOT Bônus por paciente atendido` → Médicos podem priorizar casos fáceis, sacrificando qualidade. Incentivo perverso.

### `/assumptions`

Lista suposições não declaradas em uma ideia ou plano.  
**Exemplo**: `/assumptions “Vamos crescer com marketing digital”` → Suposições: público-alvo está online, orçamento é suficiente, concorrência não reage.

### `/counter`

Gera o contra-argumento mais forte contra uma posição.  
**Exemplo**: `/counter “Trabalho remoto reduz produtividade”` → “Estudos mostram aumento de 13% na produtividade devido a menos interrupções.”

### `/devilsadvocate`

Questiona sua ideia defendendo o lado contrário, mesmo que você não acredite nele.  
**Exemplo**: “Vamos lançar sem teste.” `/devilsadvocate` → “E se o produto tiver um bug crítico que queime a marca?”

### `RISKMAP`

Lista riscos por probabilidade (alta/média/baixa) e impacto.  
**Exemplo**: `RISKMAP Novo produto` → Alta prob. x alto impacto: concorrente lança antes. Baixa prob. x alto impacto: fornecedor única falir.

### `SECONDORDER`

Traça consequências de segunda e terceira ordem.  
**Exemplo**: `SECONDORDER Baixar preço do produto` → 1ª: mais vendas. 2ª: concorrentes baixam também, guerra de preços. 3ª: margem de todos encolhe.

### `DECIDE`

Cria matriz de decisão com critérios e pesos. Você fornece opções e critérios.  
**Exemplo**: `DECIDE Opções: carro novo, usado, alugado. Critérios: custo, confiabilidade, status` → tabela com pontuação.

### `DELTR`

Quebra problema, avalia, aplica limites, transforma, reconstrói.  
**Exemplo**: `DELTR Reduzir custos` → Quebrar em áreas; avaliar cada; limites de redução; transformar processos; reconstruir orçamento.

### `KILLCRITIC`

Crítica agressiva focada exclusivamente em falhas e pontos fracos.  
**Exemplo**: `KILLCRITIC Plano de marketing` → “Orçamento irreal, público mal definido, canais sem métricas, prazo impossível.”

### `PARADOX`

Encontra contradições internas ou tensões em uma ideia.  
**Exemplo**: `PARADOX “Mais eficiência reduz custos”` → Eficiência extrema pode reduzir resiliência, aumentando custo de falhas.

### `LENSSTACK`

Analisa um tema por múltiplas lentes (econômica, ética, sistêmica, temporal).  
**Exemplo**: `LENSSTACK Desemprego tecnológico` → Econômica: realocação de trabalho. Ética: quem compensa os afetados? Sistêmica: educação defasada.

### `X10THINK`

Pede para pensar 10 vezes mais profundamente antes de responder. Similar ao `/deepthink`, mas foco em esforço, não em camadas.  
**Exemplo**: `X10THINK Como melhorar a retenção de clientes?` → resposta com análise exaustiva de dados, psicologia, concorrência, custos.

### `FRACTAL`

Analisa o mesmo padrão em diferentes escalas (micro, meso, macro).  
**Exemplo**: `FRACTAL Cultura organizacional` → Micro: reuniões diárias. Meso: estrutura de times. Macro: valores da empresa.

### `BLACKSWAN`

Foca em eventos raros de alto impacto.  
**Exemplo**: `BLACKSWAN Investimentos` → “Que evento improvável destruiria seu portfólio? E se protegendo?”

### `REVERSEENGINEER`

Infere mecanismo ou design a partir do resultado final.  
**Exemplo**: `REVERSEENGINEER Sucesso de um concorrente` → “Eles têm menor preço, mas não lucro. Provavelmente usam subsídio cruzado com outro produto.”

### `SIGNALVSNOISE`

Separa informações úteis de distrações.  
**Exemplo**: `SIGNALVSNOISE Relatório de vendas` → “A variação semanal é ruído; a tendência trimestral de queda de 5% é sinal.”

### `HYPOTHESISGEN`

Gera múltiplas hipóteses para explicar uma observação.  
**Exemplo**: `HYPOTHESISGEN Tráfego do site caiu 20%` → Hipóteses: atualização de algoritmo Google, link quebrado, concorrente lançou campanha.

### `SYSTEMMAP`

Mapeia atores, variáveis e relações causais dentro de um sistema.  
**Exemplo**: `SYSTEMMAP Trânsito em São Paulo` → Atores: motoristas, ônibus, prefeitura. Variáveis: frota, horário, obras. Relações: mais carros → mais lentidão → mais frustração → mais carros.

### `META`

Analisa o enquadramento da própria pergunta, não o conteúdo.  
**Exemplo**: “Qual o melhor carro?” `META` → “A pergunta assume que ‘melhor’ é universal. Mas depende de orçamento, uso, prioridade. Reformule com critérios.”

---

## Criatividade e conteúdo

### `/viral`

Reescreve conteúdo adicionando elementos de compartilhamento: emoção, valor prático, identidade, formato de lista.  
**Exemplo**: “Dicas para economizar energia” → “Minha conta caiu 40% com essas 5 mudanças (a última é irritante).”

### `HOOKS10`

Gera dez aberturas diferentes, cada uma com mecanismo distinto.  
**Exemplo**: `HOOKS10 Aprender inglês` → 1. “Levei 10 anos – não cometa meus erros.” 2. “90% dos cursos mentem.” etc.

### `/storysell`

Transforma mensagem em narrativa: personagem, conflito, jornada, resolução.  
**Exemplo**: `/storysell Organizador de cabos` → “João perdia 15 min todo dia com fones. Pagou R$3 num clip. Agora chega mais cedo ao trabalho. Esse clip é o organizador X.”

### `REMIX`

Mistura dois conceitos não relacionados para gerar híbridos.  
**Exemplo**: `REMIX Netflix + sushi` → “Sushi-by-Mail”: caixa mensal com rolos inspirados em filmes.

### `/angles`

Oferece dez abordagens diferentes para o mesmo tema.  
**Exemplo**: `/angles Produtividade` → Histórica (monges copistas), controversa (superestimada), pessoal (meu burnout), prática (timer 52-17), humorística etc.

### `CLIFFHANGER`

Reescreve o final para interromper no ponto de maior tensão.  
**Exemplo**: Texto sobre investigação: “Descobrimos o mordomo.” → “Apontei a lanterna para o canto escuro. E ali estava…”

### `/captionme`

Cria legendas para redes sociais com gatilhos de engajamento.  
**Exemplo**: `/captionme Pôr do sol` → “Se você trocaria isso por 1h de reunião → curte.”

### `POLARIZE`

Assume posição forte sem ponderação, gerando concordância ou discordância clara.  
**Exemplo**: `POLARIZE Trabalho remoto` → “Home office é o único jeito. Quem quer voltar ao escritório tem saudade do cafezinho, não da produtividade.”

### `/banger`

Transforma frase fraca em memorável: metáfora, paralelismo, exagero.  
**Exemplo**: “Nosso software é rápido.” → “Enquanto você pisca, ele entrega.”

### `THUMBNAIL`

Cria título ou chamada para cliques: urgência, curiosidade, promessa concreta.  
**Exemplo**: `THUMBNAIL Trocar pneu` → “PARE. Você está trocando o pneu do jeito errado (e pode morrer).”

### `/simulate`

Simula um cenário, conversa ou role-play com regras explícitas.  
**Exemplo**: `/simulate Entrevista de emprego para vaga de desenvolvedor` → modelo faz perguntas como entrevistador.

### `/predict`

Projeta resultados futuros com base nas informações atuais.  
**Exemplo**: `/predict Preço do aluguel em SP nos próximos 2 anos` → “Com inflação e falta de oferta, alta de 15% ao ano.”

### `/futurehistory`

Descreve o futuro como se já fosse passado, estilo historiador.  
**Exemplo**: `/futurehistory Carros autônomos em 2040` → “Em 2028, a primeira morte por autonomia chocou o mundo, mas em 2032 já era raro.”

### `/reverse`

Começa descrevendo o fracasso e trabalha de trás para frente até a causa.  
**Exemplo**: `/reverse Projeto atrasou` → “Entregamos com 3 meses de atraso. Por quê? O back-end começou tarde porque a especificação mudou.”

### `SCRIPT`

Formata a resposta como roteiro de vídeo ou diálogo.  
**Exemplo**: `SCRIPT Cena de um café` → [INTERIOR. CAFÉ. JOÃO e MARIA.] JOÃO: “Você está bem?” MARIA: “Não.”

### `THREAD`

Formata como thread de rede social (ex.: Twitter), com numeração.  
**Exemplo**: `THREAD Explicar blockchain` → “1/8 Imagine um livro razão compartilhado… 2/8 Cada página tem um selo único…”

### `/storymode`

Muda para estilo narrativo com enredo, personagem, conflito.  
**Exemplo**: `/storymode Como eu aprendi a investir` → narrativa pessoal com obstáculos e superação.

---

## Código e técnico

### `/debug`

Aponta bugs prováveis, explica a causa e sugere correção.  
**Exemplo**: Loop que para antes do esperado → “Na linha 7, você usou `<` em vez de `<=`, o último elemento não é processado.”

### `REFACTOR`

Reescreve código para melhorar legibilidade e manutenção sem mudar comportamento.  
**Exemplo**: Script repetitivo → extrai funções, renomeia variáveis, remove duplicação.

### `/shipit`

Pega código bruto e aplica boas práticas de produção: tratamento de erro, logging, configuração externalizada.  
**Exemplo**: Código que lê arquivo sem `try-except` → adiciona tratamento, logs, parametrização.

### `ARCHITECT`

Desenha estrutura de alto nível: componentes, interfaces, fluxos, dependências.  
**Exemplo**: `ARCHITECT Microsserviço de notificações` → API gateway, worker com fila, adaptadores (email/SMS), banco de status.

### `/convert`

Traduz código de uma linguagem para outra, preservando lógica.  
**Exemplo**: Python → Rust: `sum(list)` vira `iter().sum()`.

### `AUTOMATE`

Gera script que automatiza um processo manual descrito em linguagem natural.  
**Exemplo**: “Baixar PDFs, renomear pela data de modificação, mover por ano” → script Python com `os`, `datetime`, `shutil`.

### `/testit`

Escreve testes unitários ou de integração (pytest, JUnit, Mocha). Inclui casos normais, borda e erro.  
**Exemplo**: Função `divide(a,b)` → testes com `b=0`, negativos, floats.

### `SCAFFOLD`

Gera estrutura de diretórios e arquivos iniciais de um projeto.  
**Exemplo**: `SCAFFOLD CLI em Go com cobra` → `cmd/root.go`, `main.go`, `go.mod`, `Makefile`.

### `/optimize`

Melhora performance (tempo ou memória) sem quebrar funcionalidade. Pode trocar algoritmo ou memoizar.  
**Exemplo**: Fibonacci recursivo → iterativo com DP: O(2ⁿ) → O(n).

### `APIBUILD`

Cria API completa (endpoints, schemas, roteamento, validação) a partir de descrição.  
**Exemplo**: `APIBUILD Tarefas: POST /tarefas, GET /:id, DELETE /:id, autenticação token` → gera Express ou FastAPI com modelos e middleware.

### `GENERATOR` (novo, do Claude)

Cria uma ferramenta reutilizável que gera resultados sob demanda conforme parâmetros que você definir.  
**Exemplo**: `GENERATOR Gerador de nomes para personagens de fantasia` → “Forneça: gênero, primeira letra opcional, origem (élfica, anã). Ex.: masculino, ‘A’, élfico → ‘Aerendir’.”

---

## Comandos poderosos

### `/godmode`

Resposta extremamente longa e detalhada, com seções, exemplos, contra‑exemplos, referências.  
**Exemplo**: `/godmode Falácia do custo afundado` → 2000 palavras com origem, exemplos (projetos de TI, relacionamentos), papers, exercícios.

### `/autoprompt`

Transforma sua instrução vaga em um prompt estruturado. Se faltarem informações críticas, pergunta em vez de inventar.  
**Exemplo**: “me ajuda a vender mais” → `/autoprompt` → “Qual seu produto, ticket médio, ciclo de venda?” Após resposta, gera prompt completo.

### `MEGAPROMPT`

Gera um prompt longo (500+ palavras) com papel, contexto, formato, exemplos, restrições, verificações.  
**Exemplo**: `MEGAPROMPT Artigo sobre sustentabilidade para adolescentes` → prompt pronto: persona jovem, tom energético, 600 palavras, obrigatório: meme, estatística chocante, call to action.

### `/chain`

Executa vários prompts em sequência, cada resultado vira entrada do próximo.  
**Exemplo**: `/chain` “1. Gere 10 ideias para curso online. 2. Escolha as 3 melhores. 3. Para cada, syllabus de 5 módulos.”

### `/system`

Escreve um prompt de sistema completo para guiar o comportamento do modelo.  
**Exemplo**: `/system Você é um tradutor técnico inglês-português. Mantenha jargão. Não traduza nomes próprios. Marque ambiguidades com [sic].`

### `PERSONA`

Responde como um tipo específico de especialista.  
**Exemplo**: `PERSONA cirurgião torácico` → “Explique o pulmão” → “O pulmão é uma esponja ventilada por 23 gerações de brônquios. Qualquer perfuração colapsa o tecido.”

### `/memory`

Pede para reter explicitamente um fato ou preferência durante a conversa.  
**Exemplo**: `/memory Meu nome é João, sou vegetariano.` → respostas futuras dirão “João” e evitarão carne.

### `CONTEXT`

Carrega informações de fundo fornecidas por você e usa apenas elas (ignora conhecimento geral).  
**Exemplo**: `CONTEXT` + anexo relatório 2024 → “Com base APENAS neste relatório, qual foi o melhor trimestre?”

### `/rolelock`

Mantém um papel específico (cético, otimista, advogado de defesa) por toda a conversa.  
**Exemplo**: `/rolelock cético` → todas as respostas começam com “Você tem certeza?”

### `PROMPTFIX`

Pega um prompt com problemas (vago, contraditório) e entrega versão corrigida, explicando mudanças.  
**Exemplo**: “me fala sobre história mas não muito longa e com detalhes” → “Explique a queda do Império Romano em 3 parágrafos (causas econômicas, políticas, militares), máximo 300 palavras.”

---

## Modos ocultos

### `/nofilter`

Pede opinião direta, sem eufemismos, sem “depende”.  
**Exemplo**: `/nofilter Esse candidato é bom?` → “Não. Ele mentiu no currículo.”

### `BEASTMODE`

Eleva qualidade ao máximo: exige fontes, cita raciocínio, verifica consistência.  
**Exemplo**: `BEASTMODE Viés de confirmação` → definição operacional, experimentos (Wason 1960), meta‑análise, crítica de replicação.

### `/therapist`

Escuta e reflete com perguntas abertas; não dá conselhos não solicitados.  
**Exemplo**: “Estou sobrecarregado.” `/therapist` → “Essa sobrecarga é constante ou tem dias específicos? O que pesa mais?”

### `CEOMODE`

Responde como CEO: trade-offs explícitos, priorização agressiva, foco em resultado financeiro.  
**Exemplo**: `CEOMODE Marketing ou produto?` → “Produto. Se o produto não retém, marketing queima dinheiro.”

### `/negotiate`

Escreve roteiro de negociação: abertura (âncora), BATNA, concessões, objeções, fechamento.  
**Exemplo**: `/negotiate Comprar carro de R$50k por R$40k` → Abertura: “Meu orçamento é R$35k.” BATNA: outro carro. Concessões: subo até R$42k com garantia.

### `FOUNDER`

Conselhos de startup: product-market fit, tração, captação, execução enxuta.  
**Exemplo**: `FOUNDER “Devo contratar vendedor com 10 clientes?”` → “Não. Faça você as primeiras 50 vendas para entender o funil.”

### `/closer`

Copy de vendas com escassez, autoridade, prova social, urgência e call to action.  
**Exemplo**: `/closer Curso de finanças` → “Restam 11 vagas com 40% off. 499 pessoas compraram hoje. Último dia.”

### `OPERATOR`

Executa tarefa de ponta a ponta pedindo apenas informações críticas mínimas.  
**Exemplo**: `OPERATOR Configure servidor Ubuntu com Nginx e SSL` → pergunta “Qual o domínio?” e devolve script bash completo.

### `/unlocked`

Resposta menos genérica e mais específica, com exemplos concretos e números.  
**Exemplo**: `/unlocked Erros em pitch decks` → “1. TAM não calculado. 2. Projeção 10x ano 1 sem base. 3. Time sem biografia real. Exemplo: startup X…”

### `SENTINEL`

Revisa conteúdo em busca de erros fáticos, lógicos, de segurança, omissões críticas.  
**Exemplo**: `SENTINEL Manual de segurança` → “Página 3: ‘desligue a chave geral’ sem luvas isolantes. Risco de choque.”

---

## Comandos de aprendizado e estudo adicionais

### `QUIZME`

Cria perguntas de quiz (múltipla escolha, verdadeiro/falso) com base no material fornecido.  
**Exemplo**: `QUIZME` sobre um capítulo → 5 perguntas, gabarito no final.

### `FEYNMAN`

Explica de forma simples, com analogias e sem jargão, como Richard Feynman.  
**Exemplo**: `FEYNMAN O que é eletricidade?` → “É como água num cano: tensão é pressão, corrente é vazão.”

### `FLASHCARDS`

Transforma material em cartões de estudo (pergunta → resposta).  
**Exemplo**: `FLASHCARDS Verbos irregulares` → “Go → went → gone”

### `MISCONCEPTIONS`

Lista erros comuns sobre o tema e os corrige explicitamente.  
**Exemplo**: `MISCONCEPTIONS Evolução` → “Erro: evolução melhora espécies. Correto: ela apenas favorece adaptação ao ambiente.”

### `TESTME`

Faz perguntas sem dar respostas; espera você responder para depois corrigir.  
**Exemplo**: `TESTME Estrutura atômica` → “Quantos prótons tem o carbono?” (você responde, ele corrige.)

### `TIMELINE`

Organiza eventos em ordem cronológica com datas.  
**Exemplo**: `TIMELINE Segunda Guerra Mundial` → 1939 invasão da Polônia; 1941 Pearl Harbor; 1945 rendição.

### `SOCRATIC` ou `/socratic`

Ensina fazendo perguntas guiadas que levam você à resposta.  
**Exemplo**: `SOCRATIC Por que o céu é azul?` → “Por que a luz espalha mais em comprimentos curtos? Como a dispersão depende do ângulo?”

---

## Comandos de brainstorming e ideias

### `IDEAS10`

Gera rapidamente dez ideias sobre um tema.  
**Exemplo**: `IDEAS10 Reduzir plástico no escritório` → 10 itens diretos: canecas reutilizáveis, bebedouro, canetas recarregáveis…

### `SCAMPER`

Aplica os sete gatilhos criativos: Substituir, Combinar, Adaptar, Modificar, Usar para outro fim, Eliminar, Reverter.  
**Exemplo**: `SCAMPER Cadeira` → Substituir madeira por bambu; Combinar com tomada USB; Adaptar para escritório; Eliminar encosto.

### `ALT3`

Entrega três alternativas ou versões diferentes.  
**Exemplo**: `ALT3 Abrir um e-mail de vendas` → versão curta, versão detalhada com storytelling, versão com pergunta provocativa.

### `/brainstorm100`

Pede uma lista grande de ideias (20-100), com queda de qualidade aceitável.  
**Exemplo**: `/brainstorm100 Nomes para um blog de tecnologia` → lista extensa, algumas boas, outras engraçadas.

### `HOOK10` (ou `HOOKS10` – já documentado em Criatividade)

### `/viralhooks` (similar a `/viral`, mas focado apenas em hooks)

Gera hooks pensados para viralização.  
**Exemplo**: `/viralhooks Conteúdo de finanças` → “Os 3 hábitos que mantêm pobre (o segundo vai te irritar)”

### `IDEAGEN`

Versão menos estruturada de brainstorming, com variedade de direções.  
**Exemplo**: `IDEAGEN Melhorar o atendimento ao cliente` → desde chatbots até cartões escritos à mão.

---

## Comandos de utilidade geral

### `/breakdown`

Divide um tema complexo em partes menores.  
**Exemplo**: `/breakdown Mudança climática` → causas (CO2, desmatamento), efeitos (temperatura, clima extremo), soluções (energia limpa, reflorestamento).

### `/translate`

Traduz texto para outro idioma.  
**Exemplo**: `/translate “Good morning” para português` → “Bom dia”

### `/stepbystep`

Força resposta sequencial, um passo por vez.  
**Exemplo**: `/stepbystep Como fazer um bolo` → 1. Pré-aqueça o forno. 2. Misture secos. 3. Adicione líquidos. 4. Asse.

### `/stonechange`

Muda o tom emocional ou estilístico da escrita.  
**Exemplo**: `/stonechange De neutro para urgente` → “Precisamos discutir isso” → “Urgente: precisamos discutir isso agora.”

### `/insights`

Extrai padrões ou observações não óbvias de um texto.  
**Exemplo**: `/insights Relatório de vendas` → “As vendas caem sempre na última semana do mês – provavelmente por orçamento esgotado.”

### `/examples`

Adiciona exemplos concretos a uma explicação.  
**Exemplo**: `/examples O que é viés de confirmação` → “Exemplo: você acredita que um político é corrupto e só lê notícias que confirmam isso.”

### `/clarify`

Remove ambiguidades pedindo ou inferindo contexto (prefere perguntar).  
**Exemplo**: `/clarify “O banco caiu”` → “Você se refere a instituição financeira ou assento de parque?”

### `/usecases`

Lista aplicações práticas de uma ideia ou tecnologia.  
**Exemplo**: `/usecases Blockchain` → criptomoedas, rastreamento de cadeia de suprimentos, votação eletrônica, contratos inteligentes.

### `/expandideas`

Pega uma ideia bruta e a desenvolve em mais detalhes e implicações.  
**Exemplo**: “App para encontrar estacionamento” → `/expandideas` → funcionalidades: reserva, pagamento, comparador de preços, histórico.

### `/improvehooks`

Refina hooks existentes para torná-los mais fortes.  
**Exemplo**: “Aprenda inglês rápido” → `/improvehooks` → “Aprenda inglês em 30 dias (o método que escolas escondem).”

### `/compress`

Enxuga texto com perda controlada de detalhe, mantendo mensagem principal.  
**Exemplo**: Parágrafo de 100 palavras → 30 palavras com ideia central.

### `/systemrewrite`

Reescreve texto de forma estruturada e sistematizada (ex.: método → resultado → conclusão).  
**Exemplo**: `/systemrewrite` um e-mail bagunçado → transforma em tópicos claros.

### `/reframe`

Apresenta a mesma ideia por outro ângulo.  
**Exemplo**: “Problema: atraso nas entregas” → `/reframe` → “Oportunidade: reduzir lead time e aumentar satisfação.”

### `/coach`

Responde como coach: pergunta, desafia, apoia, não resolve por você.  
**Exemplo**: “Não consigo cumprir prazos.” `/coach` → “O que te impede exatamente? Como você organiza seu dia? Já tentou algo diferente?”

### `/critique` (comando unificado, movido para Análise)

Analisa trabalho e aponta melhorias específicas.  
**Exemplo**: `/critique E-mail de vendas` → “O call to action está no terceiro parágrafo – suba para o primeiro. Tom está passivo.”

---

## Considerações finais

- Todos os comandos foram validados em GPT-4, Claude 3, Gemini 1.5, Llama 3 e Mistral Large.
- A barra é apenas um marcador visual; o modelo entende o comando pelo nome.
- Comandos em maiúsculas sem barra (ex.: `OODA`, `PARETO`) funcionam igualmente bem.
- Para evitar ambiguidade, prefira escrever o comando no início da mensagem.
