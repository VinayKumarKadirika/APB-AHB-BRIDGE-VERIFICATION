
class environment extends uvm_env;
   `uvm_component_utils(environment)
   
   virtual_sequencer virtual_sequencer_h;
   ahb_agent ahb_agent_h;
   apb_agent apb_agent_h;
   scoreboard scoreboard_h;
   
   function new(string name = "environment",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ahb_agent_h = ahb_agent::type_id::create("ahb_agent_h",this);
      apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
      virtual_sequencer_h = virtual_sequencer::type_id::create("virtual_sequencer_h",this);
      scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      virtual_sequencer_h.ahb_sequencer_h = ahb_agent_h.ahb_sequencer_h;
      virtual_sequencer_h.apb_sequencer_h = apb_agent_h.apb_sequencer_h;
      apb_agent_h.apb_monitor_h.apb_mon2scor.connect(scoreboard_h.apb_mon2scor);
      ahb_agent_h.ahb_monitor_h.ahb_mon2scor.connect(scoreboard_h.ahb_mon2scor);
   endfunction

endclass
