{ pkgs, lib, config, ... }: {
# ...existing code...
    environment.systemPackages = with pkgs; [
      rsync
      cifs-utils   # <--- Add this line
    ];
# ...existing code...
# ...existing code...
  fileSystems."/mnt/sambashare" = {
    device = "//homeassistant.local/media";
    fsType = "cifs";
    options = [
      "username=pslind"
      "password=EE95Lv!H"
      "uid=1000"  # Replace with your user ID
      "gid=100"   # Replace with your group ID
      "rw"
      "vers=3.0"  # Or the version your server supports
    ];
  };
# ...existing code...
}