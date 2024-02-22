#!/bin/bash

cd /workspace

echo "Nemo-K firmware settings:"
env | grep NEMOK

echo "Cloning Nemo K firmware"
git clone https://github.com/nemo-k-org/firmware.git
cd firmware
make build

rm -f /artefacts/firmware.bin /artefacts/firmware.bin.sha256 /artefacts/nemo-k-firmware.zip
cp .pio/build/wemosd1/firmware.bin /artefacts/

cd /artefacts
sha256sum firmware.bin >firmware.bin.sha256
zip nemo-k-firmware firmware.bin firmware.bin.sha256

ARTEFACTS_OWNER=`stat --format=%u:%g .`
chown $ARTEFACTS_OWNER firmware.bin firmware.bin.sha256 nemo-k-firmware.zip
