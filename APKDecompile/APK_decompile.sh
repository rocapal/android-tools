#!/bin/bash
#
#  Copyright (C) 2012 GSyC/LibreSoft
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see http://www.gnu.org/licenses/.
#
#  Authors : Roberto Calvo <rocapal at gmail dot es>


APKTOOL="apktool1.4.3/apktool"
DEX2JAR="dex2jar-0.0.9.11/dex2jar.sh"
JAD="jad1.5.8/jad"

if [ "$#" -ne "2" ]; then
	echo "Usage: $0 apk_file results_dir"
	exit -1
fi

APK_FILE=$1
RESULT_DIR=$2
LOG_FILE="/tmp/ap_decompile.log"

#apktool
echo "Running apktool ..."
${APKTOOL} d -f ${APK_FILE} ${RESULT_DIR} #2> ${LOG_FILE}

# obtain dex
echo "Getting DEX files ..."
mkdir -p ${RESULT_DIR}/unzipapk/
unzip ${APK_FILE} -d ${RESULT_DIR}/unzipapk/ #2>> ${LOG_FILE}

# convert dex2jar
echo "Converting DEX-> JAR ..."
${DEX2JAR} ${RESULT_DIR}/unzipapk/classes.dex #2>> ${LOG_FILE}
mkdir -p ${RESULT_DIR}/unzipapk/ap_classes/
unzip ${RESULT_DIR}/unzipapk/classes_dex2jar.jar -d ${RESULT_DIR}/unzipapk/ap_classes/ #2>> ${LOG_FILE}

# decompiling jar to java
echo "Decompiling JARS to JAVA ..."
mkdir -p ${RESULT_DIR}/unzipapk/ap_classes/all/
find ${RESULT_DIR}/unzipapk/ap_classes/ -name *.class -exec cp {} ${RESULT_DIR}/unzipapk/ap_classes/all/ \;

for FILE in `ls ${RESULT_DIR}/unzipapk/ap_classes/all/`; do
	# Sometimes JAD command is bloked, so I use timeout command to limit the time of execution
	timeout -s 9 3 ${JAD} -o -d ${RESULT_DIR}/unzipapk/ap_source/ ${RESULT_DIR}/unzipapk/ap_classes/all/${FILE}
done

echo ""
echo "You have all the source code in ${RESULT_DIR}/unzipapk/ap_source/"
