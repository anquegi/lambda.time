;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :lambda.time
  (:nicknames :time)
  (:use)
  (:export :day-of-the-week-string
           :daylight-savings-p
           :daylight-savings-time-p
           :fixnum-microsecond-time
           :get-time
           :initialize-timebase
           :leap-year-p
           :microsecond-time
           :month-length
           :month-string
           :parse
           :parse-interval-or-never
           :parse-universal-time
           :print-brief-universal-time
           :print-current-date
           :print-current-time
           :print-date
           :print-interval-or-never
           :print-time
           :print-universal-date
           :print-universal-time
           :read-interval-or-never
           :set-local-time
           :timezone-string
           :verify-date ))

(defpackage :lambda.time.internal
  (:use :lambda.time :cl :fiveam)
  (:shadow :internal-time-units-per-second
           :get-internal-run-time
           :get-internal-real-time
           :decode-universal-time
           :encode-universal-time
           :get-decoded-time
           :get-universal-time
           :multiple-value-bind
           :time ))
