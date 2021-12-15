(defun menu-inicial ()
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


;; Sele��o do algoritmo
(defun selecionar-algoritmo ()
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

(defun selecionar-heuristica ()
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

;; Iniciar o jogo
(defun start ()
  (progn (menu-inicial)
         (let ((option (read)))
           (cond
            ((eq option '1) (start-alg))
            ((eq option '0) (format t "At� � pr�xima!"))
            (T (progn (format t "Op��o inv�lida!") (start)))))))

;; Corre os algoritmos
(defun start-alg ()
  (progn (selecionar-algoritmo)
         (let ((option (read)))
           (cond
            ((eq option '1)
             ;BFS 
            )
            ((eq option '2)
             ;DFS
            )
            ((eq option '3)
             (start-heuristica))
            ((eq option '0) (start))
            (T (progn (format t "Op��o inv�lida!") (start-alg)))))))

(defun efetuar-procura (fprocura)
  (let* ((tempo-inicio (tempo-atual))
         (resultado (eval fprocura))
         (tempo-final (tempo-atual))
         (tempo-total (- tempo-final)))
    (progn)))

(defun diferenca-tempo (tempo-inicial tempo-final)
  (let* ((tempo-inicial-segundos (+ (* (first tempo-inicial) 3600) (* (second tempo-inicial) 60) (third tempo-inicial)))
    (tempo-final-segundos (+ (* (first tempo-final) 3600) (* (second tempo-final) 60) (third tempo-final))))
  (- tempo-final-segundos tempo-inicial-segundos))
)

(defun mostrar-estados (nos profundidade)
  (cond
   ((null nos) nil)
   ((/= (no-profundidade (car nos)) profundidade) (mostrar-estados (cdr nos) profundidade))
   (t (progn
       (mostrar-tabuleiro (car (car (car nos))))
       (terpri)
       (mostrar-estados (cdr nos) profundidade)))))

(defun mostrar-tabuleiro (tabuleiro)
  (format t "~{~{~a~^ ~}~%~}" (tabuleiro-letras tabuleiro)))

(defun mostrar-solucao (no)
  (cond
   ((null no) nil)
   (t (progn (mostrar-solucao (no-pai no)) (mostrar-no no)))))

(defun mostrar-resultado (resultado)
  (progn
   (mostrar-solucao (car resultado))
   (mostrar-estatisticas (cdr resultado))))

(defun mostrar-estatisticas (estatisticas)
  (progn
   (format t "Factor de ramifica��o m�dia: ~a" (first estatisticas))
   (terpri)
   (format t "N�mero de n�s gerados: ~a" (second estatisticas))
   (terpri)
   (format t "N�mero de n�s expandidos: ~a" (third estatisticas))
   (terpri)
   (format t "Penetr�ncia: ~a" (fourth estatisticas))))

(defun mostrar-no (no)
  (progn
   (mostrar-tabuleiro (first (no-estado no)))
   (terpri)
   (format t "Pe�as disponiveis: ~a" (second (no-estado no)))
   (terpri)))

(defun start-heuristica ()
  (progn (selecionar-heuristica)
         (let ((option (read)))
           (cond
            ((eq option '1) nil)
            ((eq option '2) nil)
            ((eq option '0) (format t "At� � pr�xima!"))
            (T (progn (format t "Op��o inv�lida!") (start)))))))

;; Devolve o path para o ficheiro problemas.dat
(defun diretorio-problemas ()
  (make-pathname :host "c" :directory '(:absolute "lisp") :name "problemas" :type "dat"))

;; Retorna os tabuleiros do ficheiro problemas.dat
(defun ler-tabuleiros ()
  (with-open-file (file (diretorio-problemas) :if-does-not-exist nil)
    (do ((result nil (cons next result)) (next (read file nil 'eof) (read file nil 'eof)))
      ((equal next 'eof) (reverse result)))))

;; Mostra o menu com os tabuleiros 
(defun menu-tabuleiro (&optional (i 1) (problemas (ler-tabuleiros)))
  (if (null problemas)
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
       (format t " ~%|         ~a : tabuleiro ~a           |" i i)
       (menu-tabuleiro (+ i 1) (cdr problemas)))))

(defun select-tabuleiro (menu)
  (progn (menu-tabuleiro)
         (let ((option (read)))
           (cond
            ((eq option '0) (funcall menu))
            ((not (numberp option))
             (progn
              (format t "Insira uma op��o v�lida")
              (select-tabuleiro menu)))
            (T (let ((lista-tabuleiros (ler-tabuleiros)))
                 (cond
                  ((eq option 0) (format t "At� � pr�xima!"))
                  (t (if (or (> option (length lista-tabuleiros) (< option 0)))
                         (progn
                          (format t "Insira uma op��o v�lida")
                          (select-tabuleiro menu))
                         (list option (nth (1- option) lista-tabuleiros)))))))))))

(defun directory-resultados-file ()
  (make-pathname :host "c" :directory '(:absolute "lisp") :name "resultados" :type "dat"))

(defun escrever-ficheiro-resultados (sol)
  (let* ((tempo-inicial (car sol))
         (alg-solucao (car (cdr sol)))
         (tempo-fim (car (cdr (cdr sol))))
         (alg (car (cdr (cdr (cdr sol)))))
         (moves (car (cdr (cdr (cdr (cdr (cdr sol)))))))
         (goal (car (cdr (cdr (cdr (cdr (cdr sol))))))))
    (with-open-file (file (directory-resultados-file) :direction :output :if-exists :append :if-does-not-exist :create)
      (progn
       (format file "~%* ------------------------- *")
       (format file "~%~t> Algoritmo escolhido: ~a " alg)
       (format file "~%~t> Hora de In�cio: ~a:~a:~a" (car tempo-inicial) (car (cdr tempo-inicial)) (car (cdr (cdr tempo-inicial))))
       (format file "~%~t> Hora de Fim: ~a:~a:~a" (car tempo-fim) (car (cdr tempo-fim)) (car (cdr (cdr tempo-fim))))
       (format file "~%~t> N�mero de n�s gerados: ~a" (+ (car (cdr alg-solucao)) (car (cdr (cdr alg-solucao)))))
       (format file "~%~t> N�mero de n�s expandidos: ~a" (car (cdr (cdr alg-solucao))))
       (format file "~%~t> Profundidade m�xima: ~a" moves)
       (format file "~%~t> Objetivo pretendido: ~a" goal)
       (format file "~%~t> Penetr�ncia: ~F" (penetrancia alg-solucao))
       (format file "~%~t> Pontos totais: ~a" (no-g (car alg-solucao)))
       (display-jogadas (car alg-solucao) (car (cdr alg-solucao)) (car (cdr (cdr alg-solucao))))))))

(defun tempo-atual ()
  "Retorna o tempo atual com o formato (h m s)"
  (multiple-value-bind (s m h) (get-decoded-time)
    (list h m s)))