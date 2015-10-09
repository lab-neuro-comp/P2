# PROTOLIZE! 2

O PROTOLIZE! é uma ferramenta escrita em MATLAB para processamento de sinais de caráter biológico. Inicialmente [feito](http://repositorio.unb.br/bitstream/10482/4213/1/2009_SergioAndresCondeOcazionez.pdf) pelo professor [Sergio Ocazionez](http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K4245801A8), que hoje se encontra no [Instituto do Cérebro da Universidade Federal do Rio Grande do Norte](http://www.neuro.ufrn.br/incerebro/), durante sua tese de mestrado na Universidade de Brasília, ele está sendo trabalhado no Laboratório de Neurociências e Comportamento da Universidade de Brasília.

Pré-requisitos
--------------

--- Checar pré-requisitos ---

Instalação
----------

Para fazer o download do PROTOLIZE!2, baixe o arquivo `P2.zip` e extraia seu conteudo em um pasta específica. Inicie o MATLAB e vá à pasta onde você extraiu a sua versão do PROTOLIZE!2. Dentro desta pasta, entre o comando <span style="background-color: #BDC3CE">`protolize2`</span>. Se não houver nenhum problema, o menu principal do PROTOLIZE!2 aparecerá, indicando que ele está pronto para uso. 


Menu principal
==============

O menu principal contém 3 divisões: [`Protocols`](#protocols), [`Edition`](#edition) e [`Analysis`](#analysis). A partir delas, podemos acessar as diversas funcionalidades do PROTOLIZE!2 como descritas em suas respectivas sessões. 

Além disso, há uma [barra de ferramentas](#toolbar) para acesso rápido de diversos ajustes do programa e do arquivo de ajuda.

<a name="toolbar"></a>

Barra de ferramentas
--------------------

No topo da janela principal, temos uma barra de ferramentas com as opções `File`, `Settings` e `Help`. 

Em `File`, pode-se sair do programa ou do módulo; ou abrir ou salvar arquivos de acordo com o módulo que está sendo usado.

Em `Settings`, pode-se alterar diversos valores usados na análise de sinais, em especial a taxa de amostragem (chamada de `fs`); e os ritmos mentais usados no estudo em questão. O software sempre abre com os seguintes valores para os ritmos:

+ Delta: 0.5 a 3.5Hz
+ Theta: 3.5 a 7Hz
+ Alpha: 8 a 13Hz
+ Beta: 15 a 24Hz
+ Gamma: 30 a 70Hz

Estes valores podem ser ajustados de acordo com a necessidade do usuário, e todos os parâmetros disponíveis para ajuste ficam guardados até o fim da sessão do programa.

Em `Help`, tem-se acesso a este arquivo de ajuda que você está lendo.


<a name="protocols"></a>

Protocolos
==========

Por enquanto, temos 2 protocolos disponíveis: o TSST e o REFLEX.

<a name="edition"></a>

Módulos de edição
=================

Para podermos visualizar e editar visualmente o sinal, há as ferramentas `Time/Spec` e `DWT`.

<a name="analysis"></a>

Módulos de análise
==================

O PROTOLIZE!2 possui 4 ferramentas de análise de dados: análise no domínio do tempo (`Time domain`); análise por transformada de Fourier (`Fourier`); por transforma de Fourier de curta duração (`STFT`); e por transformada contínua de Wavelets (`CWT`).