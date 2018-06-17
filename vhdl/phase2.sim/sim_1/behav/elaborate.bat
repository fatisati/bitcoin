@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 82de61160d1144b591aa5512e9b7cf45 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot compression_behav xil_defaultlib.compression -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
