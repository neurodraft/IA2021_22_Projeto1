;;; Blockus
;;; variaveis de teste e operadores

(defun tabuleiro-vazio () 
    '(
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0))
)

(defun tabuleiro-problema () 
    '(
      (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
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
      (2 2 2 2 2 2 2 2 2 2 2 2 2 2))
)

(defun tabuleiro-teste () 
    '(
      (1 1 0 0 1 0 0 0 0 0 0 0 0 0)
      (1 1 0 0 1 1 0 0 0 0 0 0 0 0)
      (0 0 1 1 0 1 0 0 0 0 0 0 0 0)
      (0 1 1 0 1 0 0 0 1 1 0 0 0 0)
      (0 0 0 0 0 1 0 1 1 0 0 0 0 0)
      (0 0 0 0 0 1 1 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 1 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0))
)

(defun no-teste ()
  "Define um no teste de Blockus em que o tabuleiro ? vazio, a mao tem a quantidade de pecas inicial, profundidade=0 e pai=NIL"
  (list (list (tabuleiro-teste) '(10 10 15)) 0 nil))

(defun no-problema ()
  "Define um no teste de Blockus em que o tabuleiro ? o primeiro problema, a mao tem a quantidade de pecas inicial, profundidade=0 e pai=NIL"
  (list (list (tabuleiro-problema) '(10 10 15)) 0 nil))

(defun no-vazio ()
  "Define um no teste de Blockus em que o tabuleiro ? vazio, a mao tem a quantidade de pecas inicial, profundidade=0 e pai=NIL"
  (list (list (tabuleiro-vazio) '(10 10 15)) 0 nil))

(defun peca-c-h ()
    "Pe?a C horizontal descrita como uma matriz 3x2 e uma lista de 4 desloca??es
    cada desloca??o ? descrita com uma lista de direc?es diagonais de contato e um offset em x e y
    da forma da pe?a relativamente a posicao no tabuleiro"
    '(
        (
            (0 1 1)
            (1 1 0)
        )
        (
            ((sup-esq) (-1 0))
            ((sup-dir inf-dir) (-2 0))
            ((inf-dir) (-1 -1))
            ((inf-esq sup-esq) (0 -1))
        )
    )
)

(defun peca-c-v ()
    "Pe?a C vertical descrita como uma matriz 2x3 e uma lista de 4 desloca??es
    cada desloca??o ? descrita com uma lista de direc?es diagonais de contato e um offset em x e y
    da forma da pe?a relativamente a posicao no tabuleiro"
    '(
        (
            (1 0)
            (1 1)
            (0 1)
        )
        (
            ((sup-dir) (-1 -1))
            ((inf-dir inf-esq) (-1 -2))
            ((inf-esq) (0 -1))
            ((sup-esq sup-dir) (0 0))
        )
    )
)

(defun peca-a ()
    "Pe?a A descrita como uma matriz 1x1 e uma lista de 1 desloca??es
    cada desloca??o ? descrita com uma lista de direc?es diagonais de contato e um offset em x e y
    da forma da pe?a relativamente a posicao no tabuleiro"
    '(
        (
            (1)
        )
        (
            ((sup-dir inf-dir inf-esq sup-esq) (0 0))
        )
    )
)

(defun peca-b ()
    "Pe?a B descrita como uma matriz 2x2 e uma lista de 4 desloca??es
    cada desloca??o ? descrita com uma lista de direc?es diagonais de contato e um offset em x e y
    da forma da pe?a relativamente a posicao no tabuleiro"
    '(
        (
            (1 1)
            (1 1)
        )
        (
            ((sup-dir) (-1 0))
            ((inf-dir) (-1 -1))
            ((inf-esq) (0 -1))
            ((sup-esq) (0 0))
        )
    )
)

(defun operadores ()
    "Devolve os simbolos relativos ?s 4 pe?as concretas do jogo"
    (list 'peca-a  'peca-b 'peca-c-h 'peca-c-v)
)

;;; M?todos auxiliares

(defun obter-vizinhanca (tabuleiro x y)
    "Obtem uma matriz 3x3 que representa a vizinhan?a de uma c?lula no tabuleiro
    Representa espa?os fora do tabuleiro com o valor -1"
    (labels (
        (recursive (tabuleiro i)
            (cond 
                ((null tabuleiro) nil)
                ((and (listp (car tabuleiro)) (> (abs (- i y)) 1)) (cons nil (recursive (cdr tabuleiro) (1+ i))))
                ((and (listp (car tabuleiro)) (<= (abs (- i y)) 1)) (cons  (recursive (car tabuleiro) 0) (recursive (cdr tabuleiro) (1+ i))))
                ((null (car tabuleiro)) nil)
                (t 
                    (cond
                        ((<= (abs (- i x)) 1) (cons (car tabuleiro) (recursive (cdr tabuleiro) (1+ i))))
                        (t (cons nil (recursive (cdr tabuleiro) (1+ i))))
                    )
                )
            )
        )
    ) 
    (let* 
        (
            (obtidos (mapcar (lambda (linha) (remove nil linha)) (remove nil (recursive tabuleiro 0) )))
            (obtidos-colunas-corrigidas
                (cond 
                    ((= (length (car obtidos)) 2)
                        (cond
                            ((= x 0) (mapcar (lambda (linha)
                                (cons -1 linha)
                            ) obtidos))
                            (t (mapcar (lambda (linha) 
                                (append linha '(-1))
                            ) obtidos))
                        )
                    )
                    (t obtidos)
                )
            )
            (obtidos-linhas-corrigidas
                (cond
                    ((= (length obtidos-colunas-corrigidas) 2) 
                        (cond
                            ((= y 0) (cons '(-1 -1 -1) obtidos-colunas-corrigidas))
                            (t (append obtidos-colunas-corrigidas '((-1 -1 -1))))
                        )
                    )
                    (t obtidos-colunas-corrigidas)
                )
            )
        )
        obtidos-linhas-corrigidas
    )
    ) 
)

(defun espacos-validos (tabuleiro)
    "Procura espa?os validos para jogar no tabuleiro
    Devolve lista de listas com par de coordenadas e lista de dire??es diagonais de contacto
    (sup-esq, sup-dir, inf-esq, inf-dir)"
    (labels
        (
            (recursive (_tabuleiro x y)
                (cond
                    ((null _tabuleiro) nil)
                    ((listp (car _tabuleiro)) (append  (recursive (car _tabuleiro) 0 y) (recursive (cdr _tabuleiro) 0 (1+ y))))
                    ((null (car _tabuleiro)) nil)
                    (t 
                        (cond 
                            ((/= (car _tabuleiro) 0) (append nil (recursive (cdr _tabuleiro) (1+ x) y)))
                            (t 
                                (let*
                                    (
                                        (vizinhanca (obter-vizinhanca tabuleiro x y))
                                        ;; Verificar se n?o existem pe?as colocadas nas laterais
                                        ;; e existe pelo menos uma pe?a nas diagonais
                                        (decisao (and 
                                            (not (or 
                                                (= (second (first vizinhanca)) 1)
                                                (= (first (second vizinhanca)) 1)
                                                (= (third (second vizinhanca)) 1)
                                                (= (second (third vizinhanca)) 1)
                                                ))
                                            (or
                                                (= (first (first vizinhanca)) 1)
                                                (= (third (first vizinhanca)) 1)
                                                (= (first (third vizinhanca)) 1)
                                                (= (third (third vizinhanca)) 1)
                                            )
                                            ))
                                        (direcoes-de-contato
                                            (remove nil (cons (if (= (first (first vizinhanca)) 1) 'sup-esq nil) 
                                                (cons (if (= (third (first vizinhanca)) 1) 'sup-dir nil) 
                                                    (cons (if (= (first (third vizinhanca)) 1) 'inf-esq nil) 
                                                        (cons (if (= (third (third vizinhanca)) 1) 'inf-dir nil) nil)))))
                                        )
                                    ) 
                                    (append (if decisao (list (list (list x y) direcoes-de-contato)) nil) (recursive (cdr _tabuleiro) (1+ x) y))
                                )
                            )
                        )
                    
                    )
                )
            )
        )
        (cond
            ((tabuleiro-vaziop tabuleiro) '(((0 0) (sup-esq))))
            (t (recursive tabuleiro 0 0))
        )
        
    )
)

(defun tabuleiro-vaziop (tabuleiro)
    "Fun??o que avlia se um tabuleiro fornecido n?o tem pe?as colocadas"
    (cond
        ((null tabuleiro) t)
        ((listp (car tabuleiro)) (and (tabuleiro-vaziop (car tabuleiro)) (tabuleiro-vaziop (cdr tabuleiro))))
        ((/= (car tabuleiro) 1) (and t (tabuleiro-vaziop (cdr tabuleiro))))
        (t nil)
    )
)

(defun deslocacoes-peca (peca)
    "Obtem a lista de desloca??es (offsets) da pe?a relativamente aos pontos de contacto"
    (car (cdr peca))
)

(defun eliminar-duplicados (L)
    "Elimina elementos duplicados numa lista L"
  (cond ((null L) L)
        ((member (car L) (cdr L) :test #'equal)
         (eliminar-duplicados (cdr L)))
        (t (cons (car L) (eliminar-duplicados (cdr L))))))

(defun potenciais-colocacoes-com-peca ( posicoes peca)
    "Obtem uma lista de potenciais coloca??es da pe?a no tabuleiro
    que deve ainda ser testada na pr?tica"
    (eliminar-duplicados (apply #'append (mapcar (lambda (posicao)
             (remove nil (potenciais-colocacoes  posicao (deslocacoes-peca peca)))
        )
     posicoes)))
)

(defun potenciais-colocacoes (posicao deslocacoes)
    "Devolve a resolu??o em coloca??es concretas da pe?a ao comparar a lista de deslocacoes da pe?a
    com os contatos da posicao recebida."
    (cond
        ((null deslocacoes) nil)
        ((lista-contem-todos (first (car deslocacoes)) (second posicao)) (let 
            (
                (x (+ (first (first posicao)) (first (second (car deslocacoes)))))
                (y (+ (second (first posicao)) (second (second (car deslocacoes)))))
            )
            (cond
                ((or (< x 0) (< y 0)) (cons nil (potenciais-colocacoes posicao (cdr deslocacoes))))
                (t (cons (list x y) (potenciais-colocacoes posicao (cdr deslocacoes))))
            )
        ))
        (t (cons nil (potenciais-colocacoes posicao (cdr deslocacoes))))
    )
)

(defun lista-contem-todos (lista elementos)
    "Verifica se a lista recebida cont?m todos os elementos"
    (cond
        ((null elementos) t)
        ((member (car elementos) lista) (and t (lista-contem-todos  lista (cdr elementos))))
        (t nil)
    )
)

(defun potenciais-colocacoes-por-peca (estado operadores)
    "Obt?m todas as potenciais coloca??es por pe?a no tabuleiro considerando as pe?as restantes na m?o.
    Todas as coloca??es devolvidas devem primeiro ser testadas em pr?tica.
    Devolve lista de listas com operador e uma lista de potencias coloca??es em listas de coordenas x y."
    (let
        (
            (posicoes-validas (espacos-validos (first estado)))
        )
        (mapcar (lambda (operador)
            (cond
                ((tem-peca operador (second estado)) (list operador (potenciais-colocacoes-com-peca posicoes-validas (funcall operador))))
                (t nil)            
            )
            
        ) operadores)
    )
)

(defun tem-peca (peca mao)
    "Valida se uma pe?a existe na m?o do jogador"
    (cond
        ((equal peca 'peca-a) (> (first mao) 0))
        ((equal peca 'peca-b) (> (second mao) 0))
        ((or (equal peca 'peca-c-h) (equal peca 'peca-c-v)) (> (third mao) 0))
        (t nil)
    )
)


(defun peca-casas-ocupadas (x y peca)
    "Retorna uma lista de listas de coordenas que s?o as casa ocupadas concretamente de jogar
    a pe?a nas posi??es x y"
  (labels
    (
      (recursivo (matriz-peca i j)
        (cond
          ((null (car matriz-peca)) nil)
          ((listp (car matriz-peca)) (append (recursivo (car matriz-peca) 0 j) (recursivo (cdr matriz-peca) 0 (1+ j))))
          (t 
            (cond
              ((= (car matriz-peca) 1) (cons (list (+ x i) (+ y j)) (recursivo (cdr matriz-peca) (1+ i) j)))
              (t (cons nil (recursivo (cdr matriz-peca) (1+ i) j)))
            )
          )
        )
      )
    )
    (remove nil (recursivo (first peca) 0 0))
  )
)

(defun celula (row col tabuleiro)
    "Retorna uma celula na linha e coluna do tabuleiro"
  (nth col (nth row tabuleiro)))

(defun substituir-posicao (idx line &optional (value 1))
    "Substitui a c?lula na posi??o idx da linha recebida pelo valor"
  (labels ((recursive (current)
              (cond ((null (nth current line)) nil)
                    ((= current idx) (cons value (recursive (1+ current))))
                    (t (cons (nth current line) (recursive (1+ current)))))))
    (recursive 0))
)

(defun substituir (row col tabuleiro &optional (value 1))
    "Substitui a c?lula na posi??o row col recebida pelo valor"
  (labels ((recursive (current)
              (cond ((null (nth current tabuleiro)) nil)
                    ((= current row) (cons (substituir-posicao col (nth current tabuleiro) value) (recursive (1+ current))))
                    (t (cons (nth current tabuleiro) (recursive (1+ current)))))))
    (recursive 0))
)

(defun valida-casas (tabuleiro casas)
    "Valida se ? poss?vel jogar no tabuleiro nas casas"
    (cond
        ((null casas) t)
        ((or (> (first (car casas)) 13) (> (second (car casas)) 13)
            (< (first (car casas)) 0) (< (second (car casas)) 0)
        ) nil)
        (t 
            (let ((vizinhanca (obter-vizinhanca tabuleiro (first (car casas)) (second (car casas)))))
                (and
                    (and (= (second (second vizinhanca)) 0)
                        (not (or 
                            (= (second (first vizinhanca)) 1)
                            (= (first (second vizinhanca)) 1)
                            (= (third (second vizinhanca)) 1)
                            (= (second (third vizinhanca)) 1)
                        ))
                    )
                (valida-casas tabuleiro (cdr casas)) )
            )
        )
    )
)

(defun list-0-to-n (n)
    "Devolve uma lista de 0 a n"
    (cond 
        ((< n 0) nil)
        (t (append (list-0-to-n (1- n)) (list n))) 
    )
)

(defun remove-from-list (l index &optional (i 0))
  "Remove da lista l o elemento de indice index, devolvendo uma lista de dimens?o (1- (length l))"
    (cond 
        ((= i index) (cdr l))
        (t (cons (car l) (remove-from-list (cdr l) index (1+ i))))
    )
)

(defun shuffle-list (l &optional (shuffled-list nil) (indexes nil) (init nil))
    "Baralha a lista l aleat?riamente"
    (cond
        ((null init) (shuffle-list l shuffled-list (list-0-to-n (1- (length l))) t ))
        ((null indexes) shuffled-list)
        (t
            (let* ((random-n (random (length indexes)))
                    (random-index (nth random-n indexes)))

                (shuffle-list l (cons (nth random-index l) shuffled-list) (remove-from-list indexes random-n) init)        
            ) 
        )
    )
)

(defun sucessores (no operadores)
    "Com base no n? e nos operadores dispon?veis, devolve uma lista de sucessores v?lidos"
    (shuffle-list (apply #'append (mapcar (lambda (peca-colocacoes)  
        (remove nil (mapcar (lambda (colocacao)
            (let ((casas-ocupadas (peca-casas-ocupadas (first colocacao) (second colocacao) (funcall (first peca-colocacoes)))))
                (cond 
                    ((valida-casas (first (no-estado no)) casas-ocupadas)
                        (list
                            (list
                                (ocupar-casas (first (no-estado no)) casas-ocupadas)
                                (atualizar-mao (second (no-estado no)) (first peca-colocacoes)))
                            (1+ (no-profundidade no))
                            no))
                    (t nil)
                )
            )
        ) (second peca-colocacoes)))
    ) (potenciais-colocacoes-por-peca (no-estado no) operadores ))))
)

(defun ha-jogadas-validas (no)
    "Verifica se ? poss?vel colocar mais alguma pe?a das disponiveis no tabuleiro"
    (eval (cons 'or  (apply #'append (mapcar (lambda (peca-colocacoes)  
        (mapcar (lambda (colocacao)
            (let ((casas-ocupadas (peca-casas-ocupadas (first colocacao) (second colocacao) (funcall (first peca-colocacoes)))))
                (valida-casas (first (no-estado no)) casas-ocupadas)
                ;;casas-ocupadas
            )
        ) (second peca-colocacoes))
    ) (potenciais-colocacoes-por-peca (no-estado no) (operadores) )))))
)

(defun atualizar-mao (mao peca-jogada)
    "Devolve uma nova m?o sem a pe?a jogada"
    (cond
        ((equal peca-jogada 'peca-a) (list (1- (first mao)) (second mao) (third mao)))
        ((equal peca-jogada 'peca-b) (list (first mao) (1- (second mao)) (third mao)))
        ((or (equal peca-jogada 'peca-c-h) (equal peca-jogada 'peca-c-v)) (list (first mao) (second mao) (1- (third mao))))
    )
)


(defun ocupar-casas (tabuleiro casas)
    "Imprime a pe?a sobre o tabuleiro, devolvendo um novo tabuleiro"
    (cond
        ((null casas) tabuleiro)
        (t (ocupar-casas (substituir (second (car casas)) (first (car casas)) tabuleiro 1) (cdr casas)))
    )
)


;;; Construtores

(defun criar-no-inicial-blockus (tabuleiro)
    "Recebe um tabuleiro/problema e constroi um n? inicial com uma m?o de 35 pe?as de 3 tipos, profundidade 0
    e pai nil"
  (list (list tabuleiro '(10 10 15)) 0 nil))


;;; Funcoes auxiliares da procura


(defun no-solucaop (no minimo-casas-preenchidas)
  "Determina se um n? ? solu??o"
  (cond
    ((>= (contar-casas-preenchidas (first (no-estado no))) minimo-casas-preenchidas)
        (cond
            ((= (apply #'+ (second (no-estado no))) 0) t)
            ((not (ha-jogadas-validas no)) t)
            (t nil)))
    (t nil)
  )
)

(defun criar-funcao-objetivo (minimo-casas-preenchidas)
    "Constroi e devolve uma fun??o lambda objetivo. Permite variar o n?mero minimo de casas preenchidas."
    (lambda (no) (funcall #'no-solucaop no minimo-casas-preenchidas))
)

(defun criar-funcao-heuristica-base (minimo-casas-a-preencher)
    "Constroi e devolve uma fun??o lambda heuristica base. Permite variar o n?mero minimo de casas preenchidas."
    (lambda (estado) (funcall #'heuristica-base estado minimo-casas-a-preencher))
)

(defun heuristica-base (estado minimo-casas-a-preencher)
    "Fun??o heuristica base definida como o numero de casas restantes para alcan?ar o minimo de casas
    preenchidas especificadas pelo problema"
    (- minimo-casas-a-preencher (contar-casas-preenchidas (first estado)))
)

(defun heuristica-original (estado)
    "Fun??o heuristica original definida como o numero de casas vazias que conectam lateralmente com
    outras casas vazias"
    (contar-casas-vazias-nao-sozinhas (first estado))
)

(defun contar-casas-vazias-nao-sozinhas (tabuleiro)
    "Devolve o numero de casas no tabuleiro vazias que conectam lateralmente com outras casas vazias"
    (labels
        ((recursivo (x y) 
            (cond
                ((> y 13) 0)
                ((< x 14) (cond ((= (celula y x tabuleiro) 0)
                    (let ((vizinhanca (obter-vizinhanca tabuleiro x y)))
                        (if (or 
                                (= (second (first vizinhanca)) 0)
                                (= (first (second vizinhanca)) 0)
                                (= (third (second vizinhanca)) 0)
                                (= (second (third vizinhanca)) 0))
                            (+ 1 (recursivo (1+ x) y))
                            (recursivo (1+ x) y)
                        )
                    )) (t (recursivo (1+ x) y))
                ))
                (t (recursivo 0 (1+ y)))
            )
        ))
        (recursivo 0 0)
    )
)

(defun contar-casas-preenchidas (tabuleiro)
    "Devolve o numro de casas preenchidas pelo jogador no tabuleiro"
    (cond 
        ((null tabuleiro) 0)
        ((listp (car tabuleiro)) (+ (contar-casas-preenchidas (car tabuleiro))
                                    (contar-casas-preenchidas (cdr tabuleiro))))
        (t
            (cond 
                ((= (car tabuleiro) 1) (+ 1 (contar-casas-preenchidas (cdr tabuleiro))))
                (t (contar-casas-preenchidas(cdr tabuleiro)))
            )
        )
    )
)