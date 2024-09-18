{pkgs,lib,... }:
{
	imports =
		[
      ./modules/acerN5_laptop.nix
		  ./modules/nvidia_hybrid_laptop.nix
      # Include the results of the hardware scan.
		  ./hardware-configuration.nix
		];

  # Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.

	# Enabling NVIDIA Config File with Offload (Hybrid Acer Nitro 5)
  nvidiaHyb.enable = true;

  # Enable configs Especific to LapTop(AcerN5)
  laptop.enable  = true;

  # Enable networking
	networking.networkmanager.enable = true;

  # Set your time zone.
	time.timeZone = "America/Sao_Paulo";

	i18n.defaultLocale = "pt_BR.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_BR.UTF-8";
		LC_IDENTIFICATION = "pt_BR.UTF-8";
		LC_MEASUREMENT = "pt_BR.UTF-8";
		LC_MONETARY = "pt_BR.UTF-8";
		LC_NAME = "pt_BR.UTF-8";
		LC_NUMERIC = "pt_BR.UTF-8";
		LC_PAPER = "pt_BR.UTF-8";
		LC_TELEPHONE = "pt_BR.UTF-8";
		LC_TIME = "pt_BR.UTF-8";
	};

  # Habilitar o sistema de janelas X11.
  # Enable the X11 windowing system.

  # Enable Wayland
  services.xserver={ enable = true;};
  services = {
                     displayManager.sddm ={
                       enable = true;
                       wayland = {
                         enable = true;
                       };
                     };
  };
  programs.hyprland ={ enable = true;
                       xwayland.enable = true; };
  environment.sessionVariables = {WL_NO_HARDWARE_CURSORS="1"; NIXOS_OZONE_WL="1"; };
  xdg.portal.enable=true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Configure console keymap
	console={
		keyMap = "br-abnt2";
		packages=[pkgs.terminus_font];
		font="${pkgs.terminus_font}/share/consolefonts/ter-i22.psf.gz";
	};

  # FONTS
	fonts = {
		packages = with pkgs;[
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			fira-code
			fira-code-symbols
			mplus-outline-fonts.githubRelease
			dina-font
			proggyfonts
			(nerdfonts.override{fonts=["FiraCode" "DroidSansMono"];})
		];
	};

  # Enable CUPS to print documents.
	services.printing.enable = true;

  # Enable sound with pipewire.
	sound.enable=true;
	hardware.pulseaudio.enable = true;
	security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.menezess42 = {
		isNormalUser = true;
		description = "Menezess42";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		cmatrix
		  vscode
			direnv
			terminator
			chromium
			discord
			nvtopPackages.full
			lshw
			thunderbird
			neovim
			emacs
			neofetch
			btop
			pavucontrol
			arandr
			xfce.thunar
			xfce.tumbler
			mupdf
			spotify
			gcc
			ripgrep
			networkmanagerapplet
			grimblast
			obsidian
			qalculate-gtk
		git
		#Emacs pyIDE
		#python311           # Python 3.10 (ou versão desejada)
		#python311Packages.python-lsp-server
		#python311Packages.black  # Formatador de código Black
		#python311Packages.pyflakes  # Linter Pyflakes
		#python311Packages.flake8  # Linter Flake8
		#python311Packages.pip  # Gerenciador de pacotes pip
		#python311Packages.virtualenv  # Para criar ambientes virtuais
		];
	};

  # Install firefox.
	programs.firefox.enable = true;

  # Allow unfree packages
	nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
	environment.systemPackages = with pkgs; [
		wget
		virtualglLib
		glxinfo
		pciutils
		mesa
		waybar
		swww
		rofi-wayland
		kitty
		ntfs3g
	];

	system.stateVersion = "24.05"; # Did you read the comment?

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit=true;
		extraPackages = with pkgs; [intel-media-driver];
	};

  # Need this to prevent Windows and nixOS from keeping bugs out the clock
	time.hardwareClockInLocalTime = true;

  # Configing my externalHD to work out of the box on nixOS
  fileSystems."/mnt/hdmenezess42" = {
    device = "/dev/sda1";
    fsType = "ntfs-3g";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
