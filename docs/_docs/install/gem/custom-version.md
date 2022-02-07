---
title: How to Use Custom Version of Kubes
nav_text: Custom Version
category: gem
order: 1
---

If you want or need to run a forked version of kubes, here's how:

## Change Version Number

First, clone down the source and change version number so you can identify that it's a custom version.  Clone down the project:

    $ git clone https://github.com/boltops-tools/kubes

Update [lib/kubes/version.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/version.rb) so you'll be able to tell that it's a custom build.  For example:

```ruby
module kubes
  VERSION = "0.8.2.custom"
end
```

There are 2 ways to use the custom version:

1. Gemfile: Forked Git Source
2. Gem Package: Build and Install

## Gemfile: Forked Git Source

Point `kubes ` to use your repo with the forked version.  Example:

Gemfile:

```ruby
source "https://rubygems.org"
gem 'kubes', git: 'https://github.com/REPO/kubes', branch: "master"
```

Remember to change `REPO`, to your repo name.

Then run:

    bundle

## Gem Package: Build and Install

Build the gem package:

    $ bundle
    $ rake build
    pkg/kubes-0.8.2.custom.gem

The produced `.gem` file can used to install the gem. You can install it locally:

    $ gem install pkg/kubes-0.8.2.custom.gem
    $ kubes -v
    0.8.2.custom

Or on any machine with Ruby installed. You can copy it to the machine, ssh into it, and install the custom gem:

    $ scp pkg/kubes-0.8.2.custom.gem user@server.com:
    $ ssh user@server.com
    $ gem install kubes-0.8.2.custom.gem
    $ kubes -v
    0.8.2.custom

## Contributing

Learning how to run a forked version of kubes allows you to make changes to the tool. Consider improving kubes by submitting a Pull Request. See: [Contributing]({% link _docs/contributing.md %}).
