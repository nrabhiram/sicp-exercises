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

(define (includes symbol symbols)
  (cond ((null? symbols) #f)
        ((eq? symbol (car symbols)) #t)
        (else (includes symbol (cdr symbols)))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((includes symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((includes symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "symbol doesn't exist in the tree: " symbol))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define 1950s-rock-alphabet
  (generate-huffman-tree
   (list (list 'A 2)
         (list 'GET 2)
         (list 'SHA 3)
         (list 'WAH 1)
         (list 'BOOM 1)
         (list 'JOB 2)
         (list 'NA 16)
         (list 'YIP 9))))

(define rock-message
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

(define encoded-message (encode rock-message 1950s-rock-alphabet))

(display "Encoded bits: ") (display (length encoded-message)) (newline)
(display "Message length: ") (display (length rock-message)) (newline)
(display "Fixed-length bits: ") (display (* 3 (length rock-message))) (newline)
(display "Decoded: ") (display (decode encoded-message 1950s-rock-alphabet)) (newline)
