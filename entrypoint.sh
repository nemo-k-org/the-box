#!/bin/bash

cd /workspace

echo "Nemo-K firmware settings:"
env | grep NEMOK

echo "Cloning Nemo K firmware"
git clone https://github.com/nemo-k-org/firmware.git
cd firmware
make build

mkdir temp-artefacts/
cp .pio/build/esp01/firmware.bin temp-artefacts/
cd temp-artefacts/
sha256sum firmware.bin >firmware.bin.sha256

if [ -z $NEMOK_ZIP_PASSWORD ]; then
    7z a -tzip nemo-k-firmware.zip firmware.bin firmware.bin.sha256
else
    7z a -tzip -mem=AES256 -p$NEMOK_ZIP_PASSWORD nemo-k-firmware.zip firmware.bin firmware.bin.sha256
fi

cd ..

if [ -z $NEMOK_UPLOAD_URL ]; then
    rm -f /artefacts/firmware.bin /artefacts/firmware.bin.sha256 /artefacts/nemo-k-firmware.zip
    cp temp-artefacts/* /artefacts/
    ARTEFACTS_OWNER=`stat --format=%u:%g /artefacts/`
    chown $ARTEFACTS_OWNER /artefacts/firmware.bin /artefacts/firmware.bin.sha256 /artefacts/nemo-k-firmware.zip
else
    curl -X POST -F "firmware=@temp-artefacts/nemo-k-firmware.zip" "$NEMOK_UPLOAD_URL"
fi
