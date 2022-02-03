---
title: Boot Hooks
---

If you need to hook into the Kubes boot process super-early on, Kubes boot hooks are designed for that.

* They run very early in the Kubes boot process.
* They are useful for setting shared global values like env vars.
* Boot hooks are ruby files that get required. It's nice and simple. There's no interface to learn.

## Hooks

Kubes will searches 2 files in the `config` folder. If the files exist, they will be ran in this order.

1. **.kubes/config/boot.rb**: Always runs.
2. **.kubes/config/boot/KUBES_ENV.rb**: Runs based on the env. IE: `KUBES_ENV=dev` => `.kubes/config/boot/dev.rb`

Both files are required and ran if they both exists. Since the `KUBES_ENV` one runs second, it can be used to override previously set values.

## Example: Default KUBES_ENV

If you prefer a different default than `KUBES_ENV=dev`.

config/boot.rb

```ruby
ENV['KUBES_ENV'] ||= 'development'
```

This changes the default for everyone using the project, but still allows them to control the default by adding `export KUBES_ENV=development` to their `~/.bash_profile`.

## Example: Auto-Switch AWS_PROFILE

One useful example is switching `AWS_PROFILE` based on the `KUBES_ENV`. Example:

config/boot/dev.rb

```ruby
ENV['AWS_PROFILE'] = 'dev'
```

This example is for AWS, but you can can do similiar switch logic with `GOOGLE_APPLICATION_CREDENTIALS`, etc.

## Boot Source

Please refer to the boot source code for more details: [kubes/booter.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/booter.rb)
