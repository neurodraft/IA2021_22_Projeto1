 # Manual de Utilizador 
<br>




### <p style="text-align: center;"> Inteligencia Artificial 2020/21</p>




  ## <p style="text-align: center;"> BLOKUS </p>

<br>


                                                                                                                           

<div style="text-align:center"><img src="Blokus.png" height="220" width="500"/></div>

<br>
<p style="text-align: center;"> <b>Docente:</b> Joaquim Filipe</p>


 ### <p style="text-align: center;"> <b> Realizado por :</b> </p>
 <p style="text-align: center;">Bernardo Mota nº201900947
 <br>
Frederico Alcaria nº201701440 </p>

<div style="page-break-after: always;"></div>

## Acrónimos

* **BFS:** Algoritmo de busca em largura
* **DFS:** Algoritmo de busca em profundidade
* **A***: Algoritmo de procura informada
* **IDE***: integrated deveopment environment (ambiente de desenvolvimento integrado)

<br>

# Introdução

Este manual visa a ser um guia compreensivo para a correta utilização do programa desenvolvido, utilizando a linguagem de programação funcional LISP. O objetivo deste programa é indicar quais os passos necessários para chegar ao objetivo dos problemas dados. Esta versão do Blokus usa um tabuleiro de 14 por 14, mas os problemas alteram as condições de jogo dos tabuleiros e definem os seus objetivos.

<br>

# Instalação e utilização

Para puder executar o programa é necessário o IDE [LispWorks](http://www.lispworks.com/) ou outro que consiga interpretar a linguagem LISP.

## Abrir e Compilar os ficheiros

No LispWorks vai ser preciso compilar o ficheiro project.lisp. Ir File>Compile and Load e escolher o ficheiro project.lisp. Os restantes ficheiros vão ser compilados ao iniciar o programa, irá ser pedido o path de onde se encontram os ficheiros do projeto necessários (procura.lisp , puzzle.lisp , problemas.dat). 

## Executar o Programa

Para executar o programa é necessário abrir um listener e chamar a função iniciar escrevendo (iniciar)

## Navegar no Programa

Para navegar no programa é necessário escrever na consola o nº respetivo à opção que deseja escolher.

<div style="page-break-after: always;"></div>

# Input/Output

**Tipos de input:**

<ul>
  <li>Ficheiros: o programa vai ler o ficheiro dos problemas e mostrar todos os problemas disponíveis.</li>
  <li>Consola: A interação com o programa é através do listener. O programa lê o input e corre a opção associada ao nº introduzido.</li>
</ul>

O ficheiro problemas.dat está estruturado da seguinte maneira: 
<ul>
  <li>(objetivo mínimo (problema))</li>
  <li>Objetivo mínimo: é o primeiro elemento da lista e define qual o objetivo mínimo necessário de alcançar para resolver o problema.</li>
  <li>Problema: Matriz 14 por 14 que contém o tabuleiro para o problema.</li>
</ul>

Ex:
```lisp
(8
  ((0 0 0 0 2 2 2 2 2 2 2 2 2 2)
   (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
   (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
   (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2)))

 ```

**Tipos de output:**

<ul>
  <li>Ficheiros: o programa vai gerar um ficheiro com o nome resultados.dat que guarda toda a informação relacionada à execução do programa.</li>
  <li>Consola: A interação com o utilizador é feita através do listener. O programa mostra os menus com as várias opções possíveis, e quando necessário mostram um exemplo de input.</li>
</ul>

O ficheiro resultados.dat é gerado no fim da execução de um algoritmo e regista a sequência de estado até à solução e as estatísticas de execução:

<br>
<br>

Ex:
```lisp
- --/-/-/-/-/R E S U L T A D O/-/-/-/-/-/-/-/-- - 
 
Algoritmo utilizado: A* 
 
Profundidade: 0 
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 10 15) 
 
Profundidade: 1 
# # _ _ _ _ _ : : : : : : :
# # _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 9 15) 
 
Profundidade: 2 
# # _ _ _ _ _ : : : : : : :
# # _ _ _ _ _ : : : : : : :
_ _ # # _ _ _ : : : : : : :
_ # # _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 9 14) 
 
Profundidade: 3 
# # _ _ _ _ _ : : : : : : :
# # _ _ _ _ _ : : : : : : :
_ _ # # _ _ _ : : : : : : :
_ # # _ # # _ : : : : : : :
_ _ _ _ # # _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 8 14) 
 
Profundidade: 4 
# # _ _ _ # _ : : : : : : :
# # _ _ _ # # : : : : : : :
_ _ # # _ _ # : : : : : : :
_ # # _ # # _ : : : : : : :
_ _ _ _ # # _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
_ _ _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 8 13) 
 
Profundidade: 5 
# # _ _ _ # _ : : : : : : :
# # _ _ _ # # : : : : : : :
_ _ # # _ _ # : : : : : : :
_ # # _ # # _ : : : : : : :
# _ _ _ # # _ : : : : : : :
# # _ _ _ _ _ : : : : : : :
_ # _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (10 8 12) 
 
Profundidade: 6 
# # _ _ _ # _ : : : : : : :
# # _ _ _ # # : : : : : : :
_ _ # # _ _ # : : : : : : :
_ # # _ # # _ : : : : : : :
# _ _ _ # # _ : : : : : : :
# # _ _ _ _ # : : : : : : :
_ # _ _ _ _ _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (9 8 12) 
 
Profundidade: 7 
# # _ _ _ # _ : : : : : : :
# # _ _ _ # # : : : : : : :
_ _ # # _ _ # : : : : : : :
_ # # _ # # _ : : : : : : :
# _ _ _ # # _ : : : : : : :
# # _ _ _ _ # : : : : : : :
_ # _ _ _ # _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (8 8 12) 
 
Profundidade: 8 
# # _ _ _ # _ : : : : : : :
# # _ _ _ # # : : : : : : :
_ _ # # _ _ # : : : : : : :
_ # # _ # # _ : : : : : : :
# _ _ _ # # _ : : : : : : :
# # _ # _ _ # : : : : : : :
_ # _ _ _ # _ : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
: : : : : : : : : : : : : :
Peças disponiveis: (7 8 12) 
 
- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - 
Factor de ramificação média: 3.4375 
Número de nós gerados: 55 
Número de nós expandidos: 16 
Penetrância: 0.14545454 
Tempo de execução em segundos: 0.013 
- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - 
 ```

<div style="page-break-after: always;"></div>

# Exemplo de aplicação

Ao iniciar o programa irá ser pedido o file path até ao local onde se encontra o projeto.

```lisp
Escreva o path da localizacao do projeto entre aspas
Exemplo: ''C:/Users/username/Desktop/''
```

Ao inserir o path surgirá o menu com a seguinte interface, para escolher uma opção é só introduzir no listener o número correspondente à ação que quer realizar.

```lisp
 _____________________________________ 
|                                     | 
|           JOGO DO BLOKUS            | 
|                                     | 
|              1 - Jogar              | 
|              0 - Sair               | 
|_____________________________________|
 ```

Se escolher 1 irá passar para o menu dos tabuleiros, se escolher 0 o programa fecha.

O menu dos tabuleiros apresenta todos os tabuleiros possíveis, que estão localizados no ficheiro problemas.dat.

```lisp
 _____________________________________ 
|                                     | 
|           JOGO DO BLOKUS            | 
|                                     | 
|         Escolha o tabuleiro:        | 
|                                     | 
|         1 : Tabuleiro 1             | 
|         2 : Tabuleiro 2             | 
|         3 : Tabuleiro 3             | 
|         4 : Tabuleiro 4             | 
|         5 : Tabuleiro 5             | 
|         6 : Tabuleiro 6             | 
|         0 - Voltar                  | 
|                                     | 
|_____________________________________| 
 ```

Ao escolher o tabuleiro, o menu dos algortimos vai aparecer com 3 escolhas possíveis:
<ul>
  <li>BFS - Breadth-First Search</li>
  <li>DFS - Depth-First Search</li>
  <li>A*
</ul>

**AVISO**: O programa não prevê se o problema pode ser resolvido em tempo útil.
<ul>
  <li> Cuidado no caso do algoritmo BFS que ao começar a expandir nós de profundidade 7, visto que o problema tem uma ramificação muito elevada, dificilmente alcançará o nível 8 em tempo útil. Por essa razão não conseguirá resolver tabuleiros para além do tabuleiro 2.</li>
  <li>E especial atenção no algoritmo DFS, um nível de profundidade máxima demasiado baixo, pode tornar o problema impossível, por isso o tempo de execução torna-se idêntico ao BFS pois toda a árvore terá de ser expandida e mesmo assim nenhum nó objetivo poderá ser encontrado.</li>
</ul>

```lisp
 _____________________________________ 
|                                     | 
|           JOGO DO BLOKUS            | 
|                                     | 
|       Escolha o algoritmo:          | 
|                                     | 
|       1 - Breadth-First Search      | 
|       2 - Depth-First Search        | 
|       3 - A*                        | 
|       0 - Voltar                    | 
|                                     | 
|_____________________________________| 
 ```
## BFS (Breadth-First Search)

Se escolher o BFS o algoritmo vai correr no tabuleiro escolhido. Quando o algoritmo terminar irá aparecer todos os nós até à solução final e as estatísticas relacionadas.

## DFS (Depth-First Search)

Se escolher o DFS irá aparecer um menu para inserir o limite máximo de profundidade. Quando o algortimo terminar irá aparecer todos os nós até à solução final e as estatísticas relacionadas.

```lisp
 _____________________________________ 
|                                     | 
|           JOGO DO BLOKUS            | 
|                                     | 
|    Qual o limite de profundidade    | 
|                                     | 
|     > 0 - nível de profundidade     | 
|       0 - Voltar                    | 
|                                     | 
|_____________________________________|
 ```

<br>
<br>
<br>

## A*

Se escolher o A* irá aparecer um menu para escolher qual a heuristica a utilizar. Existem duas disponíveis, uma base e uma original. Quando o algortimo terminar irá aparecer todos os nós até à solução final e as estatísticas relacionadas.

```lisp
 _____________________________________ 
|                                     | 
|           JOGO DO BLOKUS            | 
|                                     | 
|       Escolha a heuristica          | 
|                                     | 
|       1 - Heuristica base           | 
|       2 - Heuristica original       | 
|       0 - Voltar                    | 
|                                     | 
|_____________________________________| 
 ```


## Conclusão do Programa

Quando o algoritmo terminar irá aparecer a sequência de estados até ao fim do problema e as estatísticas relacionadas à execução do algoritmo. Nas estatísticas irá ser possível ver:

<ul>
  <li>Factor de ramificação média</li>
  <li>Número de nós gerados</li>
  <li>Número de nós expandidos</li>
  <li>Penetrância</li>
  <li>Tempo de execução em segundos</li>
</ul>

Ex:

```lisp
- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - 
Factor de ramificação média: 21.36111 
Número de nós gerados: 769 
Número de nós expandidos: 36 
Penetrância: 0.041612484 
Tempo de execução em segundos: 0.416 
- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - 
 ```

Toda a informação que é apresentada no final da execução tambem irá ser guardada no ficheiro resultados.dat. O utilizador depois terá a opção de continuar a usar ou fechar o programa.B