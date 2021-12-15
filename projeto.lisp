(defun mostrar-menu-inicial ()
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


;; Seleção do algoritmo
(defun mostrar-selecionar-algoritmo ()
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


(defun menu-limite-profundidade(minimo-casas-preencher tabuleiro)
  (progn (mostrar-limite-profundidade)
    (let ((option (read)))
      (cond
        ((or (not (numberp option)) (< option 0)) (format t "Opção inválida!") (menu-limite-profundidade minimo-casas-preencher tabuleiro))
        ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro ))
        (T (efetuar-procura 'dfs tabuleiro (criar-funcao-objetivo minimo-casas-preencher) option))
      )
    )
  )
)   

;; Iniciar o jogo
(defun iniciar ()
  (progn (mostrar-menu-inicial)
         (let ((option (read)))
           (cond
            ((eq option '1) (menu-tabuleiros))
            ((eq option '0) (format t "Até à próxima!"))
            (T (progn (format t "Opção inválida!") (iniciar)))))))

;; Corre os algoritmos
(defun menu-algoritmo (minimo-casas-preencher tabuleiro)
  (progn (mostrar-selecionar-algoritmo)
         (let ((option (read)))
           (cond
            ((eq option '1)
             (efetuar-procura 'bfs tabuleiro (criar-funcao-objetivo minimo-casas-preencher)))
            ((eq option '2)
             (menu-limite-profundidade minimo-casas-preencher tabuleiro)
            )
            ((eq option '3)
             (menu-heuristica tabuleiro minimo-casas-preencher))
            ((eq option '0) (menu-tabuleiros))
            (T (progn (format t "Opção inválida!") (menu-algoritmo minimo-casas-preencher tabuleiro)))))))

(defun menu-heuristica (tabuleiro minimo-casas-preencher)
  (progn (mostrar-selecionar-heuristica)
         (let ((option (read)))
           (cond
            ((eq option '1) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil (criar-funcao-heuristica-base minimo-casas-preencher)))
            ((eq option '2) (efetuar-procura 'a* tabuleiro (criar-funcao-objetivo minimo-casas-preencher) nil 'heuristica-original2))
            ((eq option '0) (menu-algoritmo minimo-casas-preencher tabuleiro))
            (T (progn (format t "Opção inválida!") (iniciar)))))))

(defun efetuar-procura (algoritmo tabuleiro objetivo &optional profundidade-maxima funcao-heuristica)
  (let* ((tempo-inicio (tempo-atual))
         (resultado (eval algoritmo))
         (tempo-final (tempo-atual))
         (tempo-total (- tempo-final)))
    (progn)))

(defun diferenca-tempo (tempo-inicial tempo-final)
  (let* ((tempo-inicial-segundos (+ (* (first tempo-inicial) 3600) (* (second tempo-inicial) 60) (third tempo-inicial)))
         (tempo-final-segundos (+ (* (first tempo-final) 3600) (* (second tempo-final) 60) (third tempo-final))))
    (- tempo-final-segundos tempo-inicial-segundos)))

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
   (format t "Factor de ramificação média: ~a" (first estatisticas))
   (terpri)
   (format t "Número de nós gerados: ~a" (second estatisticas))
   (terpri)
   (format t "Número de nós expandidos: ~a" (third estatisticas))
   (terpri)
   (format t "Penetrância: ~a" (fourth estatisticas))))

(defun mostrar-no (no)
  (progn
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



;; Devolve o path para o ficheiro problemas.dat
(defun diretorio-problemas ()
  (make-pathname :host "c" :directory '(:absolute "lisp") :name "problemas" :type "dat"))

;; Retorna os tabuleiros do ficheiro problemas.dat
; (defun ler-tabuleiros ()
;   (with-open-file (file (diretorio-problemas) :if-does-not-exist nil)
;     (do ((result nil (cons next result)) (next (read file nil 'eof) (read file nil 'eof)))
;       ((equal next 'eof) (reverse result)))))

(defun ler-tabuleiros ()
  '((8 ((0 0 0 0 2 2 2 2 2 2 2 2 2 2) (0 0 0 0 2 2 2 2 2 2 2 2 2 2) (0 0 0 0 2 2 2 2 2 2 2 2 2 2) (0 0 0 0 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2))) (20 ((0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (0 0 0 0 0 0 0 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2))) (28 ((0 0 2 0 0 0 0 0 0 2 2 2 2 2) (0 0 0 2 0 0 0 0 0 2 2 2 2 2) (0 0 0 0 2 0 0 0 0 2 2 2 2 2) (0 0 0 0 0 2 0 0 0 2 2 2 2 2) (0 0 0 0 0 0 2 0 0 2 2 2 2 2) (0 0 0 0 0 0 0 2 0 2 2 2 2 2) (0 0 0 0 0 0 0 0 2 2 2 2 2 2) (0 0 0 0 0 0 0 0 0 2 2 2 2 2) (0 0 0 0 0 0 0 0 0 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2))) (36 ((0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2))) (44 ((0 2 2 2 2 2 2 2 2 2 2 2 2 2) (2 0 2 0 0 0 0 0 0 2 0 0 0 2) (2 0 0 2 0 0 0 0 0 0 2 0 0 2) (2 0 0 0 2 0 0 0 0 0 0 2 0 2) (2 0 0 0 0 2 0 0 0 0 0 0 2 2) (2 0 0 0 0 0 2 0 0 0 0 0 0 2) (2 0 0 0 0 0 0 2 0 0 0 0 0 2) (2 0 0 0 0 0 0 0 2 0 0 0 0 2) (2 0 0 0 0 0 0 0 0 2 0 0 0 2) (2 0 2 0 0 0 0 0 0 0 2 0 0 2) (2 2 0 0 0 0 0 0 0 0 0 2 0 2) (2 0 0 0 2 0 0 0 0 0 0 0 2 2) (2 0 0 0 0 2 0 0 0 0 0 0 0 2) (2 2 2 2 2 2 2 2 2 2 2 2 2 2))) (72 ((0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0 0 0 0 0 0)))))

;; Mostra o menu com os tabuleiros 
(defun mostrar-tabuleiros (numero-tabuleiros &optional (i 1))
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
              ((eq option '0) (iniciar))
              ((or (not (numberp option)) (> option (length problemas)))
               (progn
                (format t "Insira uma opção válida")
                (menu-tabuleiros)))
              (T (let ((problema (nth option problemas)))
                   (menu-algoritmo (first problema) (second problema)))))))))

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
       (format file "~%~t> Hora de Início: ~a:~a:~a" (car tempo-inicial) (car (cdr tempo-inicial)) (car (cdr (cdr tempo-inicial))))
       (format file "~%~t> Hora de Fim: ~a:~a:~a" (car tempo-fim) (car (cdr tempo-fim)) (car (cdr (cdr tempo-fim))))
       (format file "~%~t> Número de nós gerados: ~a" (+ (car (cdr alg-solucao)) (car (cdr (cdr alg-solucao)))))
       (format file "~%~t> Número de nós expandidos: ~a" (car (cdr (cdr alg-solucao))))
       (format file "~%~t> Profundidade máxima: ~a" moves)
       (format file "~%~t> Objetivo pretendido: ~a" goal)
       (format file "~%~t> Penetrância: ~F" (penetrancia alg-solucao))
       (format file "~%~t> Pontos totais: ~a" (no-g (car alg-solucao)))
       (display-jogadas (car alg-solucao) (car (cdr alg-solucao)) (car (cdr (cdr alg-solucao))))))))

(defun tempo-atual ()
  "Retorna o tempo atual com o formato (h m s)"
  (multiple-value-bind (s m h) (get-decoded-time)
    (list h m s)))
