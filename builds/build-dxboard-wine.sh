#!/bin/bash
# =========================================================================
# =========================================================================
#
#	build-dxboard-wine
#	  build the ldc-games:dxboard-wine image and create a container for XBoard.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2019. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/ldc-games
# @subpackage xboard
#
# =========================================================================
#
#	Copyright © 2019. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/ldc-games.
#
#   ewsdocker/ldc-games is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/ldc-games is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/ldc-games.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

cd ~/Development/ewsldc/ldc-games

echo "   ********************************************"
echo "   ****"
echo "   **** removing dxboard container"
echo "   ****"
echo "   ********************************************"
echo
docker stop ldc-games-dxboard-0.1.0-wine > /dev/null 2>&1
docker rm ldc-games-dxboard-0.1.0-wine > /dev/null 2>&1

echo "   ********************************************"
echo "   ****"
echo "   **** removing dxboard image"
echo "   ****"
echo "   ********************************************"
echo
docker rmi ewsdocker/ldc-games:dxboard-0.1.0-wine > /dev/null 2>&1

# ===========================================================================
#
#    ldc-games:dxboard-0.1.0-wine
#
# ===========================================================================

echo "   ***************************************************"
echo "   ****"
echo "   **** building ewsdocker/ldc-games:dxboard-0.1.0-wine image "
echo "   ****"
echo "   ***************************************************"
echo

docker build \
  --build-arg RUN_APP="chess" \
  \
  --build-arg BUILD_NAME="ldc-games" \
  --build-arg BUILD_VERSION="dxboard" \
  --build-arg BUILD_VERS_EXT="-0.1.0" \
  --build-arg BUILD_EXT_MOD="-wine" \
  \
  --build-arg FROM_REPO="ewsdocker" \
  --build-arg FROM_PARENT="ldc-wine" \
  --build-arg FROM_VERS="dwine" \
  --build-arg FROM_EXT="-0.1.0" \
  --build-arg FROM_EXT_MOD="" \
  \
  --build-arg LIB_INSTALL="0" \
  \
  --build-arg LIB_HOST="http://alpine-nginx-pkgcache" \
   \
   --network=pkgnet \
  \
  --file Dockerfile.dxboard \
  -t ewsdocker/ldc-games:dxboard-0.1.0-wine  .
[[ $? -eq 0 ]] ||
 {
 	echo "build ewsdocker/ldc-games:dxboard-0.1.0-wine failed."
 	exit 1
 }

echo "   ***********************************************"
echo "   ****"
echo "   **** installing ldc-games-dxboard-0.1.0-wine container"
echo "   ****"
echo "   ***********************************************"
echo

docker run \
  -it \
  \
  -e LRUN_APP="chess" \
  \
  -e LMSLIB_INST="0" \
  \
  -e LMS_HOME="${HOME}" \
  -e LMS_CONF="${HOME}/.config" \
  -e LMS_BASE="${HOME}/.local" \
  \
  -v ${HOME}/bin:/userbin \
  -v ${HOME}/.local:/usrlocal \
  -v ${HOME}/.config/docker:/conf \
  -v ${HOME}/.config/docker/ldc-games-dxboard-0.1.0:/root \
  -v ${HOME}/.config/docker/ldc-games-dxboard-0.1.0/workspace:/workspace \
  \
  -v ${HOME}/source:/repo \
  -v ${HOME}/Downloads:/Downloads \
  \
  -e DISPLAY=unix${DISPLAY} \
  -v ${HOME}/.Xauthority:/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  \
  --device /dev/snd \
  -v /dev/shm:/dev/shm \
  \
  -it \
  --name=ldc-games-dxboard-0.1.0-wine \
ewsdocker/ldc-games:dxboard-0.1.0-wine
[[ $? -eq 0 ]] ||
 {
 	echo "build container ldc-games-dxboard-0.1.0-wine failed."
 	exit 1
 }

echo "   ********************************************"
echo "   ****"
echo "   **** ldc-games:dxboard-wine successfully installed."
echo "   ****"
echo "   ********************************************"
echo

exit 0

