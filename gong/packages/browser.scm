(define-module (gong packages browser)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (nongnu packages mozilla))

(define-public firefox+
  (package
    (inherit firefox)
    (name "firefoX")
    (arguments
     (substitute-keyword-arguments arguments
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-before 'configure 'disable-require-signing
              (lambda _
                (setenv "MOZ_REQUIRE_SIGNING" "")))))))))
