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
      "credentials=/home/pslind/nixconfig/nixosModules/smb-secrets"  # Path to your credentials file
      "uid=1000"  # Replace with your user ID
      "gid=100"   # Replace with your group ID
      "rw"
      "vers=3.0"  # Or the version your server supports
    ];
  };
# ...existing code...
    systemd.user.services.backup-desktop = {
    description = "Backup Desktop to USB";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.rsync}/bin/rsync -avh --delete ~/Desktop/ /mnt/sambashare/Desktop-backup/
      '';
    };
  };

  systemd.user.timers.backup-desktop = {
    description = "Run Desktop Backup Daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}