
class virtual_sequencer extends uvm_sequencer;
  
   `uvm_component_utils(virtual_sequencer)
  
   ahb_sequencer ahb_sequencer_h;
   apb_sequencer apb_sequencer_h;
  
   function new(string name="virtual_sequencer",uvm_component parent=null);
      super.new(name,parent);
   endfunction
  
endclass
