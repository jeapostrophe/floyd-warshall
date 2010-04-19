#lang setup/infotab
(define name "Floyd-Warshall")
(define release-notes
  (list '(ul
          (li "Initial release"))))
(define repositories
  (list "4.x"))
(define blurb
  (list "An implementation of an all shortest paths algorithm"))
(define scribblings '(("main.scrbl" ())))
(define primary-file "main.ss")
(define categories '(datastructures))
(define compile-omit-paths '("test.ss"))