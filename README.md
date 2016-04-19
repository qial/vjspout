# VJ Spout
Processing java sketch that uses Spout to output controllable vj visuals.
Import the Spout output in Resolume or other video software. This code
is currently Windows only, although it may be possible to eventually support using Siphon on OSX.

# Instructions
To run in processing, create a folder called "code" and copy into it the
files from the code32 or code64 folder, depending on whether you're using
the 32 or 64 bit version of Processing and Java.

# Keys
#### General Keys
- v - toggles debug output for effects/params

#### Effect Keys
Pressing number 1 to 9 selects that effect.
Some effects have changeable parameters:

- q/a - control param 1
- w/s - control param 2
- e/d - control param 3
- r/f - control param 4

Using shift + key will change parameter by 5 instead of by 1.

# Development info

- vjspout.pde - Main sketch file, loads effects and handles keyboard input.
- effects.pde - Effect interface and helper classes along with specific effect code.
- sequencer.pde - Sequencer handles the math to make sine-like movement easier for effects to use.
- shapes.pde - Helper method for drawing shapes used in effects.

spout.pde, JSpout.java, and files in the code32 and code64 folders are from the Spout2 installation.