#lang sicp

(list 1 (list 2 (list 3 4)))

(cons 1
      (cons (cons 2
                  (cons (cons 3 (cons 4 nil))
                        nil))
            nil))
