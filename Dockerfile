FROM resin/up-board-node

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61
RUN echo "deb http://dl.bintray.com/resin-io/debian stable etcher" > /etc/apt/sources.list.d/etcher.list

RUN apt-get update && apt-get install -y \ 
  etcher-electron \
  usbmount \
  xserver-xorg-input-all \
  xserver-xorg-video-fbdev \
  xorg && rm -rf /var/lib/apt/lists/*

RUN npm install -g asar

# make etcher great again
RUN asar extract /usr/lib/etcher-electron/resources/app.asar tmpdir \
    && grep -v -E '(width|height)' tmpdir/lib/gui/etcher.js | sed 's/fullscreen: false/fullscreen: true/' > etcher.js.tmp \
    && mv etcher.js.tmp tmpdir/lib/gui/etcher.js \
    && asar pack tmpdir/ /usr/lib/etcher-electron/resources/app.asar \
    && rm -rf tmpdir

# Move app to filesystem
COPY .xinitrc /root

# uncomment if you want systemd
ENV INITSYSTEM on

# Start app
CMD startx
