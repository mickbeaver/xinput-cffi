(asdf:defsystem #:xinput-cffi
  :serial t
  :description "XInput CFFI library"
  :author "Mick Beaver <m.charles.beaver@gmail.com>"
  :license "MIT License"
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "xinput-cffi")))

