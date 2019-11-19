#!/bin/bash
# =========================================================================
# =========================================================================
#
#	winboard
#	  switch to the winboard folder and start winboard.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2019. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/ldc-games
# @subpackage winboard
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

type ${winetricks} >/dev/null 2>&1
[[ $? -eq 0 ]] ||
 {
 	iw_helpers >/dev/null 2>/dev/null
 	[[ $? -eq 0 ]] ||
 	 {
 	 	echo "Unable to install iw_helpers"
 	 	exit 1
 	 }
 }

[[ -e "./.wine/drive_c/${WBOARD_PKG}/WinBoard/winboard.exe" ]] ||
 {
 	echo "Installing WinBoard...."

 	wget ${WBOARD_URL} >/dev/null 2>/dev/null
 	[[ $? -eq 0 ]] ||
 	 {
 	 	echo "Unable to download \"${WBOARD_URL}\""
 	 	exit 2
 	 }
 
 	wine ./${WBOARD_EXE} >/dev/null 2>/dev/null
 }

[[ -d "./.wine/drive_c/${WBOARD_PKG}/P2P" ]] ||
 {
	echo "Installing P2P...."

	mkdir -p "./.wine/drive_c/${WBOARD_PKG}/P2P"
	[[ $? -eq 0 ]] ||
	 {
 		echo "Unable to create \"./.wine/drive_c/${WBOARD_PKG}/P2P\""
 		exit 3
	 }

	cd "./.wine/drive_c/${WBOARD_PKG}/P2P"
	[[ $? -eq 0 ]] ||
	 {
 		echo "Unknown directory \"./.wine/drive_c/${WBOARD_PKG}/P2P\""
 		exit 4
	 }

	wget ${WBOARD_HOST}/${WBOARD_P2P} >/dev/null 2>/dev/null
	[[ $? -eq 0 ]] ||
	 {
 		echo "Unable to download \"${WBOARD_HOST}/${WBOARD_P2P}\""
 		exit 5
	 }
 
	unzip ${WBOARD_P2P}
	[[ $? -eq 0 ]] ||
	 {
 		echo "Unable to unzip \"${WBOARD_HOST}/${WBOARD_P2P}\""
 		exit 6
	 }
 
 }
 
wine ~/.wine/drive_c/${WBOARD_PKG}/WinBoard/winboard.exe "${WBOARD_OPTS}"
exit $?
