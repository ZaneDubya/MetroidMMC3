#!/bin/bash
# Make.sh

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
cp $SRCDIR/code/* $WORKDIR/code/ 2>/dev/null
echo [done]

# Create make.asm file to combine all assembled PRGs into the final ROM.
rm -f $WORKDIR/make.asm 2>/dev/null
touch $WORKDIR/make.asm
echo ".outfile \"bin/${SRCDIR}.nes\"" >> $WORKDIR/make.asm
echo ".include \"code/header.asm\"" >> $WORKDIR/make.asm


# Compile each of the banks in make.txt, and add each to the make.asm file.
while IFS="," read f1 f2 f3 f4 f5;
do
	echo -n "Assembling ${f2}: "
	./util/ophis21/bin/ophis -o "${WORKDIR}/${f3}.bin" "${WORKDIR}/PRG/${f3}.asm"
	echo ".incbin \"${f3}.bin\"" >> $WORKDIR/make.asm
done < $WORKDIR/make.txt

#for /f "tokens=1-5 delims=," %%G in ($WORKDIR/make.txt) do (
#    if %%G==map (
#        echo Mapping %%H:
#        util\ophis.exe -m "$WORKDIR/map.txt" "$WORKDIR/%%H"
#        del "ophis.bin"
#        util\getlabels.exe "$WORKDIR/map.txt" "$WORKDIR/%%I" "%%J" "%%K"
#        REM del "$WORKDIR\map.txt"     -- NOT necessary, as it is in obj folder.
#    )
#    if %%G==prg (
#       echo Assembling %%H:
#        ophis -o "$WORKDIR/%%I.bin" "$WORKDIR\PRG\%%I.asm"
#        echo .incbin "%%I.bin" >> $WORKDIR\make.asm
#    )
#)

rm -rf bin 2&>/dev/null && mkdir bin

# Combine the banks
echo -n "Combining banks into ROM: "
./util/ophis21/bin/ophis obj/make.asm

exit 0
