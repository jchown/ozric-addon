# Ozric Addon for Home Assistant

This is an [app](https://www.home-assistant.io/apps/) for [Home Assistant](https://www.home-assistant.io/).

## Status

Ozric is currently [alpha](https://en.wikipedia.org/wiki/Software_release_life_cycle#Alpha) quality. Use at your own risk! In particular, no real consideration has been given to security. If your LAN is not trusted, do not use this add on.

## What It Does

By continuously monitoring the states of your various sensors, switches and the environment, Ozric can turn on and off your lights in a very customisable and reactive way.
This logic is customisable and described by a graph, which you can edit visually.

![an animation of a running Ozric graph](docs/running.gif "Ozric Graph")

This is very similar to [Node Red](https://nodered.org/), but Ozric is not message-oriented and doesn't need knowledge of YAML. Instead it is entirely GUI based;
the graph is continuously evaluated and responds to internal (computed) state changes as well as sensor changes.

## Compatibility

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-no-red.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg

Ozric is compatible with [HA OS](https://github.com/home-assistant/operating-system) or [HA Supervised](https://github.com/home-assistant/supervised-installer) installations - as these are built on [Docker](https://docker.com) - on 64-bit Intel/AMD platforms (AMD64) as well as 64-bit ARM (AArch64).

## How To Install It

* Go to the [Apps Repositories](http://homeassistant.local:8123/config/apps/repositories) in your Home Assistant instance.
* Click on the link at the bottom right to Add a repository and add the URL [https://github.com/jchown/ozric-addon](https://github.com/jchown/ozric-addon).
* The app will then be available to install in the main [list of Apps](http://homeassistant.local:8123/config/apps/available), probably near the bottom.

## Privacy & Telemetry

This add on sends crash reports to [Sentry](https://sentry.io/). No other data should leave the container.

## Development

This is a C#/Blazor based application. The source code can be found [on Github](https://github.com/jchown/ozric).