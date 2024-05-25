
class ahb_transaction extends uvm_sequence_item;

   bit hresetn;
   rand bit [1:0]htrans;
   rand bit hreadyin;
   rand bit hwrite;
   rand bit [31:0]haddr;
   rand bit [2:0]hburst;
   rand bit [31:0]hwdata;
   rand bit [2:0]hsize;
   bit [1:0]hresp;
   bit [31:0]hrdata;
   bit hreadyout;
  

   constraint c_addr{ soft
      haddr inside {[32'h8000_0000:32'h8000_03ff]};
      haddr%4==0;
   }

   constraint c_size{soft hsize==2;}

   constraint c_ready_in{soft hreadyin==1;}
   
   constraint c_write{soft hwrite==1;}
   
   constraint c_burst{soft hburst==0;}


   `uvm_object_utils_begin(ahb_transaction)
   `uvm_field_int(hresetn,UVM_ALL_ON)
   `uvm_field_int(htrans,UVM_ALL_ON)
   `uvm_field_int(hwrite,UVM_ALL_ON)
   `uvm_field_int(hreadyin,UVM_ALL_ON)
   `uvm_field_int(haddr,UVM_ALL_ON)
   `uvm_field_int(hburst,UVM_ALL_ON)
   `uvm_field_int(hwdata,UVM_ALL_ON)
   `uvm_field_int(hresp,UVM_ALL_ON)
   `uvm_field_int(hrdata,UVM_ALL_ON)
   `uvm_field_int(hsize,UVM_ALL_ON)
   `uvm_field_int(hreadyout,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "ahb_transaction");
      super.new(name);
   endfunction

   
endclass
