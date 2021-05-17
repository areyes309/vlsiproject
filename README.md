# vlsiproject
VLSI Semester Project - Traffic Light Controller Using VHDL

Traffic light controller manages the traffic on a common intersection in a road.

Hardware: Desktop with at least 22 GB of free hard disk space (19.5 GB for the installation, 6.5 GB for the installer), and at least 1 GB of main memory.

Software: Xilinx – Vivado 2019
Hardware Description Language(HDL): VHDL

Implementation

Designed using VHDL Code

-Source and Test Bench

-Sensor and Timer

-FSM States


States:

S1 – green light (primary state)

S2 – West To East road goes Yellow, then North to South Road remains Red

S3 – When West to East turns Red, then North to South road will turn Green, Timer will run for 10 seconds

S4 – When North and South road turns Yellow, West and East light will remain red

Sensors:

-Emergency Sensor

-Infrared sensor

-Video Sensor

-Vehicle sensor



Clock and Timing:

- Clock Delay of 1 second to begin timing process of the controller

-Timer between states

Timer A – 3 seconds

Timer B – 3 seconds

Timer C – 10 seconds



References

www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl

www.csitsun.pub.ro/courses/Masterat/Xilinx%20Synthesis%20Technology/toolbox.xilinx.com/docsan/xili nx4/data/docs/xst/hdlcode15.html


