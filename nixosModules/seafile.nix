{ pkgs, lib, config, ... }: {

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
    workgroup = KTZ
    server string = testnix
    netbios name = testnix
    security = user
    guest ok = yes
    guest account = nobody
    map to guest = bad user
    load printers = no
    '';
    shares = {
    backups = {
        path = "~/share/";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "pslind";
        "force group" = "users";
    };
    };
};

}