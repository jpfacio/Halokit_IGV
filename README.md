#                                                                          ###############    HALOKIT_IGV   ################

                                                                                      Versão pre-alpha (ou sei la)

## Intuito e resumo

O Halokit IGV será um programa cujo objetivo é facilitar a navegação no IGV no que se relaciona às propriedades genômicas, proteômicas e metabolômicas de _Halobacterium salinarum_,
o programa terá uma versão standalone e outra versão acoplada à GUI do IGV, sua principal funcionalidade será converter intervalos de sequência de RNA em arquivos .ct e .db para que
sua estrutura secundária seja plotada no campo de visualização do IGV, facilitando o uso direto de análise, não precisando abrir outros programas. 

Já existem dois softwares que fazem esse trabalho, porém o diferencial do Halokit IGV será a possibilidade de salvar sessões automaticamente, escolher diretórios específicos, direcionar
gráficos e abrir sessões prévias, algo que ainda não tem nos programas já feitos. O output solicitado também terá um nível maior de personalização, ocultando ou permitindo parâmetros
matemáticos, escolha de cores e tamanhos de janelas. Na versão standalone o programa salvará os parâmetros escolhidos e redigira um xml que servirá como sessão salva para ser aberta 
no IGV, também serão gerados arquivos de batch script personalizados. Na versão acoplada o programa será editado em tempo real. A intenção é que o programa seja usado em conjunto com
o IGV, fechando e abrindo sessões a partir de um único kit de comandos.

O programa usará bibliotecas prévias de análises de estrutura secundária de RNA, como ViennaRNA, RNAStructure e RNAfold, a diferença do estado da arte, essas três serão colocadas em 
análise e (se possível >.<) comparadas. Funcionalidades futuras incluem comunicação com APIs do Blast para facilitar o acesso a sequenciamentos de proteínas e comparações com outras
espécies, uso da API do AlphaFold para trazer estruturas terciárias de proteínas e buscador de genes com salvamento automático e informações de fácil acesso.

## Conversor de estrutura secundária

Esse programa terá seus scripts de manipulação de formatos e uso de bibliotecas escritos em Bash, sua interface gráfica escrita em Python e seu acoplamento no IGV em Java
(Estudar engenharia e arquitetura de software).

Lógica principal (precisa de mais especialidade)

Para o standalone:

1 - Abrir um executável escrito em Python que consiste em uma GUI e direcionamentos a outros scripts e loads de bibliotecas, interação usuário-programa.

2 - Será solicitado dois tipos de input (a princípio), ou um fragmento de sequência desejada ou um intervalo de posição desejada

Ex.: "ACGAGTGCGATTGCTAGGGCTAG" ou "826722-826788"

3a - Se o input for uma str de sequência o programa irá, a partir da (a princípio) biblioteca bedtools, encontrar um match do input em um .fa de sequenciamento bruto, que estará
no banco de dados do software (a princípio para NRC-1) (precisa ver se dá pra usar o mesmo algoritmo para outras sequências brutas de Halo, assim da pra abrir upload do usuario).

3b - Se o input for um intervalo numérico o programa irá, em uma pipeline, salvar um .bed temporário e encontrar o match no .fa

4 - O programa solicitará a abertura de uma sessão no IGV e salvamento.

5 - Com o diretório selecionado vai começar a diversão, o programa vai pegar a sequência match e jogar nas bibliotecas de modelagem, o resultado pode vir em formatos .db, .ct 
e não lembro mas tinha outros. Esses formatos serão convertidos ao formato lido pelo IGV (nao lembro a extensão). Cada posição será traduzida em uma string de intervalo que
será somada a depender do número total de input, será preciso escrever um algoritmo de tradução.

6 - Após a tradução, o algoritmo vai começar a escrever um .xml, com parametros de sessão previo para Halo (contendo o .fa e o .gff) e será abertas (a escolha do usuário) três
tracks com cada um dos programas, com nomes e cores pré-especificados (no passo 4).

7 - O usuário terá a opção de adicionar mais análises nessa mesma sessão, que atualizará o arquivo traduzido e o xml de sessão, ou poderá criar uma sessão nova.

8 - Após a análise completa o programa irá acionar um batch com comandos para abrir o IGV e a sessão automaticamente.

## Requisitos

Vai precisar ter instalado o bedtools, o biopython e o IGV, o programa vai procurar no computador a existência desses caras.

## Funcionalidades futuras


 
  


