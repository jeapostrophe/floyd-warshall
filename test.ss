#lang scheme
(require (planet wmfarr/simple-matrix/matrix-base)
         "test.ss")

(define-struct edge (end weight))

(define-struct graph (adj))

(define (create-graph)
  (make-graph (make-hasheq)))

(define (graph-add! g start end [weight 0])
  (hash-update! (graph-adj g)
                start
                (lambda (old)
                  (list* (make-edge end weight) old))
                empty))

(define (graph-shortest-paths g)
  (define adj (graph-adj g))
  (shortest-paths 
   (apply max (hash-map adj (lambda (k v) k)))
   (lambda (i j)
     (if (= i j)
         (make-path 0 empty)
         (local 
           [(define e
              (findf (lambda (e) (= (edge-end e) j))
                     (hash-ref adj i empty)))]
           (if e
               (make-path (edge-weight e) (list e))
               (make-path +inf.0 empty)))))))

(define g (create-graph))
(graph-add! g 1 2 4)
(graph-add! g 1 4 1)
(graph-add! g 2 1 74)
(graph-add! g 2 3 2)
(graph-add! g 2 5 12)
(graph-add! g 3 2 12)
(graph-add! g 3 10 12)
(graph-add! g 3 6 74)
(graph-add! g 4 7 22)
(graph-add! g 4 5 32)
(graph-add! g 5 8 33)
(graph-add! g 5 4 66)
(graph-add! g 5 6 76)
(graph-add! g 6 10 21)
(graph-add! g 6 9 11)
(graph-add! g 7 3 12)
(graph-add! g 7 8 10)
(graph-add! g 8 7 2)
(graph-add! g 8 9 72)
(graph-add! g 9 10 7)
(graph-add! g 9 6 31)
(graph-add! g 9 8 18)
(graph-add! g 10 6 8)

(define m (graph-shortest-paths g))

(define (graph-shortest-path i j)
  (map edge-end (path-edges (matrix-ref m i j))))

(define n 10)
(for* ([i (in-range 1 (add1 n))]
       [j (in-range 1 (add1 n))])
  (printf "~a to ~a: ~a~n" i j (graph-shortest-path i j)))