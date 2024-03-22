function rtwTargetInfo(tr)

	tr.registerTargetInfo(@loc_createToolchain);

end

function config = loc_createToolchain

config(1)                     = coder.make.ToolchainInfoRegistry;
config(1).Name                = 'zig 0.11.0 | zig';
config(1).FileName            = fullfile(fileparts(mfilename('fullpath')), 'zig_tc');
config(1).TargetHWDeviceType  = {'*'};
config(1).Platform			  = {computer('arch')};

end