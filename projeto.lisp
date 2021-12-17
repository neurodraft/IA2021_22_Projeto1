(defun iniciar ()
  "Fun��o que inicia o programa"
  (progn
   (definir-pasta)
   (menu-inicial)))

(defun definir-pasta ()
  "Pede o path da localiza��o do projeto e compila os ficheiros puzzle.lisp e procura.lisp"
  (progn
   (format t "Escreva o path da localizacao do projeto entre aspas~%")
   (format t "Exemplo: ''C:/Users/username/Desktop/''~%")
   (let ((path (read)))
     (load (compile-file (concatenate 'string path "puzzle.lisp")))
     (load (compile-file (concatenate 'string path "procura.lisp")))
     (defparameter *path* path)
     path)))  
 
(defun mostrar-menu-inicial ()
  "Imprime no listener o menu inicial"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|              1 - Jogar              |")
   (format t " ~%|              0 - Sair               |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Op��o: ")))

(defun mostrar-selecionar-algoritmo ()
  "Imprime no listener o menu que permite selecionar o algoritmo"
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
   (format t " ~%-> Op��o: ")))

(defun mostrar-selecionar-heuristica ()
  "Imprime no listener o menu que permite selecionar a heuristica a ser usada"
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
   (format t " ~%-> Op��o: ")))

(defun mostrar-limite-profundidade ()
  "Imprime no listener o menu que permite inserir o n�vel m�ximo de profundidade"
  (progn
   (format t " ~% _____________________________________")
   (format t " ~%|                                     |")
   (format t " ~%|           JOGO DO BLOKUS            |")
   (format t " ~%|                                     |")
   (format t " ~%|    Qual o limite de profundidade    |")
   (format t " ~%|                                     |")
   (format t " ~%|     > 0 - n�vel de profundidade     |")
   (format t " ~%|       0 - Voltar                    |")
   (format t " ~%|                                     |")
   (format t " ~%|_____________________________________|")
   (format t " ~%                                       ")
   (format t " ~%-> Op��o: ")))

(defun mostrar-tabuleiros (numero-tabuleiros &optional (i 1))
  "Imprime no listener o menu que permite selecionar o tabuleiro a ser usado"
  (if (zerop numero-tabuleiros)
      (progn
       (format t " ~%|         0 - Voltar                  |")
       (format t " ~%|                                     |")
       (format t " ~%|_____________________________________|")
       (format t " ~%                                       ")
       (format t " ~%-> Op��o: "))
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


(defun menu-limite-profundidade (minimo-casas-preencher tabuleiro)
  "Chama a fun��o mostrar-limite-profundidade e l� o input do utilizador"
  (progn (mostrar-limite-profundidade)
         (let ((option (read)))
           (cond
            ((or (not (numberp option)) (< option 0)) (format t "Op��o inv�lida!") (menu-limite-profundidade minimo-casas-preencher tabuleiro))
            ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro))
            (T (efetuar-procura 'dfs tabuleiro (criar-funcao-objetivo minimo-casas-preencher) option))))))


(defun menu-inicial ()
  "Chama a fun��o mostrar-menu-inicial, l� o input do utilizador e redireciona para o menu de escolha de tabuleiros"
  (progn
   (mostrar-menu-inicial)
   (let ((option (read)))
     (cond
      ((eq option '1) (menu-tabuleiros))
      ((eq option '0) (format t "At� � pr�xima!"))
      (T (progn (format t "Op��o inv�lida!") (menu-inicial)))))))

(defun menu-algoritmo (minimo-casas-preencher tabuleiro)
  "Chama a fun��o mostrar-selecionar-algoritmo, l� o input do utilizador e redireciona para o menu respetivo de cada algoritmo"
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
            (T (progn (format t "Op��o inv�lida!") (menu-algoritmo minimo-casas-preencher tabuleiro)))))))

(defun menu-heuristica (tabuleiro minimo-casas-preencher)
  "Chama a fun��o mostrar-selecionar-heuristica e l� o input do utilizador"
  (progn (mostrar-selecionar-heuristica)
         (let ((option (read)))
           (cond
            ((eq option '1) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil (criar-funcao-heuristica-base minimo-casas-preencher)))
            ((eq option '2) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil 'heuristica-original))
            ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro))
            (T (progn (format t "Op��o inv�lida!") (menu-inicial)))))))

(defun menu-tabuleiros ()
"Chama a fun��o mostrar-tabuleiros e ler-tabuleiros, o n� de op��es depende do n�mero de problemas encotrados no ficheiro problemas.dat"
  (let ((problemas (ler-tabuleiros)))
    (progn (mostrar-tabuleiros (length problemas))
           (let ((option (read)))
             (cond
              ((eq option '0) (menu-inicial))
              ((or (not (numberp option)) (> option (length problemas)))
               (progn
                (format t "Insira uma op��o v�lida")
                (menu-tabuleiros)))
              (T (let ((problema (nth (1- option) problemas)))
                   (menu-algoritmo (first problema) (second problema)))))))))

(defun efetuar-procura (algoritmo tabuleiro objetivo &optional profundidade-maxima funcao-heuristica)
  "Executa os algoritmos e conta o tempo total de execu��o. Chama as fun��es que registam e imprimem os resultados e estat�sticas"
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
  "Fun��o que gere a cria��o dos resultados, chama as fun��es necess�rias para tal"
  (progn
   (registar-algoritmo algoritmo profundidade-maxima)
   (registar-solucao (car resultado))
   (registar-estatisticas (cdr resultado) tempo-total)))

(defun registar-algoritmo (algoritmo &optional profundida-maxima)
  "Regista no ficheiro resultados.dat as informa��es iniciais do algoritmo"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (progn
     (format file "- --/-/-/-/-/R E S U L T A D O/-/-/-/-/-/-/-/-- - ~% ~%")
     (cond
      ((equal algoritmo 'dfs)
       (format file "Algoritmo utilizado: ~a (~a n�veis de profundidade) ~% ~%" algoritmo profundida-maxima))
      (t (format file "Algoritmo utilizado: ~a ~% ~%" algoritmo))))))

(defun registar-solucao (no)
  "Fun��o que gere a cria��o dos resultados dos n�s"
  (cond
   ((null no) nil)
   (t (progn (registar-solucao (no-pai no)) (registar-no no)))))

(defun registar-tabuleiro (tabuleiro)
  "Regista no ficheiro resultados.dat o estado do tabuleiro"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (format file "~{~{~a~^ ~}~%~}" (tabuleiro-letras tabuleiro))))
  
(defun registar-no (no)
  "Regista no ficheiro resultados.dat as informa��es do n� atual"
  (progn
   (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
     (format file "Profundidade: ~a ~%" (no-profundidade no)))
   (registar-tabuleiro (first (no-estado no)))
   (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
     (format file "Pe�as disponiveis: ~a ~% ~%" (second (no-estado no))))))

(defun registar-estatisticas (estatisticas tempo-total)
  "Regista no ficheiro resultados.dat as estat�sticas da execu��o do algoritmo"
  (with-open-file (file (diretorio-resultados) :direction :output :if-exists :append :if-does-not-exist :create)
    (progn
     (format file "- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - ~%")
     (format file "Factor de ramifica��o m�dia: ~a ~%" (first estatisticas))
     (format file "N�mero de n�s gerados: ~a ~%" (second estatisticas))
     (format file "N�mero de n�s expandidos: ~a ~%" (third estatisticas))
     (format file "Penetr�ncia: ~a ~%" (fourth estatisticas))
     (format file "Tempo de execu��o em segundos: ~a ~%" tempo-total)
     (format file "- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - ~% ~%"))))

(defun mostrar-algoritmo (algoritmo &optional profundida-maxima)
  "Imprime no listener as informa��es iniciais do algoritmo"
  (progn
   (format t "- --/-/-/-/-/R E S U L T A D O/-/-/-/-/-/-/-/-- - ~% ~%")
   (cond
    ((equal algoritmo 'dfs)
     (format t "Algoritmo utilizado: ~a (~a n�veis de profundidade) ~% ~%" algoritmo profundida-maxima))
    (t (format t "Algoritmo utilizado: ~a ~% ~%" algoritmo)))))

(defun mostrar-tabuleiro (tabuleiro)
  "Imprime no listener o estado do tabuleiro"
  (format t "~{~{~a~^ ~}~%~}" (tabuleiro-letras tabuleiro)))

(defun mostrar-solucao (no)
  "Fun��o que gere a impress�o da informa��o dos n�s no listener"
  (cond
   ((null no) nil)
   (t (progn (mostrar-solucao (no-pai no)) (mostrar-no no)))))

(defun mostrar-resultado (resultado tempo-total algoritmo &optional profundidade-maxima)
  "Fun��o que gere a impress�o dos resultados e estat�sticas"
  (progn
   (mostrar-algoritmo algoritmo profundidade-maxima)
   (mostrar-solucao (car resultado))
   (mostrar-estatisticas (cdr resultado) tempo-total)))

(defun mostrar-estatisticas (estatisticas tempo-total)
"Imprime no listener as estatisticas da execu��o do algoritmo"
  (progn
   (format t "- --/-/-/-/-/E S T A T I S T I C A S/-/-/-/-/-- - ~%")
   (format t "Factor de ramifica��o m�dia: ~a" (first estatisticas))
   (terpri)
   (format t "N�mero de n�s gerados: ~a" (second estatisticas))
   (terpri)
   (format t "N�mero de n�s expandidos: ~a" (third estatisticas))
   (terpri)
   (format t "Penetr�ncia: ~a" (fourth estatisticas))
   (terpri)
   (format t "Tempo de execu��o em segundos: ~a" tempo-total)
   (terpri)
   (format t "- --/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-- - ~% ~%")))

(defun mostrar-no (no)
"Imprime no listener as informa��es do n� atual"
  (progn
   (format t "Profundidade: ~a ~%" (no-profundidade no))
   (mostrar-tabuleiro (first (no-estado no)))
   (format t "Pe�as disponiveis: ~a" (second (no-estado no)))
   (terpri)
   (terpri)))

(defun tabuleiro-letras (tabuleiro)
"Percorre o tabuleiro e troca os n�meros por s�mbolos"
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



