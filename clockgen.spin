{{

┌──────────────────────────────────────────┐
│ MCP3201 clock generator module 1.0       │
│ Author: Frank  Freedman                  │
│ Copyright (c) 2011 Frank Freedman        │
│ See end of file for terms of use.        │
└──────────────────────────────────────────┘

This module is used for setting clock cycle time,
clock pulse generation to ADC, Chip Select time,
as well as a sample pulse to another module for
caputuring the output bits of the ADC
CSEL and clk  pins identified in top level module.

}}


'var
'  long  acq_pin    'pin to enable cycle acq system.
'  long  clock_src     'pin for clock out to all the acq modules
'  long  Csel_pin      'pin for out to csel for all acq modules

pub start_clk(cogs,aq_strt)  

coginit(cogs,@genstart, aq_strt)    'startup master timing


dat
genstart
    org 0
    mov     long_ptr,PAR       ' save base address of shared mem
    mov     base_addx,PAR
    rdlong  sample_pin,long_ptr     ' save run/stop signal
    add     long_ptr,#4
    rdlong  pckpin,long_ptr    ' save csel
    add     long_ptr,#4        '
    rdlong  pcsel,long_ptr     ' save apin
    add     long_ptr,#4         '

Clock_set
        'set up clock pulse time 50%,230uS h/l net 460uS
        mov ctra,clka_ctl       ' set NCO mode pin X
        mov frqa,frqa_dv        ' set div for freq/per

Read_ADC ' produce a csel low for a count of 15 pulses
        or      dira,pcsel      ' set csel pin to output
        or      dira,sample_pin ' set sample time out
        andn    outa,pcsel      ' set output to low
        or      dira,pckpin     ' enable clock pulses
        muxz    outa,pckpin     ' turn on clock pulses
        mov     clk_cnts,clock_cnt           ' set to fifteen clock times
        waitpne pckpin,pckpin                  ' wait for first low clock
acq_lp        waitpeq pckpin,pckpin  ' wait for the pin to go high
              or outa,sample_pin             ' enable sample signal
              waitpne pckpin,pckpin        ' wait for pin to go low
              xor  outa,sample_pin           ' end sample signal
              djnz clk_cnts,#acq_lp          ' inner loop fifteen times
        or outa,pckpin                       ' turn off clock
        or outa,pcsel                   ' set the chip select high
    jmp #Read_ADC


'preset values
clka_ctl    long %00100_000 << 23 + 1 << 9 + 0  'mode /  APIN
frqa_dv     long $05000000      'Pulse width = 1/f
clock_cnt   long $0000000e      ' fifteen pulses

'var space
sample_pin  res 1       ' acq valid pin
pckpin      res 1       ' clock pin
pcsel       res 1       ' chipsel pin
long_ptr    res 1       ' address pointer for shareed memory in init.
base_addx   res 1       ' base address of shared memory
clk_cnts    res 1       ' used to set how many clocks pulses
fit $1ef                ' don't let PASM grow beyond $1ef

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