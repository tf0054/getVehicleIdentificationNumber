;;
;; OBD2 module
;;
(setv input (bytearray b"7E8 10 14 49 02 01 57 42 41 \r7E8 21 48 54 37 31 30 35 30 \r7E8 22 35 4A 33 36 34 33 33 \r\r>"))

(defn getBytes [lines n x]
  (cut (.split (nth lines n)) x)
)

(defn parseVinBuf [buf]
  (setv lines
    (-> buf 
        (.replace b"\r\r>" b"")
        (.split b"\r") ) )

  (+ (getBytes lines 0 6)
     (getBytes lines 1 2)
     (getBytes lines 2 2) )
)

(defn getVin [resultBytes]
  (.join "" (list
    (map
      (fn [x] (chr (int (.decode x) 16)))
      resultBytes)
    ))
)

(defmain [&rest args]
  (print (getVin (parseVinBuf input))))
