#!/bin/bash

sudo apt-get update
sudo apt-get install git libtool build-essential pkg-config autoconf
sudo apt-get install liba52-0.7.4-dev libdirac-dev libdvdread-dev libkate-dev libass-dev libbluray-dev libcddb2-dev libdca-dev libfaad-dev libflac-dev libmad0-dev libmodplug-dev libmpcdec-dev libmpeg2-4-dev libogg-dev libopencv-dev libpostproc-dev libshout3-dev libspeex-dev libspeexdsp-dev libssh2-1-dev liblua5.1-0-dev libopus-dev libschroedinger-dev libsmbclient-dev libtwolame-dev libx264-dev libxcb-composite0-dev libxcb-randr0-dev libxcb-xv0-dev libzvbi-dev libdvbpsi-dev libasound2-dev libxml2-dev libxpm-dev libsdl1.2-dev sdl-image1.2 libxcb-keysyms1-dev libxinerama-dev libxext-dev qt4-dev-tools libvpx1 libvpx-dev libiso9660-dev 
sudo apt-get install pulseaudio alsa-utils avahi-daemon

git clone git://git.videolan.org/vlc/vlc-2.2.git
cd vlc-2.2
./bootstrap
./configure --prefix=/usr/local --enable-mmal --enable-rpi-omxil --enable-flac --enable-omxil --enable-omxil-vout --enable-dbus --enable-libmpeg2 --enable-vpx --enable-mkv --enable-mpc --enable-theora --enable-dvbpsi --enable-x264 --enable-bluray=no
./compile
echo $?

cat > ~/Desktop/tvlc.sh << EOF
#!/bin/bash

# Restart vlc if it crashes
VLC=vlc --vout mmal_vout --mmal-adjust-refreshrate --deinterlace 0 --extraintf=http --http-password foo --preferred-resolution=360
while [ True ]; do $VLC; done
EOF

cat > .config/autostart/tvlc.desktop << EOF
[Desktop Entry]
Type=Application
Exec=/home/pi/Desktop/tvlc.sh
EOF
