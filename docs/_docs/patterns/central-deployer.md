---
title: Central Deployer Pattern
nav_text: Central Deployer
categories: patterns
---

Kubes can be use as either an app-centric or ops-centric tool.

* **app-centric**: Each app repo has it's own `.kubes` settings files. This is useful if your applications are very differently setup.
* **ops-centric**: Each app repo has pretty much the same `.kubes` settings files. This is useful if your applications are very similarly setup.

## Setup

With an ops-centric approach, you use the same `.kubes` settings files for the app repos you want to use. For example:

    https://github.com/org/app1
    https://github.com/org/app2

You then also have a

    https://github.com/org/.kubes

You can simply copy the `.kubes` folder into the app repo folder or even add the `repo/.kubes` as a submodule.

You'll end up with something like this:

    app1/.kubes
    app2/.kubes

Then to deploy different app level settings.

{% include config/app-overrides-cheatsheet.md %}

Also check out: [App Overrides Docs]({% link _docs/config/app-overrides.md %}).

The central deployer approach is removes duplication of the kubes config files between projects. Leveraging app-level overrides gives provides a great degree of control.

If the settings start to diverge too much, then it probably makes sense to use separate .kubes files in that app specific repo.
