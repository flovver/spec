#lang racket

;; Взял с https://rosettacode.org/wiki/Y_combinator#Scheme
(define Y
  (lambda (f)
    ((lambda (g) (g g))
     (lambda (g)       
       (f  (lambda a (apply (g g) a)))))))

;; Макрос, "эмулирующий" семантику self в Flovver.
(define-syntax-rule (combine self args f)
  (Y (lambda (self) (lambda args f))))

;; Факториал, написанный с использованием self
(define fac
  (combine self (x)
           (if (< x 2)
               1
               (* x (self (- x 1))))))

;; Фибоначчи, написанный с использованием self
(define fib
  (combine self (x)
           (if (< x 2)
               x
               (+ (self (- x 1)) (self (- x 2))))))

(fac 10)
(fib 5)
