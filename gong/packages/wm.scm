(define-module (gong packages wm)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages man))


(define %distro-root-directory
  (@@ (gnu packages) %distro-root-directory))


(define-public wayback
  (let ((commit "87361fafecc88aae650d1f9d9af346c8fa21f28e")
        (revision "1"))
    (package
     (name "wayback")
     (version (git-version "0.3" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://gitlab.freedesktop.org/wayback/wayback")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "19vfy1528b5kcvn07hniw92l19msaxkl4mgnq3yq6i300aqgbh6i"))
       (patches (car
                 (delq '()
                       (map (lambda (d)
                              (let ((d (string-append d "/gong/")))
                                (if (directory-exists? d)
                                    (find-files d
                                                "^wayback-0.2-config-touchpad.patch$")
                                    '())))
                            (append %load-path (list %distro-root-directory))))))))
     (build-system meson-build-system)
     (inputs (list wayland
                   wayland-protocols
                   libxkbcommon
                   wlroots
                   xorg-server-xwayland))
     (native-inputs (list pkg-config
                          scdoc))
     (home-page "https://wayback.freedesktop.org")
     (synopsis "X11 compatibility layer leveraging wlroots and Xwayland")
     (description "Wayback is a X11 compatibility layer which allows for running full X11
desktop environments using Wayland components.")
     (license license:expat))))


(define-public stumpwm+slynk-on-wayback
  (package
    (inherit stumpwm+slynk)
    (name "stumpwm-with-slynk-on-wayback")
    (propagated-inputs
     (list wayback))
    (arguments
     (substitute-keyword-arguments (package-arguments stumpwm+slynk)
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'build-program 'install-wayback-session
              (lambda* (#:key outputs #:allow-other-keys)
                (let* ((out #$output)
                       (wayland-sessions (string-append out "/share/wayland-sessions")))
                  (mkdir-p wayland-sessions)
                  (call-with-output-file
                      (string-append wayland-sessions "/stumpwm-on-wayback.desktop")
                    (lambda (file)
                      (format file
                              "[Desktop Entry]~@
                               Name=stumpwm on wayback~@
                               Comment=The Stump Window Manager on Wayback~@
                               Exec=~a/bin/wayback-session -sesscmd ~a/bin/stumpwm~@
                               Icon=~@
                               Type=Application~%"
                              #$wayback out))))))))))))
