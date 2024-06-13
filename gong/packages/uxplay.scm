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
  (package
   (name "uxplay")
   (version "1.68.3")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/FDH2/UxPlay")
                  (commit (string-append "v" version))))
            (file-name (git-file-name name version))
            (sha256
             (base32 "1azh1v6zkgbqwixf079n9zylm5nld2ar999avx8b9k7vimf9bzqj"))))
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
