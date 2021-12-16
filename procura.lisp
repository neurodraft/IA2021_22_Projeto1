;;; Metodos seletores

(defun no-estado (no)
  "Obtem o estado do nó"
  (car no))

(defun no-profundidade (no)
  "Obtem a profundidade do nó"
  (car (cdr no)))

(defun no-pai (no)
  "Obtem a profundidade do nó"
  (car (cdr (cdr no))))

;;; Métodos auxiliares de procura

(defun no-objetivo-em-lista (objetivo lista)
  "Procura por um nó solução numa lista e devolve"
  (cond
   ((null lista) nil)
   ((funcall objetivo (car lista)) (car lista))
   (t (no-objetivo-em-lista objetivo (cdr lista)))))

(defun no-repetido (no lista)
  "Verifica se um no com o mesmo estado existe numa lista e devolve a lista começando nesse no"
  (member no lista :test (lambda (a b) (and (equal (no-estado a) (no-estado b))))))

(defun indice-elemento-lista (no lista &optional (i 0))
  "Obtém a posição de um elemento numa lista ou nil caso não exista"
  (cond
   ((null (car lista)) nil)
   ((equal no (car lista)) i)
   (t (indice-no-lista no (cdr lista) (1+ i)))))

(defun criar-resultado (no numero-nos-gerados numero-nos-expandidos)
  "Função para criar a lista com os resultados finais de uma procura
  (no objetivo, fator de ramificação média, numero de nós gerados, número de nós expandidos e penetrância"
  (list
   no
   (* (/ numero-nos-gerados numero-nos-expandidos) 1.0)
   numero-nos-gerados
   numero-nos-expandidos
   (* (/ (no-profundidade no) numero-nos-gerados) 1.0)))

;;; BFS

(defun abertos-bfs (abertos sucessores)
  "Método BFS de inserção dos sucessores na lista de abertos"
  (append abertos sucessores))

(defun nos-nao-repetidos (nos lista)
  "Devolve a lista de nos sem os com estado igual na lista fornecida"
  (remove nil (mapcar (lambda (no)
                        (cond
                         ((no-repetido no lista) nil)
                         (t no))) nos)))


(defun bfs (no objetivo sucessores operadores &optional abertos fechados (numero-nos-gerados 0) (numero-nos-expandidos 0))
  "Algoritmo de procura em largura implementado recursivamente
  Recebe um nó inicial, uma função de avaliação de nó objetivo,
  uma função geradoradora de nós sucessores e uma lista de operadores fornecidos a esta
  
  Um nó é definido como uma lista composta por estado, profundidade e nó pai.
  A função objetivo deverá receber exclusivamente um nó.
  A função sucessores deverá receber exclusivamente um nó e uma lista de operadores"
  (cond
   ((and (null abertos) (null fechados)) (bfs no objetivo sucessores operadores (list no) nil))
   ((null abertos) nil)
   (t
    (let* ((n (car abertos))
           (sucessores-n (funcall sucessores n operadores))
           (m (no-objetivo-em-lista objetivo sucessores-n)))
      (cond
       (m (criar-resultado m (+ numero-nos-gerados (length sucessores-n)) (1+ numero-nos-expandidos)))
       (t (bfs no objetivo sucessores operadores
               (abertos-bfs (cdr abertos) (nos-nao-repetidos sucessores-n (append (cdr abertos) fechados)))
               (append fechados (list n)) (1+ numero-nos-gerados) (+ numero-nos-expandidos (length sucessores-n)))))))))

; (defun bfs (no objetivo sucessores operadores)
;   "Algoritmo de procura em largura implementado sequencialmente
    ; Recebe um nó inicial, uma função de avaliação de nó objetivo,
    ; uma função geradoradora de nós sucessores e uma lista de operadores fornecidos a esta
    
    ; Um nó é definido como uma lista composta por estado, profundidade e nó pai.
    ; A função objetivo deverá receber exclusivamente um nó.
    ; A função sucessores deverá receber exclusivamente um nó e uma lista de operadores"
;   (let (
;     (abertos (list no))
;     (fechados nil)
;     (numero-nos-gerados 0)
;     (numero-nos-expandidos 0)
;     (n nil)
;     (sucessores-n nil)
;     (sucessores-nao-repetidos nil)
;     (m nil))
;     (loop
;       (when (null abertos) (return (list
;                                       nil
;                                       (* (/ numero-nos-gerados numero-nos-expandidos) 1.0)
;                                       numero-nos-gerados
;                                       numero-nos-expandidos
;                                       (* (/ (no-profundidade m) numero-nos-gerados) 1.0))))
;       (setq n (car abertos))
;       (setq sucessores-n (funcall sucessores n operadores))
;       (setq numero-nos-expandidos (1+ numero-nos-expandidos))
;       (setq numero-nos-gerados (+ numero-nos-gerados (length sucessores-n)))
;       (setq sucessores-nao-repetidos (nos-nao-repetidos sucessores-n (append (cdr abertos) fechados)))
;       (setq m (no-objetivo-em-lista objetivo sucessores-nao-repetidos))
;       (when m (return (criar-resultado m numero-nos-gerados numero-nos-expandidos)))
;       (setq abertos (abertos-bfs (cdr abertos) sucessores-nao-repetidos))
;       (setq fechados (append fechados (list n)))
;     )
;   )
; )


;; Utils DFS

(defun abertos-dfs (abertos sucessores)
  "Método DFS de inserção dos sucessores na lista de abertos"
  (append sucessores abertos))

(defun remover-subarvore (raiz lista)
  "Dada um nó raiz e uma lista de nós, remove todos os nós dessa lista
  pertencentes à sub-arvore, incluindo a raiz"
  (labels ((pertence-a-subarvore (no)
              (cond
               ((null no) nil)
               ((equal (no-pai no) raiz) t)
               (t (pertence-a-subarvore (no-pai no))))))
    (cond
     ((null (car lista)) nil)
     ((or (equal (car lista) raiz) (pertence-a-subarvore (car lista))) (cons nil (remover-subarvore raiz (cdr lista))))
     (t (cons (car lista) (remover-subarvore raiz (cdr lista)))))))

(defun remover-subarvores (a-remover lista)
  "Remove múltiplas subarvores fornecidos como uma lista de nós raiz e uma lista de nós
  "
  (cond
   ((null (car a-remover)) lista)
   (t (remover-subarvores (cdr a-remover) (remove nil (remover-subarvore (car a-remover) lista))))))

(defun dfs-adicionar-sucessores (sucessores fechados abertos)
  "Função que implementa o método de inserção de sucessores no algoritmo DFS
    devolve uma lista com a nova lista de nós abertos e a nova lista de nós fechados
  Recebe uma lista de nós sucessores, fechados e abertos e:
    1. Discarta sucessores que se encontram repetidos na lista de abertos;
    2. Procura por sucessores com estado repetido na lista de fechados e:
      - caso o sucessor tenha menor profundidade (custo uniforme),remove toda a subarvore
        do no fechado da lista de fechados e introduz o sucessor na lista de abertos
      - caso contrário é discartado
    3. Coloca os restantes sucessores em abertos"

  (let* ((sucessores-nao-abertos (remove nil (mapcar (lambda (n)
                                                       (cond
                                                        ((no-repetido n abertos) nil)
                                                        (t n))) sucessores)))
         (sucessores-repetidos-fechados (mapcar (lambda (n)
                                                  (let ((fechado-repetido (car (no-repetido n fechados))))
                                                    (cond
                                                     ((null fechado-repetido) (list 'manter n nil))
                                                     ((> (no-profundidade fechado-repetido) (no-profundidade n)) (list 'substituir n fechado-repetido))
                                                     (t (list 'discartar n fechado-repetido))))) sucessores-nao-abertos))
         (sucessores-validos (remove nil (mapcar (lambda (r)
                                                   (cond
                                                    ((or (equal 'manter (first r)) (equal 'substituir (first r))) (second r))
                                                    (t nil))) sucessores-repetidos-fechados)))
         (fechados-a-remover (remove nil (mapcar (lambda (r)
                                                   (cond
                                                    ((equal 'substituir (first r)) (third r))
                                                    (t nil))) sucessores-repetidos-fechados)))
         (fechados-novos (remover-subarvores fechados-a-remover fechados))
         (abertos-novos (abertos-dfs abertos sucessores-validos)))
    (list abertos-novos fechados-novos)))

(defun dfs (no objetivo sucessores operadores profundidade &optional abertos fechados (numero-nos-gerados 0) (numero-nos-expandidos 0))
  "Algoritmo de procura em profundidade implementado recursivamente
  Recebe um nó inicial, uma função de avaliação de nó objetivo,
  uma função geradoradora de nós sucessores, uma lista de operadores fornecidos a esta
  e um nível de profundidade máximo
  
  Um nó é definido como uma lista composta por estado, profundidade e nó pai.
  A função objetivo deverá receber exclusivamente um nó.
  A função sucessores deverá receber exclusivamente um nó e uma lista de operadores
  A profundidade máxima deverá ser um numero inteiro > 0"
  (cond
   ((and (null abertos) (null fechados))
    (dfs no objetivo sucessores operadores profundidade (list no) nil))
   ((null abertos) nil)
   ((= (no-profundidade (car abertos)) profundidade) (dfs no objetivo sucessores operadores profundidade (cdr abertos) (append fechados (list (car abertos)))))
   (t
    (let* ((n (car abertos))
           (sucessores-n (funcall sucessores n operadores))
           (m (no-objetivo-em-lista objetivo sucessores-n)))
      (cond
       (m (criar-resultado m (+ numero-nos-gerados (length sucessores-n)) (1+ numero-nos-expandidos)))
       (t
        (let ((abertos-fechados-novos (dfs-adicionar-sucessores sucessores-n (append fechados (list n)) (cdr abertos))))
          (dfs no objetivo sucessores operadores profundidade (first abertos-fechados-novos) (second abertos-fechados-novos)
               (1+ numero-nos-gerados) (+ numero-nos-expandidos (length sucessores-n))))))))))

;; A*

(defun insere (e p L)
  "Insere um elemento e na posição p de uma lista movendo os restantes uma posição para a frente.
  Devolve a lista de dimensão (length L) +1"
  (cond
   ((zerop p) (append (list e) L))
   ((null L) nil)
   (t (cons (car L) (insere e (1- p) (cdr L))))))

(defun procura-binaria (n L-ord &optional baixo alto)
  "Devolve a posição numa lista ordenada de valores numericos (L-ord)
  em que valor numerico n deve ser colocado"
  (cond
   ((or (null baixo) (null alto)) (procura-binaria n L-ord 0 (1- (length L-ord))))
   ((< alto baixo) baixo)
   (t (let* ((mid (floor (/ (+ baixo alto) 2)))
             (valor-mid (nth mid L-ord)))
        (cond
         ((> valor-mid n) (procura-binaria n L-ord baixo (1- mid)))
         ((< valor-mid n) (procura-binaria n L-ord (1+ mid) alto))
         (t mid))))))

(defun remove-from-list (l index &optional (i 0))
  "Remove da lista l o elemento de indice index, devolvendo uma lista de dimensão (1- (length l))"
  (cond
   ((= i index) (cdr l))
   (t (cons (car l) (remove-from-list (cdr l) index (1+ i))))))

(defun remover-subarvore-f (raiz lista f-lista &optional (lista-nova nil) (f-lista-nova nil))
  "Remove de uma lista de nós com uma lista de valores f associados
  todos os nós que pertençam à arvore definida por raiz, inclusivamente a própria raiz"
  (labels ((pertence-a-subarvore (no)
              (cond
               ((null no) nil)
               ((equal (no-pai no) raiz) t)
               (t (pertence-a-subarvore (no-pai no))))))
    (cond
     ((null (car lista)) (list lista-nova f-lista-nova))
     ((or (equal (car lista) raiz) (pertence-a-subarvore (car lista))) (remover-subarvore-f raiz (cdr lista) (cdr f-lista) lista-nova f-lista-nova))
     (t (remover-subarvore-f raiz (cdr lista) (cdr f-lista)
          (append lista-nova (list (car lista))) (append f-lista-nova (list (car f-lista))))))))


(defun merge-ordenado-f (elementos f-elementos lista f-lista)
  "Introduz todos os elementos com valores f não ordenados numa lista ordenada por f (definido por uma lista de elementos e uma de f)
  Devolve uma nova lista de elementos e de valores f corretamente ordenados"
  (cond
   ((null elementos) (list lista f-lista))
   (t (let ((posicao (procura-binaria (car f-elementos) f-lista)))
        (merge-ordenado-f (cdr elementos) (cdr f-elementos) (insere (car elementos) posicao lista) (insere (car f-elementos) posicao f-lista))))))

(defun a*-adicionar-sucessores (sucessores f-sucessores fechados f-fechados abertos f-abertos)
  "Função que implementa o método de inserção de sucessores no algoritmo A*
    devolve uma lista com a nova lista de nós abertos, a nova lista de valores f de abertos,
    a nova lista de nós fechados e a nova lista de valores f de fechados
  Recebe uma lista de nós sucessores, a sua lista de valores f, lista de fechados,
  a sua lista de valores f, lista de abertos e a sua lista de valores f:
    1. Procura por sucessores com estado repetido na lista de abertos e:
        - caso o sucessor tenha valor f menor, remove o nó existente em abertos
          e introduz o sucessor na lista de abertos
        - caso contrário é discartado
    2. Procura por sucessores com estado repetido na lista de fechados e:
      - caso o sucessor tenha valor f menor,remove toda a subarvore
        do no fechado da lista de fechados e introduz o sucessor na lista de abertos
      - caso contrário é discartado
    3. Coloca os restantes sucessores em abertos"
  (cond
   ((null sucessores) (list abertos f-abertos fechados f-fechados))
   (t
    (let* ((sucessor (car sucessores))
           (em-abertos (no-repetido sucessor abertos)))
      (cond
       (em-abertos
        (let* ((indice (indice-elemento-lista (car em-abertos) abertos))
               (f-aberto (nth indice f-abertos)))
          (cond
           ((< (car f-sucessores) f-aberto)
            (let* ((abertos-temp (remove-from-list abertos indice))
                   (f-abertos-temp (remove-from-list f-abertos indice))
                   (merged (merge-ordenado-f (list sucessor) (list (car f-sucessores)) abertos-temp f-abertos-temp)))
              (a*-adicionar-sucessores (cdr sucessores) (cdr f-sucessores)
                                       fechados f-fechados (first merged) (second merged))))
           (t (a*-adicionar-sucessores (cdr sucessores) (cdr f-sucessores)
                                       fechados f-fechados abertos f-abertos)))))
       (t
        (let ((em-fechados (no-repetido sucessor fechados)))
          (cond
           (em-fechados
            (let* ((indice (indice-elemento-lista (car em-fechados) fechados))
                   (f-fechado (nth indice f-fechados)))
              (cond
               ((< (car f-sucessores) f-fechado)
                (let* (
                  (subarvore-removida (remover-subarvore-f (car em-fechados) fechados f-fechados))
                  (merged (merge-ordenado-f (list sucessor) (list (car f-sucessores)) abertos f-abertos)))
                  (a*-adicionar-sucessores (cdr sucessores) (cdr f-sucessores)
                                           (first subarvore-removida) (second subarvore-removida) (first merged) (second merged))))
               (t (a*-adicionar-sucessores (cdr sucessores) (cdr f-sucessores)
                                           fechados f-fechados abertos f-abertos)))))
            (t (let
              (
                (merged (merge-ordenado-f (list sucessor) (list (car f-sucessores)) abertos f-abertos))
              )
              (a*-adicionar-sucessores (cdr sucessores) (cdr f-sucessores)
                                       fechados f-fechados (first merged) (second merged))
            ))

          ))))))))


(defun a* (no objetivo sucessores operadores heuristica)
  (labels ((recursivo (abertos fechados f-abertos f-fechados &optional (numero-nos-gerados 0) (numero-nos-expandidos 1))
              (cond
               ((null abertos) nil)
               (t
                (let ((n (car abertos))(f-n (car f-abertos)))
                  (cond
                   ((funcall objetivo n) (criar-resultado
                                          n
                                          numero-nos-gerados
                                          numero-nos-expandidos))
                   (t
                    (let*
                      (
                        (abertos-sem-n (cdr abertos))
                        (f-abertos-sem-n (cdr f-abertos))
                        (fechados-com-n (append fechados (list n)))
                        (f-fechados-com-n (append f-fechados (list f-n)))
                        (sucessores-n (funcall sucessores n operadores))
                        (f-sucessores-n (avaliar-nos sucessores-n heuristica))
                        (sucessores-adicionados
                          (a*-adicionar-sucessores sucessores-n f-sucessores-n
                                                  fechados-com-n f-fechados-com-n
                                                  abertos-sem-n f-abertos-sem-n)))
                      (recursivo
                       ;;(append abertos-sem-n sucessores-validos)
                       (first sucessores-adicionados)
                       (third sucessores-adicionados)
                       ;;(append f-abertos-sem-n f-sucessores)
                       (second sucessores-adicionados)
                       (fourth sucessores-adicionados)
                       (+ numero-nos-gerados (length sucessores-n))
                       (+ numero-nos-expandidos 1))))))))))

    (recursivo (list no) '() '(0) '())))

; (defun no-pertence-a-subarvore (no raiz)
;               (cond
;                ((null no) nil)
;                ((equal (no-pai no) raiz) t)
;                (t (pertence-a-subarvore (no-pai no) raiz))))

; (defun no-substituir-parentesco (no antecedente-anterior antecedente-novo)
;   (flet
;     ((substituir-parentesco (parentesco)
;       (cond
;         ((null parentesco) nil)
;         ((equal (car parentesco) antedente-anterior) ())
;       )
;     ))
;   )

; )

; (replace-parent-recursively (ls old-parent new-parent &optional new-list replaced)
;   (cond
;     ((and (null new-list)) nil )
;     (())
;   )
; )

(defun avaliar-nos (nos heuristica)
  "Devolve uma lista de avaliações f com base numa lista de nos e uma funcao heuristica
  em que g(n) é a profundidade do no (custo uniforme)"
  (mapcar (lambda (no) (+ (no-profundidade no) (funcall heuristica (no-estado no)))) nos))

(defun a*-menor-custo (abertos f-abertos &optional (menor-no nil) (menor-f nil) (index nil) (i 0))
  "Recebendo uma lista de nos abertos e uma lista de custos f correspondente
  devolve uma lista com o primeiro nó de custo mais baixo, o seu custo f e a
  sua posição nas listas"
  (cond
   ((and (null menor-f) (null menor-no) (null index)) (a*-menor-custo (cdr abertos) (cdr f-abertos) (car abertos) (car f-abertos) i (1+ i)))
   ((null abertos) (list menor-no menor-f index))
   (t
    (cond
     ((< (car f-abertos) menor-f) (a*-menor-custo (cdr abertos) (cdr f-abertos) (car abertos) (car f-abertos) i (1+ i)))
     (t (a*-menor-custo (cdr abertos) (cdr f-abertos) menor-no menor-f index (1+ i)))))))
