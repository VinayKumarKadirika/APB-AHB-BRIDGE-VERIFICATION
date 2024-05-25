

`ifndef AHB_INTERFACE
`define AHB_INTERFACE

interface ahb_interface(input bit hclk,hresetn);

   //logic hresetn;
   logic [1:0]htrans;
   logic hwrite;
   logic hreadyin;
   logic [31:0]haddr;
   logic [2:0]hburst;
   logic [31:0]hwdata;
   logic [1:0]hresp;
   logic [31:0]hrdata;
   logic [2:0]hsize;
   logic hreadyout;

	clocking ahb_driver_cb@(posedge hclk);
		//output hresetn;
		output htrans;
		output hwrite;
		output hreadyin;
		output haddr;
		output hburst;
		output hwdata;
		output hsize;
		input hresp;
		input hrdata;
		input hreadyout;
	endclocking

	clocking ahb_monitor_cb@(posedge hclk);
		//input hresetn;
		input htrans;
		input hwrite;
		input hreadyin;
		input haddr;
		input hburst;
		input hwdata;
		input hsize;
		input hresp;
		input hrdata;
		input hreadyout;
	endclocking


	modport ahb_driver_mp(clocking ahb_driver_cb);
	modport ahb_monitor_mp(clocking ahb_monitor_cb);
   

endinterface :ahb_interface

`endif
