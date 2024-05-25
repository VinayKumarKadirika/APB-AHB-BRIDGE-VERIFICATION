
class ahb_sequencer extends uvm_sequencer#(ahb_transaction);
   `uvm_component_utils(ahb_sequencer)

   function new(string name = "ahb_sequencer",uvm_component parent);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

endclass
