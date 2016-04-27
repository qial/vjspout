# VJ Spout
Processing 3.0 java sketch that uses Spout to output controllable vj visuals.
Import the Spout output in Resolume or other video software. 

At the moment this sketch is primarily used to output shapes in grayscale which is then
imported into Resolume Avenue as a mask over visualizations provided by MilkDrop2.

This sketch is currently Windows only, although it may be possible to eventually support 
using Siphon instead of Spout on OSX. If anyone is interested in helping to develop Siphon 
support, definitely let me know or send a pull request. I also use a Macbook for some
things and would love to have full support for this sketch on OSX, but I haven't spent
the time to look into it.

I often stream visual development and other things at http://twitch.tv/theqial 

Feel free to drop by and say hello!

# Requirements
- Java 7/8 JDK - http://java.com/en/download/
- Processing 3 - http://processing.org
- Spout2 - http://spout.zeal.co/

#### Recommended 
- Winamp & MilkDrop2 w/Spout
- Resolume Avenue or other VJ software to combine the two.

# Instructions
To run in processing, create a folder called "code" and copy into it the
files from the code32 or code64 folder, depending on whether you're using
the 32 or 64 bit version of Processing and Java. Then simply open the vjspout.pde
file in the Processing editor and hit the run button.

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
- t/g - control param 5
- y/h - control param 6

Using shift + key will change parameter by 5 instead of by 1.

# Development info

- *vjspout.pde* - Main sketch file, loads effects and handles keyboard input.
- *effect.pde* - Effect interface and utility classes
- *effects.pde* - Individual effect implementations 
- *sequencer.pde* - Sequencer handles the math to make sine-like movement easier for effects to use.
- *shape.pde* - Beginning work on an API for defining effects
- *shapes.pde* - Helper methods for drawing shapes used in effects.

spout.pde, JSpout.java, and files in the code32 and code64 folders are copied from the Spout2 installation.

### Development goals:

- Save/load effect parameters
- Load new effects on the fly instead of a compiled 1-9 list.
- Automatic export-to-video button for good effects
- Better effect abstraction to describe effects as shapes moving through time and hide the math.
- Support for colored textures and effects beyond grayscale.
- MIDI input support to change effect parameters using hardware controllers
- Support for choosing output resolutions
- Seamlessly transform effect code to produce same output across range of resolutions.
