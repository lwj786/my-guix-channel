(define-module (gong packages tbb)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages pkg-config))


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
     `("hwloc:lib" ,hwloc "lib")))
   (native-inputs
    (list
     pkg-config))))
