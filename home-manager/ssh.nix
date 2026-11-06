{ ... }:

{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    # HM's old built-in defaults just restated OpenSSH's own defaults.
    enableDefaultConfig = false;
    settings = {
      # Agent forwarding only to our own VMs, never to arbitrary hosts.
      "*" = {
        AddKeysToAgent = "yes";
      };
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github_ed25519";
      };
      "os161" = {
        HostName = "192.168.122.199";
        User = "hooman";
        IdentityFile = "~/.ssh/os161";
        ForwardAgent = true;
      };
      "debian" = {
        HostName = "192.168.122.223";
        User = "bigwhoman";
        IdentityFile = "~/.ssh/debian";
        IdentitiesOnly = true;
        ForwardAgent = true;
      };
      "CSLab" = {
        HostName = "mlsys-02.syslab.sandbox";
        User = "keshvari";
        IdentityFile = "~/.ssh/CS";
        IdentitiesOnly = true;
        ProxyJump = "debian";
      };
    };
  };
}
