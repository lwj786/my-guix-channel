(define-module (gong packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages xorg)
  #:use-module (gong packages wm))


(define-public emacs-4me
  (package
    (inherit emacs-next)
    (name "emacs-4me")
    (inputs (modify-inputs (package-inputs emacs)
              (prepend
               libxrender
               libxt)))))

(define-public emacs-exwm-4me
  (package
    (inherit emacs-exwm)
    (name "emacs-exwm-4me")
    (propagated-inputs
     (modify-inputs (package-propagated-inputs emacs-exwm)
       (append wayback)))
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-exwm)
       ((#:emacs _) emacs-4me)
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'install-xsession 'install-wayback-session
              (lambda* (#:key outputs #:allow-other-keys)
                (let* ((out #$output)
                       (wayland-sessions (string-append out "/share/wayland-sessions")))
                  (mkdir-p wayland-sessions)
                  (call-with-output-file
                      (string-append wayland-sessions "/exwm-on-wayback.desktop")
                    (lambda (file)
                      (format file
                              "[Desktop Entry]~@
                               Name=emacs-exwm on wayback~@
                               Comment=Emacs X windows manager on Wayback~@
                               Exec=~a/bin/wayback-session ~a/bin/exwm~@
                               Icon=~@
                               Type=Application~%"
                              #$wayback out))))))))))))


(define-public emacs-citre-next
  (let ((commit "3e3c6e539c41c880f9d10ef7424cd0d2adcf3151")
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
                        (base32 "0p2iifiadxpa2q75zk45gqj8bwa3wx9gcs82p5b303lrzid9mrga")))))))


(define-public emacs-hass
  (let ((commit "4c9da37c5217177d43dbd2cb9cd458c01b834c54")
        (revision "1"))
    (package
      (name "emacs-hass")
      (version (git-version "3.0.2" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/purplg/hass")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32 "15mrp8ibynlr3fjhgqia9m0fc0jrkj4x9apw6j2dka19cv00vs1m"))))
      (build-system emacs-build-system)
      (arguments
       (list #:tests? #f))
      (propagated-inputs
       (list
        emacs-request
        emacs-websocket))
      (home-page "https://github.com/purplg/hass")
      (synopsis "An Emacs package for interacting with Home Assistant")
      (description "hass is an Emacs package that enables integration with Home Assistant. Call Home Assistant services, hook into Home Assistant events, and create convenient dashboards.")
      (license license:expat))))


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
     (arguments
       (list #:tests? #f))
     (home-page "https://git.sr.ht/~tsdh/highlight-parentheses.el")
     (synopsis "Highlights parentheses surrounding point in Emacs")
     (description
      "`highlight-parentheses.el` dynamically highlights the parentheses surrounding point based on nesting-level using configurable lists of colors, background colors, and other properties.")
     (license license:gpl3+))))


(define-public emacs-maple-translate
  (let ((commit "857eaa1d2fffb606ab6e8139c58886e0eb711db7")
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
               (base32 "1srh1n20vdpa5v173a3zvv32iswwdrpa98jmw8sycakc2dp6afbk"))))
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
