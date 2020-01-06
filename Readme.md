#  Environment Setup

## Needed Tools

1. [QEMU](https://www.qemu.org/download/#windows)
2. [Arm Gcc](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)
3. [Make for Win32](http://gnuwin32.sourceforge.net/packages/make.htm)


*Notes:*

1. It is assumed that the OS used is Microsoft Windows.

2. If you're using a Linux based OS you'll need to install only QEMU and Arm Gcc, Make is usually already installed.

3. Qemu and Arm Gcc are packaged by most Linux distributions.

## Project Setup

1. Clone the project using `git clone https://github.com/sebastianardelean/assembly.git` or download the zip archive from `https://github.com/sebastianardelean/assembly`.

2. In Makefile update variable `CROSS_COMPILE_PATH`.

3. Build the project using the `make` command.

4. Run the binary file in Qemu Emulator using one of the following commands:

    a. Qemu in no graphic mode

    `C:\"Program Files"\qemu\qemu-system-arm.exe -M versatilepb -m 128M -nographic -kernel .\hello_world.bin`

    b. Qemu in graphic mode

    `C:\"Program Files"\qemu\qemu-system-arm.exe -M versatilepb -m 128M -kernel .\hello_world.bin`


## Emulated Machine

The application will run bare metal on versatilepb machine. For more informations about this machine and the CPU you can check the following links:

1. [Qemu Versatilepb](https://github.com/stefanha/qemu/blob/master/hw/arm/versatilepb.c)
2. [arm926ej-s](http://infocenter.arm.com/help/topic/com.arm.doc.ddi0198e/DDI0198E_arm926ejs_r0p5_trm.pdf)

If you want to build the software and try it in another machine like **Raspberry Pi 2**, **Netduino2** or **i.MX6 Quad SABRE Lite Board** you will only need to:

1. In Qemu command, change the option `versatilepb` with one from [Qemu Documentation](https://wiki.qemu.org/Documentation/Platforms/ARM)

2. In Makefile change the compiler and assembler options ( COPS and AOPS).
Example: [Options for Rapsberry Pi](https://elinux.org/RPi_Software#ARM)


## Resources

### Web

1. [Arm Developer Suite Assembler Guide](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0068b/CIHEDHIF.html)

2. [Freedom Embedded Arm Emulation](https://balau82.wordpress.com/arm-emulation/)

3. [Arm UART Infos](http://infocenter.arm.com/help/topic/com.arm.doc.ddi0183f/DDI0183.pdf)

4. [ARM926EJ-S User Guide ](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0224i/index.html)

5. [Qemu Wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)

6. [OSDev](http://www.brokenthorn.com/Resources/OSDevIndex.html)

7. [Thinkingeek.com Raspberry Pi Assembly Tutorial](https://thinkingeek.com/arm-assembler-raspberry-pi/?fbclid=IwAR2kRmsNNucT1y3DVnvVk0UGXjCLRWGavTEP_nwXeSd26k9BIwLQGave1Qk)


### Books

1. [ARM System Developers Guide](https://www.amazon.com/ARM-System-Developers-Guide-Architecture/dp/1558608745)

2. [ARM Architecture Reference Manual](https://www.scss.tcd.ie/~waldroj/3d1/arm_arm.pdf)

3. [Computer Systems - A Programmer's Perspective](https://www.amazon.com/Computer-Systems-Programmers-Perspective-2nd/dp/0136108040)
