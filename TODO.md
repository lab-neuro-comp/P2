- [x] Colocar menu do P1 no P2: "Arquivo | Ajuda"
- [x] Adicionar menu "Configuração"
- [x] Manter Sample Frequency no menu "Configuração" em P2, renomeando para "Definir Taxa de Amostragem"
- [x] Ativar em P2: "Configurar Ritmo" e "Configurar parâmetros" no menu "Configuração"
  - [x] Adicionar "Configurar ritmos"
  - [x] Adicionar "Configurar parâmetros"
- [ ] Ativar funções dos botões do painel
  + Requer que todos os módulos estejam prontos.
- [ ] Adicionar menu "Protocolo | Edição | Análise", ativar mesmas funções do painel
  + Requer que todos os módulos estejam prontos.
- [x] Verificar mensagens de erros ao abrir TSST
  + Este módulo não existe no P2
- [x] Verificar quais módulos já foram tratados quanto ao uso de strings
  + Somente os módulos Fourier e (o novo) ECG foram aparentemente tratados com relação ao uso de reflexão, será necessário reescrever todos os outros módulos para que se encaixem no novo padrão.
- [ ] Reescrever módulos
  - [x] Time/Spec
    - [x] Consertar conversão do sinal usando a equação `(s+fa)*fb+fc`
    - [x] Criar opção de corte
	  - [x] Criar opções de filtro
	  - [ ] Testar filtros
    - [ ] Criar opção de desfazer o que foi feito
  - [ ] DWT
    - [x] Abrir arquivo
    - [x] Decompor sinal
    - [ ] Mostrar decomposições do sinal
    - [ ] Criar ferramentas de edição
	  - [ ] Mostrar reconstrução do sinal
	  + Vamos deixar este módulo para depois.
	  + Ele é muito complexo!
  - [ ] Time domain
    - [x] Criar ferramentas para gerar estatísticas do sinal
	  - [x] Criar ferramentas para cortar o sinal
	  - [x] Exportar estatística do sinal
	  - [ ] Gerar figura do sinal
	  + Decisão de design: mostrar sinal ao selecioná-lo no eixo?
  - [ ] STFT
  - [ ] CWT
- [x] Colocar a definição da taxa de amostragem como entrada de dados
- [x] Identicar a funcionalidade da opção Transfer Function em P2
- [ ] Padronizar interface dos módulos
  + Requer que todos os módulos estejam prontos para que possamos decidir como padronizar esta interface.
- [ ] Otimizar edição (mais de um arquivo por vez quando possível)
- [ ] Escrever documentação
  - [x] Escrever introdução
  - [ ] Checar pré-requisitos
  - [ ] Escrever sobre protocolos
  - [ ] Escrever sobre módulos de edição
    - [x] Time/Spec
      - [ ] Gerar imagem do módulo
    - [ ] DWT
  - [ ] Escrever sobre módulos de análise
    - [x] Time domain
      - [ ] Tirar screencap do módulo
    - [ ] Fourier
    - [ ] STFT
    - [ ] CWT
  - [ ] Traduzir documentação para o inglês
- [ ] Comentar código
