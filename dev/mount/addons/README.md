# `dev/mount/addons`

This directory contains a plugin that implements various utilities for HUD
development.

## Setup

The plugin is written in Lua and requires [`lua_plugin`][lua_plugin] binaries
to function. You must download those if you want to make use of it.

1. Download an archive for your platform from the
   [plugin release page][release].
2. Extract `lua_plugin.dll` and `lua51.dll` from the archive into this
   directory.
3. Rename the extracted `lua_plugin.dll` to `9ui_devtools.dll`.

(on Linux, the binaries are named `lua_plugin.so`/`9ui_devtools.so` and
`libluajit.*.so.*` instead)

[lua_plugin]: https://github.com/jooonior/lua_plugin
[release]: https://github.com/jooonior/lua_plugin/releases/tag/v1.2.0

## Functionality

Currently, the only thing the plugin does it mount all `build/*` directories.
