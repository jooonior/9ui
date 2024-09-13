# `dev/mount`

This directory contains game configuration that helps with HUD development.

## Setup

Adding `-insert_search_path "full/path/to/9ui/dev/mount"` to TF2's launch
options will make it load this configuration (you have to fix the path OFC).
Instead of changing launch options via Steam, you can create a shortcut to
`tf_win64.exe` and append the launch options to its **Target**.

Once you set up the plugin in `dev/mount/addons`, running TF2 with the
before-mentioned launch option will also mount the `build/*` directories.

Note that binds set here might carry over to your regular TF2 installation.
To avoid that, you should bind the affected keys in your `autoexec.cfg`.
