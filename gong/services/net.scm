(define-module (gong services net)
  #:use-module (gnu packages vpn)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services networking)
  #:use-module (guix gexp)
  #:export (tinc-service-type
            tinc-configuration

            v2ray-service-type
            v2ray-configuration))


(define-configuration/no-serialization tinc-configuration
  (config-dir
   string
   "Configuration directory for tinc"))

(define (tinc-shepherd-service config)
  (define config-dir (tinc-configuration-config-dir config))
  (list
   (shepherd-service
    (provision '(tinc))
    (documentation "Run the tinc VPN.")
    (requirement '(networking))
    (start #~(make-forkexec-constructor
              (list (string-append #$tinc "/sbin/tincd")
                    "-c" #$config-dir
                    "-D")))
    (stop #~(make-kill-destructor)))))

(define tinc-service-type
  (service-type
   (name 'tinc)
   (extensions
    (list (service-extension shepherd-root-service-type
                             tinc-shepherd-service)))
   (description "tinc @acronym{VPN, Virtual Private Network}.")))


(define-configuration/no-serialization v2ray-configuration
  (command
   string
   "Path to v2ray")
  (config-file
   string
   "Configuration file for v2ray"))

(define (v2ray-shepherd-service config)
  (define command (v2ray-configuration-command config))
  (define config-file (v2ray-configuration-config-file config))
  (list
   (shepherd-service
    (provision '(v2ray))
    (documentation "Run then v2ray proxy.")
    (requirement '(networking))
    (start #~(make-forkexec-constructor
              (list #$command
                    "-config"
                    #$config-file)))
    (stop #~(make-kill-destructor)))))

(define v2ray-service-type
  (service-type
   (name 'v2ray)
   (extensions
    (list (service-extension shepherd-root-service-type
                             v2ray-shepherd-service)))
   (description "V2ray Proxy.")))
