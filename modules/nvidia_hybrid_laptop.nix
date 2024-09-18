{lib, config, pkgs, ...}:
let
nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec "$@"
'';
in {
	options = {
		nvidiaHyb.enable = lib.mkEnableOption "Enable Nvidia config";
    };
	config = lib.mkIf config.nvidiaHyb.enable{

		# Importar os drivers de vídeo para o X server
		services.xserver.videoDrivers=["nvidia"];
		hardware.nvidia={
			modesetting.enable = true;
			powerManagement.enable = true;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
		hardware.nvidia.prime = {
			offload = {
				enable = true;
				enableOffloadCmd=true;
			};
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	# Defina os pacotes de drivers Nvidia
    hardware.opengl.extraPackages = with pkgs; [vaapiVdpau nvidia-vaapi-driver];
	};   
}
