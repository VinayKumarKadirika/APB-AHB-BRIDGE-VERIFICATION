
interface apb_interface(input bit pclk);
   
   logic [3:0] psel;
   logic penable;
   logic pwrite;
   logic [31:0]prdata;
   logic [31:0]pwdata;
   logic [31:0]paddr;

clocking apb_driver_cb @(posedge pclk);
	input penable;
	input pwrite;
	input paddr;
	input pwdata;
	output prdata;
	input psel;
endclocking

clocking apb_monitor_cb @(posedge pclk);
	input penable;
	input pwrite;
	input paddr;
	input pwdata;
	input psel;
	input prdata;
endclocking

modport apb_driver_mp(clocking apb_driver_cb);
modport apb_monitor_mp(clocking apb_monitor_cb);

endinterface
