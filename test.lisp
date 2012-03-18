(cl:in-package :lambda.time.internal)

(def-suite lambda.time)

(in-suite lambda.time)

(defun ut= (x &rest s-m-h-etc)
  (= (parse-universal-time x)
     (apply #'encode-universal-time s-m-h-etc)))



(test parse-universal-time
  (is (ut= "March 15, 1960"
           0 0 0 15 3 1960))
  (is (ut= "15 March 1960"
           0 0 0 15 3 1960))
  (is (ut= "3/15/60"
           0 0 0 15 3 2060))
  (is (ut= "15/3/60"
           0 0 0 15 3 2060))
  (is (ut= "3-15-60"
           0 0 0 15 3 2060))
  (is (ut= "15-3-60"
           0 0 0 15 3 2060))
  (is (ut= "3-15"
           0 0 0 15 3 2060))
  ;; (is (ut=
  ;;          0 0 0 15 3 2060))
  ;; (is (ut=
  ;;          0 0 0 15 3 2060))
  ;; (is (ut=
  ;;          0 0 0 15 3 2060))
  ;; (is (ut=
  ;;          0 0 0 15 3 2060))
  ;; (is (ut=
  ;;          0 0 0 15 3 2060))
  )

#|(remove-if (lambda (x)
             (second x))
           (mapcar (lambda (x)
          (list x (ignore-errors (multiple-value-list (parse-universal-time x)))))
        '("March 15, 1960" "15 March 1960" "3/15/60" "15/3/60" "3/15/1960"
          "3-15-60" "15-3-1960" "3-15" "3-March-60" "3-Mar-60" "March-3-60"
          "1130." "11:30" "11:30:17" "11:30 pm" "11:30 AM" "1130" "113000"
          "11.30" "11.30.00" "11.3" "11 pm" "12 noon"
          "midnight" "m" "Friday, March 15, 1980" "6:00 gmt" "3:00 pdt"
          "15 March 60" "15 march 60 seconds"
          "Fifteen March 60" "The Fifteenth of March, 1960;"
          "Thursday, 21 May 1981, 00:27-EDT"
          "One minute after March 3, 1960"
          "Three days ago" "5 hours ago"
          "Two days after March 3, 1960"
          "Three minutes after 23:59:59 Dec 31, 1959"
          "Now" "Today" "Yesterday" "two days after tomorrow"
          "one day before yesterday" "the day after tomorrow"
          "half past noon"
          "half a minute past noon"
          "20 past noon"
          "a quarter of an hour from now"
          "2.5 days from now"
          "2.5 hours after tomorrow"
          ".5 days from now"
          "2 and a half days from now"
          "2 hours and 20 minutes from tomorrow"
          "5h3m from tomorrow"
          ;; Leave these last in case server is down!
          "my birthday" "the day before my birthday"
          "1 hour before dlw's birthday"
          )))|#
#|(("my birthday" NIL) ("the day before my birthday" NIL)
 ("1 hour before dlw's birthday" NIL))|#

;;; eof

(parse-universal-time "now")
