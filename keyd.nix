{ inputs, outputs, lib, config, pkgs, ... }:
{
  services.keyd = {
    enable = true;

    keyboards = {
    # The name is just the name of the configuration file, it does not really matter
    default = {
#      ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
#      # Everything but the ID section:
#      settings = {
#        # The main layer, if you choose to declare it in Nix
#        main = {
#          capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
#        };
#        otherlayer = {};
#      };
      extraConfig = ''
# Usage: Place this file /etc/keyd/default.conf

# Causes `capslock` to behave as `control` when pressed
# and escape when tapped. Note that `control` is what
# keyd regards as a 'modifier layer'.
# See the man page for more details.

[ids]

*

[main]

capslock = overload(flechas, esc)
esc = capslock

[flechas]
j = down
k = up
h = left
l = right

      '';
    };
    };
  };

  # Optional, but makes sure that when you type the make palm rejection work with keyd
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
