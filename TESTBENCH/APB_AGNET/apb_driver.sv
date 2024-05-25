`define pif v_apb_interface_h.apb_driver_mp.apb_driver_cb

class apb_driver extends uvm_driver#(apb_transaction);
   `uvm_component_utils(apb_driver)

   apb_transaction apb_transaction_h;
   virtual apb_interface v_apb_interface_h;

   function new(string name = "apb_driver",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_database",v_apb_interface_h)) begin
         `uvm_fatal("APB-DRIVER ---> CONNECTION FAILED","");
      end
      else begin
         `uvm_info("APB-DRIVER ---> CONNECTION DONE","",UVM_NONE);
      end
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(apb_transaction_h);
         `uvm_info("APB DRIVER ---> DATA RECIEVED","",UVM_NONE);
         count=0;
         driver_logic(apb_transaction_h);
         seq_item_port.item_done();
      end
   endtask

   int count;
   task driver_logic(apb_transaction trans);
      @(posedge v_apb_interface_h.pclk);
      wait(v_apb_interface_h.psel==1);
      @(posedge v_apb_interface_h.pclk);
      wait(v_apb_interface_h.penable==1);
      if(v_apb_interface_h.pwrite == 0) begin
         v_apb_interface_h.prdata <= trans.prdata;
      end
      else begin
         v_apb_interface_h.prdata <= 0;
      end
   endtask


endclass



