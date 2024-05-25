
/*========================================================================*/
/*                          BASE TEST                                     */
/*========================================================================*/
class base_test extends uvm_test;
   `uvm_component_utils(base_test)

   environment environment_h;

   function new(string name = "base_test",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      environment_h  = environment::type_id::create("environment_h",this);
   endfunction
   
endclass


/*========================================================================*/
/*                        TEST CASE 1                                     */
/*========================================================================*/
class test_case_fixed_burst_10_beads extends base_test;
   `uvm_component_utils(test_case_fixed_burst_10_beads)

   virtual_sequence1 virtual_sequence_h;

   function new(string name = "test_case_fixed_burst_10_beads",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      virtual_sequence_h = virtual_sequence1::type_id::create("virtual_sequence_h",this);
      virtual_sequence_h.start(environment_h.virtual_sequencer_h);
      #20;
      phase.drop_objection(this);
   endtask

endclass


/*========================================================================*/
/*                        TEST CASE 2                                     */
/*========================================================================*/
class test_case_incremental_burst_10_beads extends base_test;
   `uvm_component_utils(test_case_incremental_burst_10_beads)

   virtual_sequence2 virtual_sequence_h;

   function new(string name = "test_case_incremental_burst_10_beads",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      virtual_sequence_h = virtual_sequence2::type_id::create("virtual_sequence_h",this);
      virtual_sequence_h.start(environment_h.virtual_sequencer_h);
      #20;
      phase.drop_objection(this);
   endtask

endclass


/*========================================================================*/
/*                        TEST CASE 3                                     */
/*========================================================================*/
class test_case_wrap_burst_16_beads extends base_test;
   `uvm_component_utils(test_case_wrap_burst_16_beads)

   virtual_sequence3 virtual_sequence_h;

   function new(string name = "test_case_wrap_burst_16_beads",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      virtual_sequence_h = virtual_sequence3::type_id::create("virtual_sequence_h",this);
      virtual_sequence_h.start(environment_h.virtual_sequencer_h);
      #20;
      phase.drop_objection(this);
   endtask

endclass



