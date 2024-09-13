# 9ui / glass_ui

**9ui** (pronounced GUI) is a Team Fortress 2 UI mod. Unlike most custom HUDs,
9ui only modifies game menus and should be used alongside a second custom HUD
of choice, which is to modify in-game HUD.


## Status

:construction: Under construction :construction:


## Installation

This repository contains the sources used to build 9ui. Once its ready, you
will be able to download the built mod.


## Requirements

### Build

These programs are required to build the project:

- [Python](https://www.python.org/) (3.11 or newer)
- Python modules listed in `requirements.txt`
- [GNU Make](https://www.gnu.org/software/make/)
- [FontForge](https://fontforge.org) (including its Python modules)


### Development

Included development tools require the following additional dependencies:

- Unix-like shell
- [entr](https://github.com/eradman/entr)
- TF2 installation (the `tf2_misc_*.vpk` archives at least)
- setup instructions in [`dev/mount/README.md`](./dev/mount/README.md)


## Building


##### Build everything

```sh
make
```


##### Delete built files

```sh
make clean
```


##### Watch sources and build new or modified files

```sh
make dev
```


##### Update stock files

```sh
make -B stock
```
