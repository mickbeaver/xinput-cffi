(in-package #:xinput-cffi)

(defparameter *xinput-cffi-loaded-p* nil)

(defconstant +error-device-not-connected+          #x48F)
(defconstant +xinput-devtype-gamepad+              #x01)
(defconstant +xinput-devsubtype-gamepad+           #x01)
(defconstant +xinput-caps-voice-supported+         #x0004)
(defconstant +xinput-gamepad-dpad-up+              #x0001)
(defconstant +xinput-gamepad-dpad-down+            #x0002)
(defconstant +xinput-gamepad-dpad-left+            #x0004)
(defconstant +xinput-gamepad-dpad-right+           #x0008)
(defconstant +xinput-gamepad-start+                #x0010)
(defconstant +xinput-gamepad-back+                 #x0020)
(defconstant +xinput-gamepad-left-thumb+           #x0040)
(defconstant +xinput-gamepad-right-thumb+          #x0080)
(defconstant +xinput-gamepad-left-shoulder+        #x0100)
(defconstant +xinput-gamepad-right-shoulder+       #x0200)
(defconstant +xinput-gamepad-a+                    #x1000)
(defconstant +xinput-gamepad-b+                    #x2000)
(defconstant +xinput-gamepad-x+                    #x4000)
(defconstant +xinput-gamepad-y+                    #x8000)
(defconstant +xinput-gamepad-left-thumb-deadzone+  7849)
(defconstant +xinput-gamepad-right-thumb-deadzone+ 8689)
(defconstant +xinput-gamepad-trigger-threshold+    30)
(defconstant +xinput-flag-gamepad+                 #x00000001)

(cffi:defcstruct xinput-gamepad
  (buttons :uint16)
  (left-trigger :uint8)
  (right-trigger :uint8)
  (thumb-lx :int16)
  (thumb-ly :int16)
  (thumb-rx :int16)
  (thumb-ry :int16))

(cffi:defcstruct xinput-state
  (packet-number :uint32)
  (gamepad xinput-gamepad))

(cffi:defcstruct xinput-vibration
  (left-motor-speed :uint16)
  (right-motor-speed :uint16))

(cffi:defcstruct xinput-capabilities
  (type :uint8)
  (sub-type :uint8)
  (flags :uint16)
  (gamepad xinput-gamepad)
  (vibration xinput-vibration))

(cffi:defcstruct guid
  (data1 :uint32)
  (data2 :uint16)
  (data3 :uint16)
  (data4 :uint8 :count 8))

(cffi:defcfun ("XInputGetState" xinput-get-state) :uint32
  (user-index :uint32)
  (state :pointer))                   ; pointer to xinput-state object

(cffi:defcfun ("XInputSetState" xinput-set-state) :uint32
  (user-index :uint32)
  (vibration :pointer))           ; pointer to xinput-vibration object

(cffi:defcfun ("XInputGetCapabilities" xinput-get-capabilities) :uint32
  (user-index :uint32)
  (flags :uint32)
  (capabilities :pointer))     ; pointer to xinput-capabilities object

(cffi:defcfun ("XInputGetDSoundAudioDeviceGuids" xinput-get-dsound-audio-device-guids) :uint32
  (user-index :uint32)
  (dsound-render-guid :pointer)         ; pointer to guid object
  (dsound-capture-guid :pointer))       ; pointer to guid object


(cffi:define-foreign-library xinput-cffi
  (:windows (:or "xinput9_1_0.dll"
                 "xinput.dll")))

(defun load-xinput-cffi-library ()
  (cffi:use-foreign-library xinput-cffi)
  (setf *xinput-cffi-loaded-p* t))

(eval-when (:load-toplevel :execute)
  (load-xinput-cffi-library))


;; (defun stop-vibrate ()
;;   (cffi:with-foreign-object (vibration 'xinput-vibration)
;;     (setf (cffi:foreign-slot-value vibration 'xinput-vibration 'left-motor-speed) 0
;;           (cffi:foreign-slot-value vibration 'xinput-vibration 'right-motor-speed) 0)
;;            (xinput-set-state 0 vibration)))

;; (defun test-vibrate ()
;;   (cffi:with-foreign-object (vibration 'xinput-vibration)
;;     (setf (cffi:foreign-slot-value vibration 'xinput-vibration 'left-motor-speed) 65535
;;           (cffi:foreign-slot-value vibration 'xinput-vibration 'right-motor-speed) 65535)
;;            (xinput-set-state 0 vibration)))
