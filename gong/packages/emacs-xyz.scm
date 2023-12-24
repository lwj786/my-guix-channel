(define-module (gong packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-goto-line-preview
  (let ((commit "877d65a60cfa1abab55c95574212bdc9fcd6bebe")
        (revision "1"))
    (package
     (name "emacs-goto-line-preview")
     (version (git-version "0.1.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacs-vs/goto-line-preview")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0mn00f0xjq9q4y28igczvzg2976pl2fzr67fxc2wj0knkbsd9fvf"))))
     (build-system emacs-build-system)
     (home-page "https://github.com/emacs-vs/goto-line-preview")
     (synopsis "Preview line when executing goto-line command")
     (description
      "This package makes this better by navigating the line while you are inputting in minibuffer.")
     (license license:gpl3))))


(define-public emacs-highlight-parentheses
  (let ((commit "438a1cb2563e2a2496be4678cc0df8d5b22caf5d")
        (revision "1"))
    (package
     (name "emacs-highlight-parentheses")
     (version (git-version "2.1.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.sr.ht/~tsdh/highlight-parentheses.el")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0ixjai9w9x4sm1lx9yljl58r7ydbbjlkb0a2pbv316l8qph8w44r"))))
     (build-system emacs-build-system)
     (home-page "https://git.sr.ht/~tsdh/highlight-parentheses.el")
     (synopsis "Highlights parentheses surrounding point in Emacs")
     (description
      "`highlight-parentheses.el` dynamically highlights the parentheses surrounding point based on nesting-level using configurable lists of colors, background colors, and other properties.")
     (license license:gpl3+))))


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
