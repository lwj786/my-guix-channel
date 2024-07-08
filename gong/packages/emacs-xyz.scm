(define-module (gong packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages xorg))


(define-public emacs-4me
  (package
    (inherit emacs)
    (name "emacs-4me")
    (inputs (modify-inputs (package-inputs emacs)
              (prepend
               libxrender
               libxt)))))

(define-public emacs-exwm-4me
  (package
    (inherit emacs-exwm)
    (name "emacs-exwm-4me")
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-exwm)
       ((#:emacs _) emacs-4me)))))


(define-public emacs-citre-next
  (let ((commit "7c9c77276cc7dfcb77640df7d589eaac3198cfee")
        (revision "1"))
    (package (inherit emacs-citre)
             (name "emacs-citre-next")
             (version (git-version "0.4.1" revision commit))
             (source (origin
                       (method git-fetch)
                       (uri (git-reference
                             (url "https://github.com/universal-ctags/citre")
                             (commit commit)))
                       (file-name (git-file-name name version))
                       (sha256
                        (base32 "1x5kxlzhzr2x4cszcqaxcg2lc71nwmmfnm2vzx7iz7h74hn4f1ld")))))))


(define-public emacs-highlight-parentheses
  (let ((commit "965b18dd69eff4457e17c9e84b3cbfdbfca2ddfb")
        (revision "1"))
    (package
     (name "emacs-highlight-parentheses")
     (version (git-version "2.2.2" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.sr.ht/~tsdh/highlight-parentheses.el")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0wvhr5gzaxhn9lk36mrw9h4qpdax5kpbhqj44745nvd75g9awpld"))))
     (build-system emacs-build-system)
     (home-page "https://git.sr.ht/~tsdh/highlight-parentheses.el")
     (synopsis "Highlights parentheses surrounding point in Emacs")
     (description
      "`highlight-parentheses.el` dynamically highlights the parentheses surrounding point based on nesting-level using configurable lists of colors, background colors, and other properties.")
     (license license:gpl3+))))


(define-public emacs-maple-translate
  (let ((commit "dfd0eae6486d62c26a3fa3fb07ee7e5f4640eb16")
        (revision "1"))
    (package
     (name "emacs-maple-translate")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/honmaple/emacs-maple-translate")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "13kmgwcp9kha4dqy5ak811m2y1qqp9s23m2r4rrjsjbmaxg7xkwg"))))
     (build-system emacs-build-system)
     (home-page "https://github.com/honmaple/emacs-maple-translate")
     (synopsis "Translate word between chinese and english")
     (description
      "Translate word between chinese and english.")
     (license license:gpl3+))))


(define-public emacs-posframe-plus
  (let ((commit "9b6c5c51926f9b315ae1cca923e84f7a8244872d")
        (revision "1"))
    (package
     (name "emacs-posframe-plus")
     (version (git-version "0.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/zbelial/posframe-plus")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0v6avkbfkap9ixhcxfag2ijp4a2ldfw6jfgwq6jwcblcsycyyrm0"))))
     (build-system emacs-build-system)
     (propagated-inputs
      (list emacs-posframe))
     (home-page "https://github.com/zbelial/posframe-plus")
     (synopsis "Auto hide posframe and set active map")
     (description "This package provides a new function posframe-plus-show, which adds two extra parameters to the origianl posframe-show.")
     (license license:expat))))


(define-public emacs-pocket-lib
  (let ((commit "61b5f9021e0b680174a1c2ac567a7188e2cdb468")
        (revision "1"))
    (package
     (name "emacs-pocket-lib")
     (version (git-version "0.3-pre" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/alphapapa/pocket-lib.el")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "02134gnasjmay8nwkzdabivw0jfnb169wgw5cksnhpx8jqd2rjzk"))))
     (build-system emacs-build-system)
     (propagated-inputs
      (list emacs-plz
            emacs-dash
            emacs-kv
            emacs-s))
     (home-page "https://github.com/alphapapa/pocket-lib.el")
     (synopsis "Emacs client for Pocket reading list (getpocket.com)")
     (description
      "This is a client for Pocket (getpocket.com). It allows you to manage your reading list: add, remove, delete, tag, view, favorite, etc.")
     (license license:gpl3))))

(define-public emacs-pocket-reader
  (let ((commit "cb9f6b108ebd3a67f77fb75d85351ffb3b0bb3d4")
        (revision "1"))
    (package
     (name "emacs-pocket-reader")
     (version (git-version "0.4-pre" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/alphapapa/pocket-reader.el")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0d0mfagx43sqrfyshnwm4acvh6h06jl6l11nvppqhb2hdrrdx0ia"))))
     (build-system emacs-build-system)
     (propagated-inputs
      (list emacs-dash
            emacs-kv
            emacs-ht
            emacs-ov
            emacs-peg
            emacs-s
            emacs-rainbow-identifiers
            emacs-org-web-tools
            emacs-pocket-lib))
     (home-page "https://github.com/alphapapa/pocket-reader.el")
     (synopsis " Emacs library for the getpocket.com API")
     (description
      "This is a simple library for accessing the getpocket.com API. It should be considered in late alpha/early beta status at the moment.")
     (license license:gpl3))))


(define-public emacs-spacious-padding
  (let ((commit "9d96d301d5bccf192daaf00dba64bca9979dcb5a")
        (revision "1"))
    (package
     (name "emacs-spacious-padding")
     (version (git-version "0.3.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.sr.ht/~protesilaos/spacious-padding")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0i0zabhykj1waz32b3f6486zmjpircc4qkdip7b2hj0hmyr2q9ih"))))
     (build-system emacs-build-system)
     (home-page "https://git.sr.ht/~protesilaos/spacious-padding")
     (synopsis "Increase the padding/spacing of GNU Emacs frames and windows")
     (description
      "This package provides a global minor mode to increase the spacing/padding of Emacs windows and frames.")
     (license license:gpl3))))


(define-public emacs-wolfram
  (let ((commit "743c92f88bb3b6a77bc84ac2221adc6222cebb94")
        (revision "1"))
    (package
     (name "emacs-wolfram")
     (version (git-version "1.2" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/hsjunnesson/wolfram.el")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "12bp7yarsqdg0572mq6n6l12r35ahkrjam2aa8k0ialhwigpbvwm"))))
     (build-system emacs-build-system)
     (home-page "https://github.com/hsjunnesson/wolfram.el")
     (synopsis "Wolfram Alpha integration in Emacs")
     (description
      "Allows you to query Wolfram Alpha from within Emacs.")
     (license license:gpl3))))
