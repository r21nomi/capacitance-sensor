# capacitance-sensor

## References
[Illutron/AdvancedTouchSensing](https://github.com/Illutron/AdvancedTouchSensing)

## Setup
### Arduino
<img src="assets/schematic.jpg" width="250"/>  

1. Write [Arduino_sensing.ino](https://github.com/r21nomi/capacitance-sensor/blob/master/Arduino_sensing/Arduino_sensing.ino) to your board

### SuperCollider
1. Open [sound.scd](https://github.com/r21nomi/capacitance-sensor/blob/master/audio/sound.scd)
2. `Language > Boot Server`
3. Select whole program
4. `Language > Evaluate Selection, Line or Region`

### Processing
1. Connect your PC to power source
2. Connect Arduino
3. Run [Visualizer.pde](https://github.com/r21nomi/capacitance-sensor/blob/master/Visualizer/Visualizer.pde)
4. Change the number of serial port with the value on console
5. Run again
6. Change the values `VOL_MIN`, `VOL_MAX` and `BOUNDARY` with the values on console  

※To run the program again, once you need to unplug the USB, and connect it to PC again
```shell
Error, disabling serialEvent() for /dev/cu.usbmodem1411
null
```

## License
```
MIT License

Copyright (c) 2016 Ryota Niinomi (r21nomi)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
