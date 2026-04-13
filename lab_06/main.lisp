(setf *random-state* (make-random-state T))

(defun roll ()
  (+ (random 6) (random 6) 2))

(defun reroll (res)
  (cond
    ((or (= res 2) (= res 12))
     (cond ((y-or-n-p "Перебросить?") (reroll (roll)))
           (T res)))
    (T res)))

(defun next_player (res)
  (cond
    ((or (= res 7) (= res 11))  (cons res Nil))
     (T (list res (reroll (roll))))))

(defun fin (res)
  (cond
    ((equal (cdr res) Nil)
     (format Nil "Игрок 1 выиграл абсолютно, сумма: ~d ~%" (car res)))
    ((or (eq (cadr res) 7) (eq (cadr res) 11))
     (format Nil "Игрок 2 выиграл абсолютно, сумма: ~d ~%" (cadr res)))
    ((> (car res) (cadr res))
     (format Nil "Игрок 1 выиграл, сумма: ~d ~%" (car res)))
    ((< (car res) (cadr res))
     (format Nil "Игрок 2 выиграл, сумма: ~d ~%" (cadr res)))
    (T (format Nil "Ничья, сумма: ~d ~%" (car res)))))

(defun play ()
  (fin (next_player (reroll (roll)))))

(defun print_res ()
  (princ (play)))

(print_res)
