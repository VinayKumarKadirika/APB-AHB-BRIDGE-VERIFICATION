
class ahb_monitor extends uvm_monitor;
   `uvm_component_utils(ahb_monitor)

   virtual ahb_interface v_interface_h;

   uvm_analysis_port#(ahb_transaction) ahb_mon2scor;


   function new(string name = "ahb_monitor",uvm_component parent=null);
      super.new(name,parent);
      ahb_mon2scor=new("ahb_mon2scor",this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(! uvm_config_db#(virtual ahb_interface)::get(this,"","ahb_database",v_interface_h)) begin
         `uvm_fatal("AHB-MONITOR ---> CONNECTION FAILED","");
      end

   endfunction
   

   int prev_addr;
   int prev_wdata;
   int prev_rdata;

   task run_phase(uvm_phase phase);
      ahb_transaction trans;
      trans=ahb_transaction::type_id::create("trans",this);
      forever begin
         wait(v_interface_h.hresetn==1);
         trans.haddr  = v_interface_h.haddr;
         trans.hwdata = v_interface_h.hwdata;
         trans.hrdata = v_interface_h.hrdata;
         trans.hwrite = v_interface_h.hwrite;
         trans.htrans = v_interface_h.htrans;
         trans.hreadyin = v_interface_h.hreadyin;
         trans.hreadyout = v_interface_h.hreadyout;
         if(((trans.haddr != prev_addr) && (trans.hwdata != prev_wdata)) || trans.hrdata != prev_rdata) begin
            ahb_mon2scor.write(trans);
            `uvm_info("AHB_MONITOR ---> TRANS DATA",$sformatf("%0s",trans.sprint),UVM_NONE);
            prev_wdata = trans.hwdata;
            prev_addr  = trans.haddr;
            prev_rdata  = trans.hrdata;
         end
         else #10;
      end
   endtask
   
endclass
