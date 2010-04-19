#lang scheme
(require (planet wmfarr/simple-matrix/matrix-base))

(define-struct path (cost edges))

(define (path-min p0 p1)
  (if ((path-cost p0) . <= . (path-cost p1))
      p0
      p1))

(define (path-add p0 p1)
  (make-path 
   (+ (path-cost p0) (path-cost p1))
   (append (path-edges p0) (path-edges p1))))

(define (shortest-paths n- edge-cost)
  (define n (add1 n-))
  (define m
    (for*/matrix 
     n n 
     ([i (in-range 0 n)]
      [j (in-range 0 n)])
     (edge-cost i j)))
  (for* ([k (in-range 0 n)]
         [i (in-range 0 n)]
         [j (in-range 0 n)])
    (matrix-set! 
     m i j
     (path-min (matrix-ref m i j)
               (path-add (matrix-ref m i k)
                         (matrix-ref m k j)))))
  m)

(provide/contract
 [struct path ([cost number?]
               [edges (listof any/c)])]
 [shortest-paths (exact-integer? (exact-integer? exact-integer? . -> . path?) . -> . matrix?)])