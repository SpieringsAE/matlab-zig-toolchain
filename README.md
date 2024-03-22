# Matlab Zig toolchain

This project is me trying to figure out how to make a matlab toolchain

setup:
```matlab
RTW.TargetRegistry.getInstance('reset');
cfg = coder.config('exe');
cfg.CustomSource = 'main.c';
cfg.CustomInclude = pwd;
cfg.Toolchain = 'zig 0.11.0';

codegen -config cfg coderrand
```