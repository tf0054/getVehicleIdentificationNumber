#!/usr/bin/env hy

(import time)
(import serial)
(import [convVIN [*]])

(defn getVinBuf [ser]
  (do (.write ser (.encode "09025\r"))
      (.flush ser)

  (setv buf (bytearray))

  (while True
    ;;(.sleep time 0.01)
    (setv state (.read ser 1)) ;; let isnt defined in hy.
    (.extend buf state)
    (if (in b">" buf)
       (break)) )

  (getVin (parseVinBuf buf)) )
)

(with ;; [ser (.Serial serial "/dev/ttyUSB0" 38400)]
  [ser (.Serial serial :port "/dev/ttyUSB0" :baudrate 38400 :xonxoff True)]
  (print (getVinBuf ser))
)
