(define-module (gong services net)
  #:use-module (gnu packages vpn)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services networking)
  #:use-module (guix gexp)
  #:export (tinc-service-type
            v2ray-service-type))


(define (tinc-shepherd-service conf-dir)
  (list
   (shepherd-service
    (provision '(tinc))
    (documentation "Run the tinc VPN.")
    (requirement '(networking))
    (start #~(make-forkexec-constructor
              (list (string-append #$tinc "/sbin/tincd")
                    "-c" #$conf-dir
                    "-D")))
    (stop #~(make-kill-destructor)))))

(define tinc-service-type
  (service-type
   (name 'tinc)
   (extensions
    (list (service-extension shepherd-root-service-type
                             tinc-shepherd-service)))
   (description "tinc @acronym{VPN, Virtual Private Network}.")))


(define (v2ray-shepherd-service bin-conf)
  (list
   (shepherd-service
    (provision '(v2ray))
    (documentation "Run then v2ray proxy.")
    (requirement '(networking))
    (start #~(make-forkexec-constructor
              (list #$(car bin-conf)
                    "-config"
                    #$(cdr bin-conf))))
    (stop #~(make-kill-destructor)))))

(define v2ray-service-type
  (service-type
   (name 'v2ray)
   (extensions
    (list (service-extension shepherd-root-service-type
                             v2ray-shepherd-service)))
   (description "V2ray Proxy.")))
