{ config, pkgs, lib, ... }:

let
  # secrets (you might store these outside of version control)
  adminPass = "YOUR_ADMIN_PASSWORD_32+_CHARS";  # change this
  secretsFile = "/etc/nextcloud-secrets.json";
in
{
  # Write the secrets file (or use a secrets management solution)
  environment.etc."nextcloud-secrets.json".text = lib.mkIndent 2 ''
    {
      "passwordsalt": "SOME_RANDOM_STRING",
      "secret": "SOME_RANDOM_STRING_2",
      "instanceid": "INST_ID_RANDOM",
      "redis": {
        "password": "REDIS_PASSWORD"
      }
    }
  '';

  services.nextcloud = {
    enable = true;

    # Package version — pick the version in nixpkgs (update as needed)
    package = pkgs.nextcloud;  # you can pin nextcloud31, nextcloud32 etc

    # Host name (since only internal via tailscale you might set a local hostname)
    hostName = "nextcloud.internal";  # or whatever your machine's Tailscale name

    # No HTTPS because only accessible via Tailscale private network
    https = false;

    # Admin setup
    config.adminuser = "admin";
    config.adminpassFile = null;  # we provide admin via environment below
    environment.etc."nextcloud-admin-pass".text = adminPass;
    config.adminpassFile = "/etc/nextcloud-admin-pass";

    # Use a database: you may use sqlite for simplicity; or install postgres/mysql
    config.dbtype = "sqlite";
    # If you choose postgres, do something like:
    # database.createLocally = true;
    # config.dbtype = "pgsql";

    # Overwrite protocol and host (important for internal only)
    config.overwriteprotocol = "http";
    config.overwritehost = config.services.nextcloud.hostName;
    config.overwritewebroot = "/";
    config["overwrite.cli.url"] = "http://${config.services.nextcloud.hostName}/";

    # upload size, etc
    maxUploadSize = "4G";

    # Optional: enable a caching backend
    configureRedis = false;  # set true if you install redis
  };

  # If you want caching (optional)
  # services.redis = {
  #   enable = true;
  #   password = "REDIS_PASSWORD";
  # };

  # Storage: ensure persistent data
  fileSystems."/var/lib/nextcloud" = {
    device = "/mnt/nextcloud-data";  # your storage device
    fsType = "ext4";  # or whatever
  };
}



