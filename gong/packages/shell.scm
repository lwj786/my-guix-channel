(define-module (gong packages shell)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages golang-build)
  #:use-module (gong packages golang-xyz))


(define-public elvish
  (package
    (name "elvish")
    (version "0.20.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/elves/elvish")
             (commit (string-append "v" version))))
       (sha256
        (base32 "140507p05fmcxn7g3irgzssg5r37vj9dnig3q8q1clhmr3gxgall"))))
    (build-system go-build-system)
    (arguments
     (list #:go go-1.21
           #:install-source? #f
           #:tests? #f
           #:import-path "src.elv.sh"
           #:phases
           #~(modify-phases %standard-phases
               (replace 'build
                 (lambda* (#:key import-path build-flags #:allow-other-keys)
                   (with-throw-handler
                       #t
                     (lambda _
                       (apply invoke "go" "install"
                              "-v" ; print the name of packages as they are compiled
                              "-x" ; print each command as it is invoked
                              ;; Respectively, strip the symbol table and debug
                              ;; information, and the DWARF symbol table.
                              "-ldflags=-s -w"
                              `(,@build-flags  ,(string-append import-path "/cmd/elvish"))))
                     (lambda (key . args)
                       (display (string-append "Building '" import-path "' failed.\n"
                                               "Here are the results of `go env`:\n"))
                       (invoke "go" "env"))))))))
    (inputs
     (list go-github-com-creack-pty
           go-github-com-google-go-cmp-cmp
           go-github-com-mattn-go-isatty
           go-github-com-sourcegraph-jsonrpc2
           go-go-etcd-io-bbolt
           go-golang-org-x-sync
           go-golang-org-x-sys
           go-pkg-nimblebun-works-go-lsp))
    (home-page "https://elv.sh")
    (synopsis "Expressive Programming Language + Versatile Interactive Shell")
    (description "Elvish is a powerful scripting language and a versatile interactive shell.")
    (license license:bsd-2)))
