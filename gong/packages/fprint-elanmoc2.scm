(define-module (gong packages fprint-elanmoc2)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages freedesktop))


(define-public libfprint-elanmoc2
  (let ((commit "ad2edb4eb0ae2a33b3fb521a43c4554671fe5293")
        (revision "1"))
    (package (inherit libfprint)
             (name "libfprint-elanmoc2")
             (version (git-version "1.94.5" revision commit))
             (source (origin
                      (method git-fetch)
                      (uri (git-reference
                            (url "https://gitlab.freedesktop.org/depau/libfprint.git")
                            (commit commit)))
                      (file-name (git-file-name name version))
                      (sha256
                       (base32 "0nh65xsvzgbzm2zv0chw4wwylcdsrhyxn8bj35hw4598l7ll61ln")))))))

(define-public fprintd-elanmoc2
  (package (inherit fprintd)
           (name "fprintd-elanmoc2")
           (inputs (modify-inputs
                    (package-inputs fprintd)
                    (replace "libfprint" libfprint-elanmoc2)))))
