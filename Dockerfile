FROM resin/amd64-debian

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61
RUN echo "deb http://dl.bintray.com/resin-io/debian stable etcher" > /etc/apt/sources.list.d/etcher.list

RUN apt-get update && apt-get install -y \ 
  etcher-electron \
  usbmount \
  xserver-xorg-input-all \
  xserver-xorg-video-fbdev \
  xorg && rm -rf /var/lib/apt/lists/*

# Move app to filesystem
COPY .xinitrc /root

# uncomment if you want systemd
ENV INITSYSTEM on

# Start app
CMD startx
