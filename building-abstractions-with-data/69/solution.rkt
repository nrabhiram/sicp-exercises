#lang sicp

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (successive-merge leaf-set)
  (define (contains-root-node? set)
    (null? (cdr set)))
  (define (merge set)
    (if (contains-root-node? set)
        (car set)
        (let ((first (car set))
              (second (cadr set))
              (remaining (cddr set)))
          (let ((merged (make-code-tree first second)))
            (merge (adjoin-set merged remaining))))))
  (merge leaf-set))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; Test 1: single symbol
(define single (generate-huffman-tree (list (list 'A 5))))
(display "Test 1 - single symbol: ")
(display (and (leaf? single) (eq? (symbol-leaf single) 'A)))
(newline)

; Test 2: two symbols
(define two (generate-huffman-tree (list (list 'A 3) (list 'B 5))))
(display "Test 2 - two symbols, weight: ")
(display (weight two))
(display ", symbols: ")
(display (symbols two))
(newline)

; Test 3: SICP example (section 2.3.4)
(define sicp-tree
  (generate-huffman-tree
   (list (list 'A 8) (list 'B 3) (list 'C 1)
         (list 'D 1) (list 'E 1) (list 'F 1)
         (list 'G 1) (list 'H 1))))
(display "Test 3 - SICP example, weight: ")
(display (weight sicp-tree))
(display ", symbols: ")
(display (symbols sicp-tree))
(newline)

; Test 4: equal weights - should still produce a valid tree
(define equal-wt
  (generate-huffman-tree
   (list (list 'A 5) (list 'B 5) (list 'C 5) (list 'D 5))))
(display "Test 4 - equal weights, weight: ")
(display (weight equal-wt))
(newline)

; Test 5: case where merged node must be reinserted in the middle
(define tricky
  (generate-huffman-tree
   (list (list 'A 1) (list 'B 2) (list 'C 3) (list 'D 100))))
(display "Test 5 - tricky reinsertion, weight: ")
(display (weight tricky))
(display ", left weight: ")
(display (weight (left-branch tricky)))
(display ", right weight: ")
(display (weight (right-branch tricky)))
(newline)
