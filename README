# Nemo-K Box

The goal of the Nemo-K project is to give DIY people with little or no
programming skills and easy tools to create [SignalK](http://signalk.org/)
sensors.

This repository contains Nemo-K box which is a Docker container compiling
the [Nemo-K firmware](https://github.com/nemo-k-org/firmware) with given
firmware settings.

## Example

To compile a Nemo-K HTTP test firmware with the Box:

```
git clone git@github.com:nemo-k-org/the-box.git
cd the-box
NEMOK_WIFI_SSID=my-yacht-ssid NEMOK_WIFI_PASS=my-yacht-password NEMOK_SENSOR_TEST_HTTP=1 make run-docker
```
If everything goes as planned you should have a fresh firmware at `artefacts/firmware.bin`.

## Updating the image

Before creating the image update the `BOX_VERSION` string in `Makefile`.
`
To create and upload the image to Docker Hub:

```
make build-docker
make push-docker
```
