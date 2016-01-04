# PROTOLIZE! como um todo

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
- [x] Identicar a funcionalidade da opção Transfer Function em P2
  + Aparentemente, não há esta função.
- [ ] Padronizar interface dos módulos
- [x] Colocar a definição da taxa de amostragem como entrada de dados
- [ ] Otimizar edição (mais de um arquivo por vez quando possível)
  + Requer que todos os módulos estejam prontos para que possamos decidir como padronizar esta interface.
- [ ] Tornar persistente a escolha das frequências dos ritmos de EEG e de amostragem.

# Módulos em particular

- [x] Time domain
  - [x] Abrir arquivo
  - [x] Consertar conversão do sinal usando a equação `(s+fa)*fb+fc`
  - [ ] Criar opção de desfazer o que foi feito
  - [ ] Testar filtros
  - [x] Criar opções de filtro
  - [x] Criar opção de corte
- [ ] DWT
  + Vamos deixar este módulo para depois.
  - [x] Decompor sinal
  - [ ] Mostrar decomposições do sinal
  - [ ] Criar ferramentas de edição
  - [ ] Mostrar reconstrução do sinal
- [x] Time/Spec
  - [x] Identicar funcionalidades.
  - [x] Criar ferramentas para cortar o sinal
  - [x] Criar ferramentas para gerar estatísticas do sinal
  - [x] Gerar figura do sinal
  - [x] Exportar estatística do sinal	  
- [x] Fourier
  + O módulo original não funciona.
  - [x] Estudar como o MATLAB lida com a transformada de Fourier.
  - [x] Decidir onde calcular a transformada de Fourier do sinal.
  - [x] Estudar como plotar várias funções em um mesmo gráfico usando cores diferentes.
  - [x] Descobrir como fazer o módulo escolher somente uma janela para a   transformada.
  - [x] Aplicar a transformada de Fourier usando a janela selecionada.
  - [ ] Checar se a aplicação da transformada é correta.
  - [x] Gerar estatísticas do sinal.
  - [x] Salvar estatísticas do espectro.
  - [x] Salvar figura do espectro.
  - [ ] Trocar o texto que mostra qual janela está selecionada por um menu popup.
- [ ] STFT
  - [ ] Checar funcionalidades
  - [ ] Descobrir como plotar um gráfico 3D
    + Existem várias funções do matlab para isso. Precisamos definir qual delas usar.
  - [x] Implementar opções para escolher somente uma janela para aplicação da transformada.
- [ ] CWT
  - [ ] Checar funcionalidades

# Documentação

- [ ] Escrever documentação
  - [x] Escrever introdução
  - [ ] Checar pré-requisitos
  - [ ] Escrever sobre protocolos
  - [ ] Escrever sobre módulos de edição
    - [x] Time/Spec
      - [x] Gerar imagem do módulo
    - [ ] DWT
  - [ ] Escrever sobre módulos de análise
    - [x] Time domain
      - [x] Tirar screencap do módulo
    - [ ] Fourier
    - [ ] STFT
    - [ ] CWT
  - [ ] Traduzir documentação para o inglês
- [ ] Comentar código
