(define-module (gong packages stream)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages upnp)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages video)
  #:use-module (gnu packages python)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages pkg-config)
  #:use-module ((guix licenses) #:prefix license:))


(define-public uxplay
  (package
   (name "uxplay")
   (version "1.72.2")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/FDH2/UxPlay")
                  (commit (string-append "v" version))))
            (file-name (git-file-name name version))
            (sha256
             (base32 "1my76bcdfx5p8fpw6jl22r6j3f6lwccrq3mn747mm50fnrl1lxn5"))))
   (build-system cmake-build-system)
   (arguments `(#:tests? #false))
   (inputs
    (list openssl libplist avahi gstreamer gst-plugins-base libx11))
   (native-inputs
    (list pkg-config))
   (home-page "https://github.com/FDH2/UxPlay")
   (synopsis "AirPlay Unix mirroring server")
   (description
    "AirPlay-Mirror and AirPlay-Audio server for Linux, macOS, and Unix (now also runs on Windows).")
   (license license:gpl3)))


(define-public sunshine--
  (package
    (name "sunshine--")
    (version "0.23.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/LizardByte/Sunshine.git")
                    (commit (string-append "v" version))
                    (recursive? #t)))
              (sha256
               (base32 "180inh3ja9vnwbk6xi9q2ij1nldqr5yfxx1icimaak4rdpk9x5qg"))))
    (build-system cmake-build-system)
    (outputs '("out"
               "debug"))
    (arguments
     (list #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'modify-src
                 (lambda _
                   (substitute* "cmake/packaging/linux.cmake"
                     (("\\$\\{UDEV_RULES_INSTALL_DIR\\}")
                      (string-append #$output "/lib/udev/rules.d"))
                     (("\\$\\{SYSTEMD_USER_UNIT_INSTALL_DIR\\}")
                      "${SUNSHINE_ASSETS_DIR}/systemd/user"))
                   ;; without web ui
                   (substitute* "cmake/targets/unix.cmake"
                                ((".*")
                                 ""))
                   (substitute* "cmake/dependencies/common.cmake"
                     (("list\\(APPEND FFMPEG_PLATFORM_LIBRARIES mfx\\)")
                      ""))
                   ;; FIXME
                   ;; (substitute* "src/platform/linux/graphics.cpp"
                   ;;   (("libgbm\\.so" all)
                   ;;    (string-append #$mesa "/lib/" all)))
                   ;; (substitute* "src/platform/linux/input.cpp"
                   ;;   (("libXtst\\.so" all)
                   ;;    (string-append #$libxtst "/lib/" all))
                   ;;   (("libX11\\.so" all)
                   ;;    (string-append #$libx11 "/lib/" all)))
                   (substitute* "src/platform/linux/publish.cpp"
                                (("libavahi-(common|client)\\.so" all)
                                 (string-append #$avahi "/lib/" all)))
                   (substitute* "src/platform/linux/x11grab.cpp"
                     (("libXrandr\\.so" all)
                      (string-append #$libxrandr "/lib/" all))
                     (("libXfixes\\.so" all)
                      (string-append #$libxfixes "/lib/" all))
                     (("libX11\\.so" all)
                      (string-append #$libx11 "/lib/" all))
                     (("libxcb(-shm|)\\.so" all)
                      (string-append #$libxcb "/lib/" all)))))
               (add-before 'install 'create-void-assets-web
                 (lambda _
                   (mkdir "assets/web"))))))
    (inputs
     (list
      eudev
      libappindicator
      boost
      libcap
      curl
      libdrm
      libevdev
      miniupnpc
      libnotify
      numactl
      opus
      pulseaudio
      openssl
      libva
      libvdpau
      wayland
      libx11
      ;; libxtst
      libxrandr
      libxfixes
      libxcb
      python
      ;; mesa
      avahi))
    (native-inputs
     (list
      pkg-config))
    (home-page "https://app.lizardbyte.dev/Sunshine/")
    (synopsis "Self-hosted game stream host for Moonlight")
    (description "Sunshine is a self-hosted game stream host for Moonlight. Offering low latency, cloud gaming server capabilities with support for AMD, Intel, and Nvidia GPUs for hardware encoding. Software encoding is also available.")
    (license license:gpl3)))
