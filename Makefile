.PHONY: all build program clean view

all: build

build:
	vivado -mode batch -source build.tcl

program:
	openFPGALoader -b arty_a7_100t build/top.bit

view:
	ffplay -f v4l2 -input_format mjpeg -video_size 640x480 -framerate 60 /dev/video2

clean:
	rm -rf build *.jou *.log .Xil clk_wiz_0 vivado*

help:
	@echo "Makefile targets:"
	@echo "  make build    - Build bitstream with Vivado"
	@echo "  make program  - Program FPGA with openFPGALoader"
	@echo "  make view     - Open ffplay to validate VGA output"
	@echo "  make clean    - Clean build artifacts"
