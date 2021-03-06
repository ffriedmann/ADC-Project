{{

┌──────────────────────────────────────────┐
│ Top level module for ADC-DAC  1.0        │
│ Author: Frank  Freedman                  │
│ Copyright (c) 2011 Frank Freedman        │
│ See end of file for terms of use.        │
└──────────────────────────────────────────┘

This device uses an MCP3201 ADC
IKAlogic 8 bit R2R DAC modded to 12 bits

P  ├P0─────────Clk 7┤           ├ HP3312A function generator
r  ├P1─────────Dat 6┤ MCP3201   │
o  ├P2─────────Csel5┤   V=5V    ├ Vref 5V
p
c  ├
h  ~│
i  ~│12 bits (8-19 for code)
p  ├


}}
'
con
    _clkmode = xtal1 + pll16x
    _clkfreq = 80_000_000

'acq. pins
mcsel  = %00000000_00000000_00000000_00000001      'master csel pin for a/d converters
mclk   = %00000000_00000000_00000000_00000010      'master clock pin for a/d converters
aqval  = %00000000_00000000_00000000_00000100      'get the sample
aqstrt = %00000000_00000000_00000000_00001000      'start sample sequence 
'sample channels
smpd1  = %00000000_00000000_00000000_00010000      ' data input channel 1
smpd2  = %00000000_00000000_00000000_00100000      ' data input channel 2       
smpd3  = %00000000_00000000_00000000_01000000      ' data input channel 3       
smpd4  = %00000000_00000000_00000000_10000000      ' data input channel 4       

ccog = 1                 'set timebase cog to 1
acq_cog1 = 2                 'acq cog to 2

obj
'  clk_gen : "clockgen"
'  acq_con : "acq_module"        'acquisition module startup

var
long  CGEN[6]
long  Dat1[256]
long  Dat2[256]
long  Dat3[256]
long  Dat4[256]

pub main

CGEN[0]:=mcsel
CGEN[1]:=mclk
CGEN[2]:=aqval     
CGEN[3]:=aqstrt


Dat1[0]:=mcsel
Dat1[1]:=mclk
Dat1[2]:=aqval
Dat1[3]:=aqstrt
Dat1[4]:=smpd1

Dat2[0]:=mcsel
Dat2[1]:=mclk
Dat2[2]:=aqval
Dat2[3]:=aqstrt
Dat2[4]:=smpd2

Dat3[0]:=mcsel
Dat3[1]:=mclk
Dat3[2]:=aqval
Dat3[3]:=aqstrt
Dat3[4]:=smpd3

Dat4[0]:=mcsel
Dat4[1]:=mclk
Dat4[2]:=aqval
Dat4[3]:=aqstrt
Dat4[4]:=smpd4





'clk_gen.start_clk(ccog,@CGEN)
'acq_con.acq_init(acq_cog1,@aq_strt,@Dat1)


repeat
 


DAT
{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}