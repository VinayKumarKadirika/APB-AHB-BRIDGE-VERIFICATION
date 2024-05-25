
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "include_files.sv"

module top;
 bit clk;
 bit reset;

 ahb_interface ahb_interface_h(.hclk(clk),.hresetn(reset));
 apb_interface apb_interface_h(.pclk(clk));

rtl_top dut_inst(.Hclk(clk),
   .Hresetn(ahb_interface_h.hresetn),
   .Htrans(ahb_interface_h.htrans),
	.Hsize(ahb_interface_h.hsize), 
	.Hreadyin(ahb_interface_h.hreadyin),
	.Hwdata(ahb_interface_h.hwdata), 
	.Haddr(ahb_interface_h.haddr),
	.Hwrite(ahb_interface_h.hwrite),
	.Hrdata(ahb_interface_h.hrdata),
    .Hresp(ahb_interface_h.hresp),
	.Hreadyout(ahb_interface_h.hreadyout),
	.Pselx(apb_interface_h.psel),
	.Pwrite(apb_interface_h.pwrite),
	.Penable(apb_interface_h.penable), 
	.Paddr(apb_interface_h.paddr),
	.Pwdata(apb_interface_h.pwdata),
    .Prdata(apb_interface_h.prdata)
);	

initial begin
   uvm_config_db#(virtual ahb_interface)::set(null,"*","ahb_database",ahb_interface_h);
end

initial begin
   uvm_config_db#(virtual apb_interface)::set(null,"*","apb_database",apb_interface_h);
end
 
initial begin
   clk=0;
   forever #5 clk=~clk;
end

initial begin
   reset=0;
   #100;
   reset=1;
end

initial begin
   run_test("test_case_fixed_burst_10_beads");
   //run_test("test_case_incremental_burst_10_beads");
   //run_test("test_case_wrap_burst_16_beads");
end


endmodule
