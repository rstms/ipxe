FROM debian:bookworm
ARG USER
ARG GID
ARG UID
RUN apt update && apt install -y build-essential perl mtools genisoimage syslinux isolinux liblzma-dev openssl
RUN apt install -y doas vim less
RUN echo "permit nopass keepenv ${USER}" >/etc/doas.conf
RUN addgroup --gid $GID $USER
RUN adduser --uid $UID --gid $GID --disabled-password $USER
ENV HOSTNAME=ipxe-builder
USER $USER
WORKDIR /home/$USER/src
#ENTRYPOINT /bin/bash
