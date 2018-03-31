(use-modules (gnu) (gnu system nss))
(use-service-modules desktop)
(use-package-modules certs gnome)

(operating-system
 (host-name "antelope")
 (timezone "Europe/Dublin")
 (locale "en_IE.utf8")

 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (target "/dev/sda")))

 (file-systems (cons (file-system
                      (device "main")
                      (mount-point "/")
                      (type "ext4"))
                     %base-file-systems))

 (swap-devices '("/dev/sda1"))
 (users (cons (user-account
               (name "sebastien")
               (comment "Sebastien")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video"))
               (home-directory "/home/sebastien"))
              %base-user-accounts))

 ;; This is where we specify system-wide packages.
 (packages (cons* nss-certs         ;for HTTPS access
                  gvfs              ;for user mounts
                  git
                  openssh
                  %base-packages))

 (services (cons* (gnome-desktop-service)
                  (xfce-desktop-service)
                  %desktop-services))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
