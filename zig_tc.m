function tc = zig_tc
	%INTEL_TC Creates an Intel v14 ToolchainInfo object.
	% This file can be used as a template to define other toolchains on Windows.

	% Copyright 2012-2016 The MathWorks, Inc.

	tc = coder.make.ToolchainInfo('BuildArtifact', 'gmake makefile');
	tc.Name             = 'zig 0.11.0 | zig';
	tc.Platform         = 'glnxa64';
	tc.SupportedVersion = '0.11.0';

	tc.addAttribute('TransformPathsWithSpaces');

	% ------------------------------
	% Macros
	% ------------------------------
	tc.addMacro('MW_EXTERNLIB_DIR',     ['$(MATLAB_ROOT)/extern/lib/' tc.Platform '/linux']);
	tc.addMacro('MW_LIB_DIR',           ['$(MATLAB_ROOT)/lib/' tc.Platform]);
	tc.addMacro('CFLAGS_ADDITIONAL',    '-D_CRT_SECURE_NO_WARNINGS');
	tc.addMacro('CPPFLAGS_ADDITIONAL',  '-EHs -D_CRT_SECURE_NO_WARNINGS');
	tc.addMacro('LIBS_TOOLCHAIN',       '$(conlibs)');
	tc.addMacro('CVARSFLAG',            '');
	
	tc.addIntrinsicMacros({'ldebug', 'conflags', 'cflags'});
	
	% ------------------------------
	% C Compiler
	% ------------------------------
	 
	tool = tc.getBuildTool('C Compiler');
	
	tool.setName(           'Zig C Compiler');
	tool.setCommand(        'zig cc');
	tool.setPath(           '');
	
	tool.setDirective(      'IncludeSearchPath',    '-I');
	tool.setDirective(      'PreprocessorDefine',   '-D');
	tool.setDirective(      'OutputFlag',           '-o');
	tool.setDirective(      'Debug',                '-Zi');
	
	tool.setFileExtension(  'Source',               '.c');
	tool.setFileExtension(  'Header',               '.h');
	tool.setFileExtension(  'Object',               '.obj');
	
	tool.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');
	
	% ------------------------------
	% C++ Compiler
	% ------------------------------
	
	tool = tc.getBuildTool('C++ Compiler');
	
	tool.setName(           'Zig C++ Compiler');
	tool.setCommand(        'zig c++');
	tool.setPath(           '');
	
	tool.setDirective(      'IncludeSearchPath',  	'-I');
	tool.setDirective(      'PreprocessorDefine', 	'-D');
	tool.setDirective(      'OutputFlag',           '-o');
	tool.setDirective(      'Debug',                '-Zi');
	
	tool.setFileExtension(  'Source',               '.cpp');
	tool.setFileExtension(  'Header',               '.hpp');
	tool.setFileExtension(  'Object',               '.obj');
	
	tool.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');
	
	% ------------------------------
	% Linker
	% ------------------------------
	
	tool = tc.getBuildTool('Linker');
	
	tool.setName(           'Zig C/C++ Linker');
	tool.setCommand(        'zig cc');
	tool.setPath(           '');
	
	tool.setDirective(      'Library',              '-l');
	tool.setDirective(      'LibrarySearchPath',    '-L');
	tool.setDirective(      'OutputFlag',           '-out:');
	tool.setDirective(      'Debug',                '');
	
	tool.setFileExtension(  'Executable',           '');
	tool.setFileExtension(  'Shared Library',       '.so');
	
	tool.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');
	
	% ------------------------------
	% C++ Linker
	% ------------------------------
	
	tool = tc.getBuildTool('C++ Linker');
	
	tool.setName(           'Zig C/C++ Linker');
	tool.setCommand(        'zig cc');
	tool.setPath(           '');
	
	tool.setDirective(      'Library',              '-l');
	tool.setDirective(      'LibrarySearchPath',    '-L');
	tool.setDirective(      'OutputFlag',           '-out:');
	tool.setDirective(      'Debug',                '');
	
	tool.setFileExtension(  'Executable',           '');
	tool.setFileExtension(  'Shared Library',       '.so');
	
	tool.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');
	
	% ------------------------------
	% Archiver
	% ------------------------------
	
	tool = tc.getBuildTool('Archiver');
	
	tool.setName(           'Zig C/C++ Archiver');
	tool.setCommand(        'zig ar');
	tool.setPath(           '');
	tool.setDirective(      'OutputFlag',           '-out:');
	tool.setFileExtension(  'Static Library',       '.a');
	tool.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');
	
	% ------------------------------
	% Builder
	% ------------------------------
	
	tc.setBuilderApplication(tc.Platform);
	
	% --------------------------------------------
	% BUILD CONFIGURATIONS
	% --------------------------------------------
	
	cCompilerOpts    = '$(cflags) $(CVARSFLAG) $(CFLAGS_ADDITIONAL)';
	cppCompilerOpts  = '$(cflags) $(CVARSFLAG) $(CPPFLAGS_ADDITIONAL)';
	linkerOpts       = {'$(ldebug) $(conflags) $(LIBS_TOOLCHAIN)'};
	sharedLinkerOpts = horzcat(linkerOpts, '-dll -def:$(DEF_FILE)');
	archiverOpts     = {'/nologo'};
	
	% Get the debug flag per build tool
	debugFlag.CCompiler   = '$(CDEBUG)';   
	debugFlag.CppCompiler = '$(CPPDEBUG)';
	debugFlag.Linker      = '$(LDDEBUG)';  
	debugFlag.CppLinker   = '$(CPPLDDEBUG)';  
	debugFlag.Archiver    = '$(ARDEBUG)';  
	
	% Set the toolchain flags for 'Faster Builds' build configuration
	
	cfg = tc.getBuildConfiguration('Faster Builds');
	cfg.setOption( 'C Compiler',                horzcat(cCompilerOpts));
	cfg.setOption( 'C++ Compiler',              horzcat(cppCompilerOpts));
	cfg.setOption( 'Linker',                    linkerOpts);
	cfg.setOption( 'C++ Linker',                linkerOpts);
	cfg.setOption( 'Shared Library Linker',     sharedLinkerOpts);
	cfg.setOption( 'Archiver',                  archiverOpts);
	
	% Set the toolchain flags for 'Faster Runs' build configuration
	
	cfg = tc.getBuildConfiguration('Faster Runs');
	cfg.setOption( 'C Compiler',                horzcat(cCompilerOpts));
	cfg.setOption( 'C++ Compiler',              horzcat(cppCompilerOpts));
	cfg.setOption( 'Linker',                    linkerOpts);
	cfg.setOption( 'C++ Linker',                linkerOpts);
	cfg.setOption( 'Shared Library Linker',     sharedLinkerOpts);
	cfg.setOption( 'Archiver',                  archiverOpts);
	
	% Set the toolchain flags for 'Debug' build configuration
	
	cfg = tc.getBuildConfiguration('Debug');
	cfg.setOption( 'C Compiler',              	horzcat(cCompilerOpts, debugFlag.CCompiler));
	cfg.setOption( 'C++ Compiler',          	horzcat(cppCompilerOpts, debugFlag.CppCompiler));
	cfg.setOption( 'Linker',                	horzcat(linkerOpts,       debugFlag.Linker));
	cfg.setOption( 'C++ Linker',               	horzcat(linkerOpts,       debugFlag.CppLinker));
	cfg.setOption( 'Shared Library Linker',  	horzcat(sharedLinkerOpts, debugFlag.Linker));
	cfg.setOption( 'Archiver',              	horzcat(archiverOpts,     debugFlag.Archiver));
	
	tc.setBuildConfigurationOption('all', 'Make Tool',     '-f $(MAKEFILE)');
	