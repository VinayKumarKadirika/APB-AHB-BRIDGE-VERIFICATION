

class apb_monitor extends uvm_monitor;
   `uvm_component_utils(apb_monitor)

   virtual apb_interface v_interface_h;


   uvm_analysis_port#(apb_transaction) apb_mon2scor;

   function new(string name = "apb_monitor",uvm_component parent=null);
      super.new(name,parent);
      apb_mon2scor = new("apb_mon2scor",this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_database",v_interface_h)) begin
         `uvm_fatal("APB-MONITOR ---> CONNECTION FAILED","");
      end
        
   endfunction
  
   bit [31:0] prev_addr;
   bit [31:0] prev_wdata;
   bit [31:0] prev_rdata;
   
   task run_phase(uvm_phase phase);
      apb_transaction trans;
      trans=apb_transaction::type_id::create("trans",this);
      forever begin
         wait(v_interface_h.psel==1);
         wait(v_interface_h.penable==1);
         trans.psel   = v_interface_h.psel;
         trans.penable= v_interface_h.penable;
         trans.paddr  = v_interface_h.paddr;
         trans.pwdata = v_interface_h.pwdata;
         trans.prdata = v_interface_h.prdata;
         trans.pwrite = v_interface_h.pwrite;
         if(((trans.paddr != prev_addr) && (trans.pwdata != prev_wdata)) || trans.prdata != prev_rdata) begin
            apb_mon2scor.write(trans);
            `uvm_info("APB_MONITOR ---> TRANS DATA",$sformatf("%0s",trans.sprint),UVM_NONE);
            prev_wdata = trans.pwdata;
            prev_rdata = trans.prdata;
            prev_addr  = trans.paddr;
         end
         else #10;
      end
   endtask
   
endclass


