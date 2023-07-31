;; commonly used
(define (square a) (* a a))
(define (cube a) (* a a a))
(define (average . args) (/ (apply + args) (length args)))
(define (displayln a)
    (display a)
    (newline))

;; functional ops
(define (filter predicate sequence)
    (cond ((null? sequence) nil)
        ((predicate (car sequence))
        (cons (car sequence)
            (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        nil
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))
(define (fold-right op initial sequence) (accumulate op initial sequence))  ;; 1/(2/(3/1))
(define (fold-left op initial sequence)   ;; ((1/1)/2)/3
    (define (iter result rest)
        (if (null? rest) result
            (iter (op result (car rest))
                (cdr rest))))
    (iter initial sequence))
(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

;; set ops
(define (all-elms-same? elms)
    (accumulate (lambda (x y) (and (equal? x (car elms)) y)) #t elms))
(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
        sequence))


;; tests
(cond ((not (equal? (square 3) 9)) (error "square"))
      ((not (equal? (average 1 2 3 4) 5/2)) (error "average"))
      ((not (equal? (filter even? '(1 2 3 4 5)) '(2 4))) (error "filter"))
      ((not (equal? (accumulate + 0 '(1 2 3 4)) 10)) (error "accumulate"))
      ((not (equal? (all-elms-same? '(1 1 1)) #t)) (error "all-elms-same?"))
      ((not (equal? (remove 2 '(1 2 3)) '(1 3))) (error "remove"))
      (else (display "ok")))