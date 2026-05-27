#lang sicp

(define (division-name f) (car f))
(define (file-contents f) (cdr f))

(define (get-record employee-name division-file)
  (let ((division
         (division-name division-file))
        (personnel-records
         (file-contents division-file)))
    ((get 'get-record division)
     employee-name
     personnel-records)))

(define (get-salary employee-file)
  (let ((division
         (division-name employee-file))
        (employee-record
         (file-contents employee-file)))
    ((get 'get-salary division)
     employee-record)))

(define (find-employee-record employee-name division-files)
  (if (null? division-files)
      null
      (let ((employee-record
             (get-record
              employee-name
              (car division-files)))
            (remaining-divisions (cdr division-files)))
        (if employee-record
            employee-record
            (find-employee-record
             employee-name remaining-divisions)))))
