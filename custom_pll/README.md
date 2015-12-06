
# Generating custom frequencies using a PLL

The aim of this code is to provide a tool that automatically generates parameters for a Phase-Locked Loop (PLL).  

This code uses **two stages: a PLL and a prescaler**.  

**A)** In first place, the PLL generates a frequency that falls within its working range (16 to 275 MHz).  
![](pll_equation.png)  
(from the [Lattice docs](http://www.latticesemi.com/~/media/LatticeSemi/Documents/ApplicationNotes/IK/iCE40sysCLOCKPLLDesignandUsageGuide.pdf?document_id=47778) page 7)  

**B)** Then, a simple prescaler  divides that frequency in multiples of two.  
![](prescaler_equation.png)  
([from the Juan Gonzalez FPGA tutorials](https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki/Cap%C3%ADtulo-5%3A-Prescaler-de-N-bits))  


By tuning the values of DIVR, DIVF and N it is possible to generate a broad range of output frequencies.  

Want to set up your own PLL? Check out the following instructions:  

1) Getting the parameters
--

Run the python script <calc_pll_parameters.py> in order to get proper values for DIVR, DIVF and PRESCALER_N.  
For example, if you want to generate a **1Hz signal**:  
```
$ python calc_pll_parameters.py 

Type the desired output frequency (i.e. 44100). Value in Hz: 1

Now program the PLL with one of the following sets of parameters:
 1) DIVR=1010  DIVF=1111010  PRESCALER_N=27  Fout=0.999732451005Hz (error=0.000267548994584Hz)
 2) DIVR=0100  DIVF=0000110  PRESCALER_N=24  Fout=1.00135803223Hz (error=0.00135803222656Hz)
 3) DIVR=0100  DIVF=0001101  PRESCALER_N=25  Fout=1.00135803223Hz (error=0.00135803222656Hz)
 4) DIVR=0100  DIVF=0011011  PRESCALER_N=26  Fout=1.00135803223Hz (error=0.00135803222656Hz)
 5) DIVR=0100  DIVF=0110111  PRESCALER_N=27  Fout=1.00135803223Hz (error=0.00135803222656Hz)
```

2) Fit the parameters into the verilog code
--

Say we want to use the first set of parameters:
```
DIVR=1010
DIVF=1111010
PRESCALER_N=27  
```
These should yield a frequency of about 0.9997Hz (an error of ~0.0003Hz from the desired 1Hz)  
If you open the <custom_pll.v> file you'll observe these values already fitted into the code.  


3) Program the FPGA
--

Finally you can program the board:  
```
$ make sint
$ sudo iceprog custom_pll.bin
```

If you have used the example parameters, one of the red LEDs should start blinking at approximately 1Hz.  

IMPORTANT READ: future work
--
This approach is very simple and does not take into account "Fine Delay Adjustments" (FDA) nor configurations of the Voltage Controlled Oscillator (VCO) such as DIVQ and FILTER_RANGE. This may cause problems since either the VCO or the phase detector may not be operating within its working range.  
**You should always check the outputs with an oscilloscope in order to verify that they are square waves of the desired frequency**  


Acknowledgements
--
This code has been possible thanks to Clifford Wolf  
<https://github.com/cliffordwolf/yosys/issues/107#issuecomment-162163626>

