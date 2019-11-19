#!/bin/bash
# ===========================================================================
#
#    ldc-games:daisleriot-0.1.0-b1
#
# ===========================================================================
cd ~/Development/ewsldc/ldc-games

echo "   ********************************************"
echo "   ****"
echo "   **** stopping daisleriot container(s)"
echo "   ****"
echo "   ********************************************"
echo
docker rm ldc-games-daisleriot-0.1.0-b1

echo "   ********************************************"
echo "   ****"
echo "   **** removing daisleriot image(s)"
echo "   ****"
echo "   ********************************************"
echo
docker rmi ewsdocker/ldc-games:daisleriot-0.1.0-b1

echo "   ***************************************************"
echo "   ****"
echo "   **** building ewsdocker/ldc-games:daisleriot-0.1.0-b1"
echo "   ****"
echo "   ***************************************************"
echo
docker build \
  --build-arg BUILD_DAEMON="0" \
  --build-arg BUILD_TEMPLATE="run" \
  \
  --build-arg BUILD_NAME="ldc-games" \
  --build-arg BUILD_VERSION="daisleriot" \
  --build-arg BUILD_VERS_EXT="-0.1.0" \
  --build-arg BUILD_EXT_MOD="-b1" \
  \
  --build-arg FROM_REPO="ewsdocker" \
  --build-arg FROM_PARENT="ldc-lang" \
  --build-arg FROM_VERS="dgtk-gtk3" \
  --build-arg FROM_EXT="-0.1.0" \
  --build-arg FROM_EXT_MOD="-b1" \
  \
  --build-arg LIB_INSTALL="0" \
  --build-arg LIB_VERSION="0.1.6" \
  --build-arg LIB_VERS_MOD="-b1" \
  \
  --build-arg LIB_HOST="http://alpine-nginx-pkgcache" \
  --build-arg AISLERIOT_HOST="http://alpine-nginx-pkgcache" \
  --network=pkgnet\
  \
  --file Dockerfile.daisleriot \
 -t ewsdocker/ldc-games:daisleriot-0.1.0-b1 .
[[ $? -eq 0 ]] ||
 {
 	echo "build ewsdocker/ldc-games:daisleriot-0.1.0-b1 failed."
 	exit 1
 }

echo "   ***********************************************"
echo "   ****"
echo "   **** installing ldc-games-daisleriot-0.1.0-b1"
echo "   ****"
echo "   ***********************************************"
echo

docker run \
   -it \
   \
   -e LMS_BASE="/root/.local" \
   -e LMS_HOME="/root" \
   -e LMS_CONF="/root/.config" \
   \
   -v ${HOME}/bin:/userbin \
   -v ${HOME}/.local:/usrlocal \
   -v ${HOME}/.config/docker:/conf \
   -v ${HOME}/.config/docker/ldc-games-daisleriot-0.1.0:/root \
   -v ${HOME}/.config/docker/ldc-games-daisleriot-0.1.0/workspace:/workspace \
   \
   -e DISPLAY=unix${DISPLAY} \
   -v ${HOME}/.Xauthority:/root/.Xauthority \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v /dev/shm:/dev/shm \
   --device /dev/snd \
   \
   -v ${HOME}/Downloads:/Downloads \
   \
   --name=ldc-games-daisleriot-0.1.0-b1 \
 ewsdocker/ldc-games:daisleriot-0.1.0-b1
[[ $? -eq 0 ]] ||
 {
 	echo "build container ldc-games-daisleriot-0.1.0-b1 failed."
 	exit 1
 }

echo "   ***********************************************"
echo "   ****"
echo "   **** stopping ldc-games-daisleriot-0.1.0-b1"
echo "   ****"
echo "   ***********************************************"
echo

docker stop ldc-games-daisleriot-0.1.0-b1
[[ $? -eq 0 ]] ||
 {
 	echo "stop ldc-games-daisleriot-0.1.0-b1 failed."
 }

echo "   ******************************************************"
echo "   ****"
echo "   **** ldc-games:daisleriot-0.1.0-b1 successfully installed."
echo "   ****"
echo "   ******************************************************"
echo

exit 0

