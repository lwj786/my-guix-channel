(define-module (gong packages ai)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages maths))


(define-public chatglm.cpp
  (package
    (name "chatglm.cpp")
    (version "0.3.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/li-plus/chatglm.cpp")
             (commit (string-append "v" version))
             (recursive? #t)))
       (sha256
        (base32 "1sq6pwh8823wa6nxpzrnjgpnlwgwclvx3xg058iy8czczwajvq3z"))))
    (build-system cmake-build-system)
    (arguments
     (list #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'install-main-exe
                 (lambda _
                   (substitute* "CMakeLists.txt"
                     (("if \\(CHATGLM_ENABLE_EXAMPLES\\)")
                      "if (CHATGLM_ENABLE_EXAMPLES)
    add_executable(chatglm-cli main.cpp)
    target_link_libraries(chatglm-cli PRIVATE chatglm)
    install(TARGETS chatglm-cli)
    set(CMAKE_INSTALL_RPATH \"${CMAKE_INSTALL_PREFIX}/lib\")")
                     (("add_executable\\(main main.cpp\\)")
                      "")
                     (("target_link_libraries\\(main PRIVATE chatglm\\)")
                      "")))))))
    (home-page "https://github.com/li-plus/chatglm.cpp")
    (synopsis "C++ implementation of ChatGLM-6B & ChatGLM2-6B & ChatGLM3 & more LLMs")
    (description "C++ implementation of ChatGLM-6B, ChatGLM2-6B, ChatGLM3-6B and more LLMs for real-time chatting")
    (license license:expat)))

(define-public chatglm.cpp-openblas
  (package (inherit chatglm.cpp)
           (name "chatglm.cpp-openblas")
           (arguments
            (substitute-keyword-arguments (package-arguments chatglm.cpp)
              ((#:configure-flags flags '())
               #~(list "-DGGML_OPENBLAS=ON"))))
           (inputs (list openblas))))


(define-public llama.cpp
  (package
    (name "llama.cpp")
    (version "b3353")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ggerganov/llama.cpp")
             (commit version)
             (recursive? #t)))
       (sha256
        (base32 "0fdf1mxkhaqsgv7hg4rjv333ndcpwljw5n2fsy7l7ymkhxlhi6g5"))))
    (build-system cmake-build-system)
    (arguments
     (list #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'install 'remove-test-exe
                 (lambda _
                   (let ((out-bin (string-append #$output "/bin")))
                     (for-each delete-file
                               (find-files out-bin
                                           "^test-.*"))))))))
    (home-page "https://github.com/ggerganov/llama.cpp")
    (synopsis "LLM inference in C/C++")
    (description "Inference of Meta's LLaMA model (and others) in pure C/C++.")
    (license license:expat)))

(define-public whisper.cpp
  (package
    (name "whisper.cpp")
    (version "1.6.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ggerganov/whisper.cpp")
             (commit (string-append "v" version))))
       (sha256
        (base32 "01q4j602wkvsf9vw0nsazzgvjppf4fhpy90vqnm9affynyxhi0c4"))))
    (build-system gnu-build-system)
    (arguments
     (list #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (delete 'configure)
               (add-before 'build 'set-env
                 (lambda _
                   (setenv "CC" (which "gcc"))
                   (setenv "CXX" (which "g++"))))
               (replace 'install
                 (lambda _
                   (let ((out-bin (string-append #$output "/bin")))
                     (for-each (lambda (base)
                                 (install-file base out-bin)
                                 (rename-file (string-append out-bin "/" base)
                                              (string-append out-bin "/whisper"
                                                             (if (string= base "main")
                                                                 "-cli"
                                                                 (string-append "-" base)))))
                               '("main" "bench" "quantize" "server"))))))))
    (home-page "https://github.com/ggerganov/whisper.cpp")
    (synopsis "Port of OpenAI's Whisper model in C/C++")
    (description "High-performance inference of OpenAI's Whisper automatic speech recognition (ASR) model")
    (license license:expat)))
