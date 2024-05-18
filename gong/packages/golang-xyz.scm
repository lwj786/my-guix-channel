(define-module (gong packages golang-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:))

(define-public go-pkg-nimblebun-works-go-lsp
  (package
    (name "go-pkg-nimblebun-works-go-lsp")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nimblebun/go-lsp")
             (commit (string-append "v" version))))
       (sha256
        (base32 "14hdbk0h85930phnsih5k33dj2qx9b3j4vvsf24g6v3qqjvbp54q"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "pkg.nimblebun.works/go-lsp"
       #:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'build))))
    (home-page "https://github.com/nimblebun/go-lsp")
    (synopsis "language server protocol types and documentation for go")
    (description "This is a module that contains type definitions and documentation for the Language Server Protocol Specification. It aims to provide up-to-date and clear definitions to use in a language server.")
    (license license:expat)))
