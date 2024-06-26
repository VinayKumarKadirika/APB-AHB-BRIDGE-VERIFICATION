
class apb_agent extends uvm_agent;
   `uvm_component_utils(apb_agent)

   apb_sequencer apb_sequencer_h;
   apb_driver apb_driver_h;
   apb_monitor apb_monitor_h;

   function new(string name = "apb_agent",uvm_component parent);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_sequencer_h = apb_sequencer::type_id::create("apb_sequencer_h",this);
      apb_driver_h    = apb_driver::type_id::create("apb_driver_h",this);
      apb_monitor_h   = apb_monitor::type_id::create("apb_monitor_h",this);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      apb_driver_h.seq_item_port.connect(apb_sequencer_h.seq_item_export);
   endfunction

endclass
