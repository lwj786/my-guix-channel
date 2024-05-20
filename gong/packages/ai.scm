(define-module (gong packages ai)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages maths))


(define-public chatglm.cpp
  (package
    (name "chatglm.cpp")
    (version "0.3.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/li-plus/chatglm.cpp")
             (commit (string-append "v" version))
             (recursive? #t)))
       (sha256
        (base32 "1h4fz64cffbv173v60bdn81hzgxcby97vp1ya6n1i633v41gjawh"))))
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
    add_executable(chatglm-cpp main.cpp)
    target_link_libraries(chatglm-cpp PRIVATE chatglm)
    install(TARGETS chatglm-cpp)
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
