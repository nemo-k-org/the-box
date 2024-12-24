# Nemo-K Box

The goal of the Nemo-K project is to give DIY people with little or no
programming skills and easy tools to create [SignalK](http://signalk.org/)
sensors.

This repository contains Nemo-K box which is a Docker container compiling
the [Nemo-K firmware](https://github.com/nemo-k-org/firmware) with given
firmware settings.

## Examples

To compile a Nemo-K HTTP test firmware with the Box:

```
git clone git@github.com:nemo-k-org/the-box.git
cd the-box
NEMOK_WIFI_SSID=my-yacht-ssid NEMOK_WIFI_PASS=my-yacht-password NEMOK_SENSOR_TEST_HTTP=1 make run-docker
```
If everything goes as planned you should have a fresh firmware at `artefacts/firmware.bin`. The
Box also creates a `nemo-k-firmware.zip` which contains the firmware image and its SHA256sum.

The `NEMOK_ZIP_PASSWORD` variable sets a zip password used to encrypt the zip package. The encryption
works as a certificate for the web service that the uploaded firmware zip originates from the
trusted source. The box gets the variable with the other `NEMOK_` variables.

Instead of copying the firmware to the `artefacts/` the Box can HTTP POST upload `nemo-k-firmware`
to an URL given in environment variable `NEMOK_UPLOAD_URL`. If you are running web frontend the URL
should match to your server API url. It is good idea to avoid whitespaces in the password.

In the following example
 * your Docker host is running Nemo-K web in port 8080 (that's what you get by running `make start` in the web repo)
 * host IP address is 192.168.0.5 (cannot use `localhost` since it would point to the Box container itself)
 * there is a job `1f244af0-614b-4065-b450-979f03e04f19` in the database table `jobs`

```
NEMOK_WIFI_SSID=my-yacht-ssid NEMOK_WIFI_PASS=my-yacht-password NEMOK_SENSOR_TEST_HTTP=1 NEMOK_ZIP_PASSWORD=secret-password NEMOK_UPLOAD_URL=http://192.168.0.5:8080/api/jobs/1f244af0-614b-4065-b450-979f03e04f19/firmware make run-docker
```

## Updating the image

Before creating the image update the `BOX_VERSION` string in `Makefile`.
`
To create and upload the image to Docker Hub:

```
make build-docker
make push-docker
```
