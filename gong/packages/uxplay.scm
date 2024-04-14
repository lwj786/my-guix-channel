(define-module (gong packages uxplay)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages pkg-config)
  #:use-module ((guix licenses) #:prefix license:))


(define-public uxplay
  (let ((commit "2c850d0585f056f10aa3be59b6d64ca481853767")
        (revision "1"))
    (package
     (name "uxplay")
     (version (git-version "1.68.2" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/FDH2/UxPlay")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "09a1m2akl9yj26jkgfzs5gmkn5krninyvz74qc4fyp5pb4xm655c"))))
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
     (license license:gpl3))))
