(define-module (gong packages haskell-apps)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build utils)
  #:use-module (gnu packages haskell-apps))


(define %distro-root-directory
  (@@ (gnu packages) %distro-root-directory))

(define-public kmonad+
  (package
    (inherit kmonad)
    (name "kmonadX")
    (version "0.4.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/kmonad/kmonad")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ng07i2zb98gx7giz7cjxjx908p1v14wn913k810n550k2gfbvp9"))
       (patches (car
                 (delq '()
                       (map (lambda (d)
                              (let ((d (string-append d "/gong/")))
                                (if (directory-exists? d)
                                    (find-files d
                                                "^kmonad-support-setting-bustype.patch$")
                                    '())))
                            (append %load-path (list %distro-root-directory))))))))))
