;;;; lambda.time.asd -*- Mode: Lisp;-*-

(cl:in-package :asdf)

(defsystem :lambda.time
  :serial t
  :depends-on (:fiveam
               ;; :named-readtables
               )
  :components ((:file "package")
               ;; (:file "readtable")
               (:file "util")
               (:file "lambda.time")))

(defmethod perform ((o test-op) (c (eql (find-system :lambda.time))))
  (load-system :lambda.time)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :lambda.time.internal :lambda.time))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
