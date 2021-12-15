;;; Metodos seletores

(defun no-estado (no)
  "Obtem o estado do nó"
  (car no))
;; teste: (no-estado (no-teste))
;; resultado: (2 2)

(defun no-profundidade (no)
  "Obtem a profundidade do nó"
  (car (cdr no)))
;; teste: (no-profundidade (no-teste))
;; resultado: 0

(defun no-pai (no)
  "Obtem a profundidade do nó"
  (car (cdr (cdr no))))
;; teste: (no-pai (no-teste))
;; resultado: NIL

;; teste: (sucessores (no-teste) (operadores) 'bfs)
;; resultado: (((0 2) 1 ((2 2) 0 NIL)) ((2 0) 1 ((2 2) 0 NIL)) ((3 2) 1 ((2 2) 0 NIL)) ((2 5) 1 ((2 2) 0 NIL)) ((0 4) 1 ((2 2) 0 NIL)) ((3 1) 1 ((2 2) 0 NIL)))
;; teste: (sucessores (no-teste) (operadores) 'dfs 2)
;; resultado: (((0 2) 1 ((2 2) 0 NIL)) ((2 0) 1 ((2 2) 0 NIL)) ((3 2) 1 ((2 2) 0 NIL)) ((2 5) 1 ((2 2) 0 NIL)) ((0 4) 1 ((2 2) 0 NIL)) ((3 1) 1 ((2 2) 0 NIL)))


(defun abertos-bfs (abertos sucessores)
  "Método BFS de inserção dos sucessores na lista de abertos"
  (append abertos sucessores))

(defun abertos-dfs (abertos sucessores)
  "Método DFS de inserção dos sucessores na lista de abertos"
  (append sucessores abertos))

(defun no-objetivo (objetivo lista)
  "Procura por um nó solução numa lista e devolve"
  (cond
   ((null lista) nil)
   ((funcall objetivo (car lista)) (car lista))
   (t (no-objetivo objetivo (cdr lista)))))

(defun no-repetido (no lista)
  "Verifica se um no com o mesmo estado existe numa lista e devolve a lista começando nesse no"
  (member no lista :test (lambda (a b) (and (equal (no-estado a) (no-estado b))))))



;; '( ((1 1) 0 nil)  ((2 1) 1 (() 0 nil))  ((1 2) 1 (() 0 nil)) ((3 1) 2 ((2 1) 1 (() 0 nil))) ((2 2) 2 ((2 1) 1 (() 0 nil))) ((1 3) 2 ((1 2) 1 (() 0 nil))) )


;; Utils BFS

(defun nos-nao-repetidos (nos lista)
  "Devolve a lista de nos sem os com estado igual na lista fornecida"
  (remove nil (mapcar (lambda (no)
                        (cond
                         ((no-repetido no lista) nil)
                         (t no))) nos)))

;;; Algoritmos
;; procura na largura
;; teste: (bfs (no-teste) 'no-solucaop 'sucessores (operadores) nil nil)
;; resultado: ((3 1) 1 ((2 2) 0 NIL))

; (defun bfs (no objetivo sucessores operadores &optional abertos fechados)
;   (cond
;    ((and (null abertos) (null fechados)) (bfs no objetivo sucessores operadores (list no) nil))
;    ((null abertos) nil)
;    (t
;     (let* ((n (car abertos))
;            (sucessores-n (funcall sucessores n operadores))
;            (m (no-objetivo objetivo sucessores-n)))
;       (cond
;        (m m)
;        (t (bfs no objetivo sucessores operadores
;                (abertos-bfs (cdr abertos) (nos-nao-repetidos sucessores-n (append (cdr abertos) fechados)))
;                (append fechados (list n)))))))))

(defun bfs (no objetivo sucessores operadores) 
  (let (
    (abertos (list no))
    (fechados nil)
    (numero-nos-gerados 0)
    (numero-nos-expandidos 0)
    (n nil)
    (sucessores-n nil)
    (sucessores-nao-repetidos nil)
    (m nil))
    (loop
      (when (null abertos) (return (list
                                      nil
                                      (* (/ numero-nos-gerados numero-nos-expandidos) 1.0)
                                      numero-nos-gerados
                                      numero-nos-expandidos
                                      (* (/ (no-profundidade m) numero-nos-gerados) 1.0))))
      (setq n (car abertos))
      (setq sucessores-n (funcall sucessores n operadores))
      (setq numero-nos-expandidos (1+ numero-nos-expandidos))
      (setq numero-nos-gerados (+ numero-nos-gerados (length sucessores-n)))
      (setq sucessores-nao-repetidos (nos-nao-repetidos sucessores-n (append (cdr abertos) fechados)))
      (setq m (no-objetivo objetivo sucessores-nao-repetidos))
      (when m (return (criar-resultado m numero-nos-gerados numero-nos-expandidos)))
      (setq abertos (abertos-bfs (cdr abertos) sucessores-nao-repetidos))
      (setq fechados (append fechados (list n)))
    )
  )
)

(defun criar-resultado (no numero-nos-gerados numero-nos-expandidos)
  (list 
    no
    (* (/ numero-nos-gerados numero-nos-expandidos) 1.0)
    numero-nos-gerados
    numero-nos-expandidos
    (* (/ (no-profundidade no) numero-nos-gerados) 1.0))
)


; (defun teste () 
;   (let (
;     (a 1)
;     (b 2))
;     (loop
;       (setq a (1+ a))
;       (if (= (mod a 2) 1 ) (setq b (1+ b)))
;       (if (= b 10) (return (list a b)))
;     )
;   )
; )


;; Utils DFS

(defun remover-subarvore (raiz lista)
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
  (cond
   ((null (car a-remover)) lista)
   (t (remover-subarvores (cdr a-remover) (remove nil (remover-subarvore (car a-remover) lista))))))

(defun dfs-adicionar-sucessores (sucessores fechados abertos)

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

;; procura na profundidade
;; teste: (dfs (no-teste) 'no-solucaop 'sucessores (operadores) 10)
;; resultado: ((3 1) 1 ((2 2) 0 NIL))

(defun dfs (no objetivo sucessores operadores profundidade &optional abertos fechados (numero-nos-gerados 0) (numero-nos-expandidos 0) )
  (cond
   ((and (null abertos) (null fechados))
    (dfs no objetivo sucessores operadores profundidade (list no) nil))
   ((null abertos) nil)
   ((= (no-profundidade (car abertos)) profundidade) (dfs no objetivo sucessores operadores profundidade (cdr abertos) (append fechados (list (car abertos)))))
   (t
    (let* ((n (car abertos))
           (sucessores-n (funcall sucessores n operadores))
           (m (no-objetivo objetivo sucessores-n)))
      (cond
       (m (criar-resultado m (+ numero-nos-gerados (length sucessores-n)) (1+ numero-nos-expandidos)))
       (t
        (let ((abertos-fechados-novos (dfs-adicionar-sucessores sucessores-n (append fechados (list n)) (cdr abertos))))
          (dfs no objetivo sucessores operadores profundidade (first abertos-fechados-novos) (second abertos-fechados-novos)
            (1+ numero-nos-gerados) (+ numero-nos-expandidos (length sucessores-n))))))))))

;; A*


(defun insere (e p L)
    "insere um elemento e na posição p de uma lista"
    (cond
        ((zerop p) (append (list e) L))
        ((null L) nil)
        (t (cons (car L) (insere e (1- p) (cdr L))))
    )
)

(defun procura-binaria (n L-ord &optional baixo alto)
  "devolve a posição numa lista ordenada (L-ord) em que n (valor numerico) deve ser colocado"
    (cond
        ((or (null baixo) (null alto)) (procura-binaria n L-ord 0 (1- (length L-ord))))
        ((< alto baixo) baixo)
        (t (let* (
            (mid (floor (/(+ baixo alto) 2)))
            (valor-mid (nth mid L-ord)))
            (cond
                ((> valor-mid n) (procura-binaria n L-ord baixo (1- mid)))
                ((< valor-mid n) (procura-binaria n L-ord (1+ mid) alto))
                (t mid)
            )
            ))
    )
)

(defun remove-from-list (l index &optional (i 0))
  "remove da lista l o elemento de indice index, devolvendo uma lista de dimensão (1- (length l))"
  (cond 
      ((= i index) (cdr l))
      (t (cons (car l) (remove-from-list (cdr l) index (1+ i))))
  )
)

; (defun a*-adicionar-sucessores (sucessores abertos f-abertos fechados f-fechados)
;   ()

; )

(defun merge-ordenado-f (elementos f-elementos lista f-lista)
  (cond 
    ((null elementos) (list lista f-lista))
    (t (let
      ((posicao (procura-binaria (car f-elementos) f-lista)))
      (merge-ordenado-f (cdr elementos) (cdr f-elementos) (insere (car elementos) posicao lista) (insere (car f-elementos) posicao f-lista))
    ))
  )
)

(defun a* (no objetivo sucessores operadores heuristica)
  (labels (
    (recursivo (abertos fechados f-abertos f-fechados &optional (numero-nos-gerados 0) (numero-nos-expandidos 1))
      (cond
        ((null abertos) nil)
        (t
          (let (
            ; (menor-custo (a*-menor-custo abertos f-abertos))
            ; (n (first menor-custo)
              (n (car abertos))
              (f-n (car f-abertos)))
            (cond 
              ((funcall objetivo n) (list 
                                        n
                                        (* (/ numero-nos-gerados numero-nos-expandidos) 1.0)
                                        numero-nos-gerados
                                        numero-nos-expandidos
                                        (* (/ (no-profundidade n) numero-nos-gerados) 1.0)))
              (t
                (let* (
                  ;;(abertos-sem-n (remove-from-list abertos (third menor-custo)))
                  (abertos-sem-n (cdr abertos))
                  ;;(f-abertos-sem-n (remove-from-list f-abertos (third menor-custo)))
                  (f-abertos-sem-n (cdr f-abertos))
                  (sucessores-n (funcall sucessores n operadores))
                  (sucessores-validos (nos-nao-repetidos sucessores-n (append abertos-sem-n fechados)))
                  (f-sucessores (avaliar-nos sucessores-validos heuristica))
                  (merged (merge-ordenado-f sucessores-validos f-sucessores abertos-sem-n f-abertos-sem-n))
                  )
                  (recursivo
                    ;;(append abertos-sem-n sucessores-validos)
                    (first merged)
                    (append fechados (list n))
                    ;;(append f-abertos-sem-n f-sucessores)
                    (second merged)
                    (append f-fechados (list f-n))
                    (+ numero-nos-gerados (length sucessores-n))
                    (+ numero-nos-expandidos 1)
                  )
                )
              )
          ))))
        )
      )

    (recursivo (list no) '() '(0) '())

  )
)

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
  em que g(n) é a profundidade do no"
  (mapcar (lambda (no) (+ (no-profundidade no) (funcall heuristica (no-estado no)))) nos)
)

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
        (t (a*-menor-custo (cdr abertos) (cdr f-abertos) menor-no menor-f index (1+ i)))
      )
    )
  )
)
