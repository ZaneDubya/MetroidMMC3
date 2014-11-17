REM "Clean" script for Windows command line environment.

REM Set the work directory.
set workdir=obj
set bindir=bin
rmdir /s /q %workdir%
rmdir /s /q %bindir%