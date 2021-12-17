(defun mostrar-menu-inicial ()
  "Mostra o menu inicial"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|              1 - Jogar              |")
   (format t " ~%|              0 - Sair               |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Opção: ")))

(defun mostrar-selecionar-algoritmo ()
  "Mostra o menu que permite selecionar o algoritmo"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|       Escolha o algoritmo:          |")
   (format t " ~%|                                     |")
   (format t " ~%|       1 - Breadth-First Search      |")
   (format t " ~%|       2 - Depth-First Search        |")
   (format t " ~%|       3 - A*                        |")
   (format t " ~%|       0 - Voltar                    |")
   (format t " ~%|                                     |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Opção: ")))

(defun mostrar-selecionar-heuristica ()
  "Mostra o menu que permite selecionar a heuristica a usar"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|       Escolha a heuristica          |")
   (format t " ~%|                                     |")
   (format t " ~%|       1 - Heuristica base           |")
   (format t " ~%|       2 - Heuristica original       |")
   (format t " ~%|       0 - Voltar                    |")
   (format t " ~%|                                     |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Opção: ")))

(defun mostrar-limite-profundidade ()
  "Mostra o menu que permite escolher o nível de profundidade"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|    Qual o limite de profundidade    |")
   (format t " ~%|                                     |")
   (format t " ~%|     > 0 - nível de profundidade     |")
   (format t " ~%|       0 - Voltar                    |")
   (format t " ~%|                                     |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Opção: ")))

(defun definir-pasta ()
  "Pede o path onde o projeto se encotra e vai compilar os ficheiros puzzle.lisp e procura.lisp"
  (progn
   (format t "Escreva o path da localizacao do projeto entre aspas~%")
   (format t "Exemplo: ''C:/Users/username/Desktop/''~%")
   (let ((path (read)))
     (load (compile-file (concatenate 'string path "puzzle.lisp")))
     (load (compile-file (concatenate 'string path "procura.lisp")))
     (defparameter *path* path)
     path)))

(defun menu-limite-profundidade (minimo-casas-preencher tabuleiro)
  "Chama a função que permite mostrar o menu onde é pedido para user escolher o nível de profundidade
  e lê o input do utilizador. De seguida corre o algoritmo"
  (progn (mostrar-limite-profundidade)
         (let ((option (read)))
           (cond
            ((or (not (numberp option)) (< option 0)) (format t "Opção inválida!") (menu-limite-profundidade minimo-casas-preencher tabuleiro))
            ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro))
            (T (efetuar-procura 'dfs tabuleiro (criar-funcao-objetivo minimo-casas-preencher) option))))))

(defun iniciar ()
  "Função que começa o programa"
  (progn
   (definir-pasta)
   (menu-inicial)))

(defun menu-inicial ()
  "Chama a função que permite mostrar o menu inicial e lê o input do utilizador. De seguida vai para o menu onde se escolhe os tabuleiros"
  (progn
   (mostrar-menu-inicial)
   (let ((option (read)))
     (cond
      ((eq option '1) (menu-tabuleiros))
      ((eq option '0) (format t "Até à próxima!"))
      (T (progn (format t "Opção inválida!") (menu-inicial)))))))

(defun menu-algoritmo (minimo-casas-preencher tabuleiro)
  "Chama a função que permite mostrar o menu onde é pedido para user escolher o algoritmo
  e lê o input do utilizador."
  (progn (mostrar-selecionar-algoritmo)
         (let ((option (read)))
           (cond
            ((eq option '1)
             (efetuar-procura 'bfs tabuleiro (criar-funcao-objetivo minimo-casas-preencher)))
            ((eq option '2)
             (menu-limite-profundidade minimo-casas-preencher tabuleiro))
            ((eq option '3)
             (menu-heuristica tabuleiro minimo-casas-preencher))
            ((eq option '0) (menu-tabuleiros))
            (T (progn (format t "Opção inválida!") (menu-algoritmo minimo-casas-preencher tabuleiro)))))))

(defun menu-heuristica (tabuleiro minimo-casas-preencher)
  "Chama a função que permite mostrar o menu onde é pedido para user escolher a heuristica
  e lê o input do utilizador."
  (progn (mostrar-selecionar-heuristica)
         (let ((option (read)))
           (cond
            ((eq option '1) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil (criar-funcao-heuristica-base minimo-casas-preencher)))
            ((eq option '2) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil 'heuristica-original))
            ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro))
            (T (progn (format t "Opção inválida!") (menu-inicial)))))))

(defun efetuar-procura (algoritmo tabuleiro objetivo &optional profundidade-maxima funcao-heuristica)
  "Inicia os algoritmos, e conta o tempo total de execução. Chama as funções para registar os resultados"
  (let* ((tempo-inicio (get-internal-real-time))
         (no (criar-no-inicial-blockus tabuleiro))
         (resultado (cond
                     ((eq algoritmo 'bfs) (bfs no objetivo 'sucessores (operadores)))
                     ((eq algoritmo 'dfs) (dfs no objetivo 'sucessores (operadores) profundidade-maxima))
                     ((eq algoritmo 'a*) (a* no objetivo 'sucessores (operadores) funcao-heuristica))))
         (tempo-final (get-internal-real-time))
         (tempo-total (/ (- tempo-final tempo-inicio) 1000.0)))
    (progn
      (cond
        ((null resultado) nil)
        (t (mostrar-resultado resultado tempo-total algoritmo profundidade-maxima)
            (registar-resultado resultado tempo-total algoritmo profundidade-maxima))
      )
     (menu-inicial))))     

(defun registar-resultado (resultado tempo-total algoritmo &optional profundidade-maxima)
  "Função para gerir a criação dos resultados"
  (progn
   (registar-algoritmo algoritmo profundidade-maxima)
   (registar-solucao (car resultado))
   (registar-estatisticas (cdr resultado) tempo-total)))

(defun registar-algoritmo (algoritmo &optional profundida-maxima)
  "Escreve as informações relacionadas ao algoritmo no ficheiro resultados.dat"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (progn
     (format file "- --/-/-/-/-/R E S U L T A D O/-/-/-/-/-/-/-/-- - ~% ~%")
     (cond
      ((equal algoritmo 'dfs)
       (format file "Algoritmo utilizado: ~a (~a níveis de profundidade) ~% ~%" algoritmo profundida-maxima))
      (t (format file "Algoritmo utilizado: ~a ~% ~%" algoritmo))))))

(defun mostrar-algoritmo (algoritmo &optional profundida-maxima)
  "Imprime as informações relacionadas ao algoritmo"
  (progn
   (format t "- --/-/-/-/-/R E S U L T A D O/-/-/-/-/-/-/-/-- - ~% ~%")
   (cond
    ((equal algoritmo 'dfs)
     (format t "Algoritmo utilizado: ~a (~a níveis de profundidade) ~% ~%" algoritmo profundida-maxima))
    (t (format t "Algoritmo utilizado: ~a ~% ~%" algoritmo)))))

(defun registar-solucao (no)
  "Escreve o nó no ficheiro resultados.dat"
  (cond
   ((null no) nil)
   (t (progn (registar-solucao (no-pai no)) (registar-no no)))))

(defun registar-tabuleiro (tabuleiro)
  "Escreve o tabuleiro no ficheiro resultados.dat"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (format file "~{~{~a~^ ~}~%~}" (tabuleiro-letras tabuleiro))))

(defun registar-no (no)
  "Escreve as imformações relacionadas ao nó no ficheiro resultados.dat"
  (progn
   (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
     (format file "Profundidade: ~a ~%" (no-profundidade no)))
   (registar-tabuleiro (first (no-estado no)))
   (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
     (format file "Peças disponiveis: ~a ~% ~%" (second (no-estado no))))))

(defun registar-estatisticas (estatisticas tempo-total)
  "Escreve as estatisticas relacionadas"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (progn
     (format file "- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - ~%")
     (format file "Factor de ramificação média: ~a ~%" (first estatisticas))
     (format file "Número de nós gerados: ~a ~%" (second estatisticas))
     (format file "Número de nós expandidos: ~a ~%" (third estatisticas))
     (format file "Penetrância: ~a ~%" (fourth estatisticas))
     (format file "Tempo de execução em segundos: ~a ~%" tempo-total)
     (format file "- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - ~% ~%"))))

(defun mostrar-tabuleiro (tabuleiro)
  "Imprime o tabuleiro"
  (format t "~{~{~a~^ ~}~%~}" (tabuleiro-letras tabuleiro)))

(defun mostrar-solucao (no)
  "Gere a representação dos nós"
  (cond
   ((null no) nil)
   (t (progn (mostrar-solucao (no-pai no)) (mostrar-no no)))))

(defun mostrar-resultado (resultado tempo-total algoritmo &optional profundidade-maxima)
  "Função para gerir as funções que imprimem os resultados"
  (progn
   (mostrar-algoritmo algoritmo profundidade-maxima)
   (mostrar-solucao (car resultado))
   (mostrar-estatisticas (cdr resultado) tempo-total)))

(defun mostrar-estatisticas (estatisticas tempo-total)
  (progn
   (format t "- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - ~%")
   (format t "Factor de ramificação média: ~a" (first estatisticas))
   (terpri)
   (format t "Número de nós gerados: ~a" (second estatisticas))
   (terpri)
   (format t "Número de nós expandidos: ~a" (third estatisticas))
   (terpri)
   (format t "Penetrância: ~a" (fourth estatisticas))
   (terpri)
   (format t "Tempo de execução em segundos: ~a" tempo-total)
   (terpri)
   (format t "- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - ~% ~%")))

(defun mostrar-no (no)
  (progn
   (format t "Profundidade: ~a ~%" (no-profundidade no))
   (mostrar-tabuleiro (first (no-estado no)))
   (format t "Peças disponiveis: ~a" (second (no-estado no)))
   (terpri)
   (terpri)))

(defun tabuleiro-letras (tabuleiro)
  (mapcar (lambda (row)
            (mapcar (lambda (cel)
                      (cond
                       ((= cel 2) ":")
                       ((= cel 1) "#")
                       (t "_"))) row)) tabuleiro))


(defun diretorio-problemas ()
  "Devolve o path para o ficheiro problemas.dat"
  (concatenate 'string *path* "problemas.dat"))

(defun diretorio-resultados ()
  ";Devolve o path para o ficheiro resultados.dat"
  (concatenate 'string *path* "resultados.dat"))

(defun ler-tabuleiros ()
  "Retorna os tabuleiros do ficheiro problemas.dat"
  (with-open-file (file (diretorio-problemas) :if-does-not-exist nil)
    (do ((result nil (cons next result)) (next (read file nil 'eof) (read file nil 'eof)))
      ((equal next 'eof) (reverse result)))))

(defun mostrar-tabuleiros (numero-tabuleiros &optional (i 1))
  "Mostra o menu com os tabuleiros"
  (if (zerop numero-tabuleiros)
      (progn
       (format t " ~%|         0 - Voltar                  |")
       (format t " ~%|                                     |")
       (format t " ~%|_____________________________________|")
       (format t " ~%                                       ")
       (format t " ~%-> Opção: "))
      (progn
       (cond
        ((= i 1)
         (progn
          (format t " ~% _____________________________________")
          (format t " ~%|                                     |")
          (format t " ~%|           JOGO DO BLOKUS            |")
          (format t " ~%|                                     |")
          (format t " ~%|         Escolha o tabuleiro:        |")
          (format t " ~%|                                     |"))) (t nil))
       (format t " ~%|         ~a : Tabuleiro ~a             |" i i)
       (mostrar-tabuleiros (1- numero-tabuleiros) (+ i 1)))))

(defun menu-tabuleiros ()
  (let ((problemas (ler-tabuleiros)))
    (progn (mostrar-tabuleiros (length problemas))
           (let ((option (read)))
             (cond
              ((eq option '0) (menu-inicial))
              ((or (not (numberp option)) (> option (length problemas)))
               (progn
                (format t "Insira uma opção válida")
                (menu-tabuleiros)))
              (T (let ((problema (nth (1- option) problemas)))
                   (menu-algoritmo (first problema) (second problema)))))))))
