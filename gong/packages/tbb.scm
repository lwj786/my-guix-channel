(define-module (gong packages tbb)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages pkg-config))


(define-public hwloc-211
  (package
    (inherit hwloc-2)
    (name "hwloc-211")
    (version "2.11.2")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://download.open-mpi.org/release/hwloc/v"
                                  (version-major+minor version)
                                  "/hwloc-" version ".tar.bz2"))
              (sha256
               (base32
                "02c4zqifmfk91a8q5515c4azgx6hmmcbc5d9l7qh0w86mvn8zy7p"))))))

(define-public tbb+tbbbind25
  (package
   (inherit tbb)
   (name "tbb+tbbbind25")
   (version "2021.13.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/oneapi-src/oneTBB")
           (commit (string-append "v" version))))
     (sha256
      (base32 "15glmdv4ckmw9n8fy0gslslq8y291p9x6r7xyd8fbhajpmik71b6"))))
   (inputs
    (list
     `(,hwloc-211 "lib")))
   (native-inputs
    (list
     pkg-config))))
