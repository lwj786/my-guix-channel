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
  (let ((commit "3de745e53b69eaf12e8ef9d982a688db8c2966e2")
        (revision "1"))
    (package
     (name "uxplay")
     (version (git-version "1.67" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/FDH2/UxPlay")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "1icfaw7i8fn2avlwy7yqz8zjzw92plm12lw7jk44ksg4jf9l8iya"))))
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
