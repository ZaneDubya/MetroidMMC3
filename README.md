Metroid for MMC3
===========
This is the source code of METROID, as disassembled by SnoBro and commented by
Dirty McDingus. The source code has been changed to use the MMC3 (the original
METROID game used the MMC1), but no other functionality has been removed or
added. You can reassemble this using the Ophis Assembler:
https://hkn.eecs.berkeley.edu/~mcmartin/ophis/

The disassembly is separated by bank, so I set up a rudimentary make system that
will assemble each separate bank using Ophis, and then combine the banks into
a NES binary. To make the ROM, you need run the 'make_xxxxx.bat' file (this
requires the windows shell, of course).

Moving forward...
===========
The source code is currently about 75% documented, which is an amazing
accomplishment. I'd like to see the remainder of the source code documented, but
it's too big a project for me to take on as an individual. Would anyone be
interested in taking it on as a group project? Each interested person could
take on a single undocumented routine, one at a time, figure out what it does,
and then name it and document it.