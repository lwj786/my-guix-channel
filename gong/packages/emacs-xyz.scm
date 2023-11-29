(define-module (gong packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:))


(define-public emacs-spacious-padding
  (let ((commit "55b9e26d58c006389e43de27cdc2903b7bbd4338")
        (revision "1"))
    (package
     (name "emacs-spacious-padding")
     (version (git-version "0.2.2" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.sr.ht/~protesilaos/spacious-padding")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "1w44y4jxxivf1l07d0ngvz1g0zarvd86hjmfx53fl7h8ni7pf58i"))))
     (build-system emacs-build-system)
     (home-page "https://git.sr.ht/~protesilaos/spacious-padding")
     (synopsis "Increase the padding/spacing of GNU Emacs frames and windows")
     (description
      "This package provides a global minor mode to increase the spacing/padding of Emacs windows and frames.")
     (license license:gpl3))))
