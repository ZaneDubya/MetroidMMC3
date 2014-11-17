#!/bin/bash
# Make.sh

# Get location of WINE executable; fail if not found.
WINEBIN=$(which wine)
if [ "$1" = "dev.TxROM" ] && [ "${WINEBIN}" = "" ]; then
	echo "WINE is needed to compile this version of the ROM. Please install."
	exit 1
fi

# Fail if no source directory has been passed.
if [ ! -d "$1" ] || [ "$1" = "" ]; then
	echo Cannot run this script from the command line.
	exit 1
fi

WORKDIR=obj
SRCDIR=$1

# Delete existing work directory and create a new work directory
	rm -rf $WORKDIR 2>/dev/null
	mkdir $WORKDIR

# Copy data/code from the source directory to the work directory.
echo -n Copying make files...
cp $SRCDIR/make.txt $WORKDIR/make.txt 2>/dev/null
echo -ne "\n" >> $WORKDIR/make.txt
echo [done]

if [ -d $SRCDIR/data ]; then
	echo -n Copying Data files...
	mkdir $WORKDIR/data
	cp -R $SRCDIR/data/* $WORKDIR/data/ 2>/dev/null
	echo [done]
fi

echo -n Copying PRG files... 
mkdir $WORKDIR/PRG
cp $SRCDIR/PRG/* $WORKDIR/PRG/ 2>/dev/null
echo [done]

# util\if6502 $SRCDIR/code $WORKDIR/code -all
echo -n Copying code files...
mkdir $WORKDIR/code
cp -R $SRCDIR/code/* $WORKDIR/code/ 2>/dev/null
echo [done]

# Create make.asm file to combine all assembled PRGs into the final ROM.
rm -f $WORKDIR/make.asm 2>/dev/null
touch $WORKDIR/make.asm
echo ".outfile \"bin/${SRCDIR}.nes\"" >> $WORKDIR/make.asm
echo ".include \"code/header.asm\"" >> $WORKDIR/make.asm


# Compile each of the banks in make.txt, and add each to the make.asm file.
while IFS="," read f1 f2 f3 f4 f5;
do
	if [ "$f1" = "map" ]; then
		echo -n "Mapping ${f2}: "
		./util/ophis21/bin/ophis -m "${WORKDIR}/map.txt" "${WORKDIR}/${f2}"
		rm -f "ophis.bin"
		$WINEBIN ./util/GetLabels.exe "${WORKDIR}/map.txt" "${WORKDIR}/${f3}" "${f4}" "${f5}"
	elif [ "$f1" = "prg" ]; then
		echo -n "Assembling ${f2}: "
		./util/ophis21/bin/ophis -o "${WORKDIR}/${f3}.bin" "${WORKDIR}/PRG/${f3}.asm"
		echo ".incbin \"${f3}.bin\"" >> $WORKDIR/make.asm
	fi
done < $WORKDIR/make.txt

rm -rf bin 2&>/dev/null && mkdir bin

# Combine the banks
echo -n "Combining banks into ROM: "
./util/ophis21/bin/ophis obj/make.asm

exit 0
