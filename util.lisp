(cl:in-package :lambda.time.internal)

(defmacro define-site-variable (name &optional val documentation)
  `(defvar ,name ,val ,documentation))

(defmacro select-processor (&body clauses)
  `(progn ,@(cdr (find :x86-64 clauses :key #'car))))


(defmacro defconst (name val &optional documentation)
  `(defparameter ,name ,val ,documentation))

(defmacro deff (name orig)
  `(setf (symbol-function ',name)
         ,(typecase (eval orig)
            (symbol `(symbol-function ,orig))
            (function orig))))

(defmacro multiple-value (vars vals)
  `(multiple-value-setq ,vars ,vals))

(defun lsh (integer count)
  (ash integer (- count)))

(defun bit-test (x y)
  (logtest x y))

(defparameter *timezone* -9)

(deff ≤ #'cl:<=)
(deff ≥ #'cl:>=)
(deff ≠ #'cl:/=)

(defmacro condition-case (variables body-form &body clauses)
  "Execute BODY-FORM with conditions handled according to CLAUSES.
Each element of CLAUSES is a clause like those used in CASE.
It specifies one or more condition names, and what to do if they are signalled.

If any of the conditions specified in the clauses happens during BODY-FORM,
it is handled by throwing to this level and executing the matching clause.
Within the clause, the first of VARIABLES is bound to the condition-object
that was signaled.
The values of the last form in the clause are returned from CONDITION-CASE.

If none of the conditions occurs, the values of BODY-FORM are returned
from CONDITION-CASE.

If there is a clause with keyword :NO-ERROR, it is executed after BODY-FORM
if conditions are NOT signaled.  During this clause, the variables VARIABLES
are bound to the values produced by BODY-FORM.  The values of the last form
in the clause are returned from CONDITION-CASE."
  ;; Teco madness.
  ;; (declare (zwei:indentation 1 3 2 1))
  `(handler-case ,body-form
     ,@(mapcar (lambda (c)
                 `(,(car c) (,@variables)
                    (declare (ignorable ,@variables))
                    ,@(cdr c)))
               clauses)))

(defmacro without-interrupts (&body body)
  `(#+sbcl sb-sys:without-interrupts
    #-sbcl progn
    ,@body))

(defun putprop (object val ind)
  (setf (get object ind) val)
  (get object ind))

(defmacro defprop (p-list val ind)
  `(putprop ',p-list ',val ',ind))


(defun remainder (x y)
  (cl:rem x y))
'WITH-STACK-LIST

(defmacro FERROR (&rest args)
  `(error ,@args))


(defmacro multiple-value-bind (vars vals &body body)
  (let* ((ignores '())
         (vars (mapcar (lambda (v)
                         (cond ((string= 'NIL v)
                                (let ((sym (gensym "NIL-")))
                                  (push sym ignores)
                                  sym))
                               ((string= 'IGNORE v)
                                (let ((sym (gensym "IGNORE-")))
                                  (push sym ignores)
                                  sym))
                               (T v)))
                       vars)))
    `(cl:multiple-value-bind ,vars ,vals
       ,@(and ignores `((declare (ignore ,@ignores))))
       ,@body)))

(defmacro with-stack-list ((variable &rest elements) &body body)
  `(let ((,variable (list ,@elements)))
     (declare (dynamic-extent ,variable))
     ,@body))

(defmacro with-stack-list* ((variable &rest elements) &body body)
  `(let ((,variable (list* ,@elements)))
     (declare (dynamic-extent ,variable))
     ,@body))


(defmacro defsubst (name (&rest args) &body body)
  `(progn
     (declaim (inline ,name))
     (defun ,name (,@args) ,@body)))

(deff string-length #'cl:length)
(deff time #'cl:get-internal-real-time)
(deff time-difference #'cl:-)

(defun time-increment (time interval)
  (+ time interval))

(defun parse-universal-time
       (string &optional
               (start 0)
               (end nil)
               (futurep t)
               base-time
               must-have-time
               date-must-have-year
               time-must-have-second
               (day-must-be-valid t))
  (declare (ignore start end
                   futurep base-time
                   must-have-time
                   date-must-have-year
                   time-must-have-second
                   day-must-be-valid))
  (parse-integer string))

;;; eof
