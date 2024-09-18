{lib, config, pkgs, ...}:
#let in
{
  options = {
    laptop.enable = lib.mkEnableOption "Extra options to run nixOS on a laptop";
  };
  config = lib.mkIf config.laptop.enable{
    #LAPTOP
    services.thermald.enable = true;
    services.tlp = {
      enable = true;
      settings = {
        ########CPU_SCALING_GOVERNOR_ON_AC = "performance";
        ########CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        ########CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
        ########CPU_ENERGY_PREF_POLICY_ON_AC = "performance";

			  CPU_MIN_PERF_ON_AC = 0;
			  CPU_MAX_PERF_ON_AC = 80;
        #CPU_MIN_PERF_ON_BAT = 0;
        #CPU_MAX_PERF_ON_BAT = 20;

        ########START_CHARGE_THRESH_BAT0 = 40;
        ########STOP_CHARGE_THRESH_BAT0 = 80;
		  };
	  };
  };
}
