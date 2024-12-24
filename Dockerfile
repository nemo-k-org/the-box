FROM python:3.12.2-slim

ENV PLATFORMIO_VERSION="6.1.13" \
    BOX_VERSION="${BOX_VERSION}" \
    BOX_NAME="nemo-k-box"

LABEL app.name="${BOX_NAME}" \
      app.version="${BOX_VERSION}"

RUN pip install -U platformio==${PLATFORMIO_VERSION} && \
    mkdir -p /workspace && \
    chmod a+rwx /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    apt update && apt install -y git make p7zip-full curl && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY init-project/ /workspace/init-project/
RUN cd /workspace/init-project/ && platformio run 

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"] 
