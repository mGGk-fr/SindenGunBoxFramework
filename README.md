# Sinden GunBox Framework
This repo is a set of tool to easily generate AHK Executable Scripts to use with Sinden LightGuns.

## Introduction
This repo contains two main folders :
* **Framework** : contains the framework and all its functions.
* **Scripts** : contains all the scripts you can generate with the framework.

## Configuration
All the framework configuration append in the `framework/config.ahk` file.

On the first run, you must copy the `config.ahk.dist` and rename it to `config.ahk` and update variables to fit your config

## Scripts
The Scripts directory contains some sample of scripts i've write to run my games, feel free to update them according to your setup and share new with a PR.

## Write your own scripts
Writing your own scripts with this framework is quiete easy.

Your script must be placed in the `Scripts` folder and start with :
```
#Include, ..\framework\framework.ahk
```

Two functions are here to handle guns :
* `BootFramework()` will detect and boot Sinden Software
* `EndFramework()` will kill Sinden Software instances

Feel free to look at provided scripts to help you.

## Framework References
| Function | Description | 
|---|---|
| BootFramework() | Detect and boot Sinden Software |
| DetectSinddenGuns()            | Returns the count of connected Sinden Guns |
| DetectAndBootSindenInstances() | Get the count of connected Sinden Guns and boot Lightgun software instance |
| EndFramework() | Kill all Sinden Software instances |
