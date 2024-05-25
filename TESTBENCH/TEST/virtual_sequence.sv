
//========================================================================//
//                         BASE VIRTUAL SEQUENCE                          //
//========================================================================//
class base_virtual_sequence extends uvm_sequence;
  
   virtual_sequencer virtual_sequencer_h;
  
  `uvm_object_utils(base_virtual_sequence)
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  function new(string name="virtual_sequence");
    super.new(name);
  endfunction
  
endclass
    

//========================================================================//
//                           VIRTUAL SEQUENCE  1                          //
//========================================================================//
class virtual_sequence1 extends base_virtual_sequence;
  
   ahb_sequence1 ahb_sequence_h;
   apb_sequence1 apb_sequence_h;
   ahb_sequencer ahb_sequencer_h;
   apb_sequencer apb_sequencer_h;
  
  `uvm_object_utils(virtual_sequence1)
  
  function new(string name="virtual_sequence1");
    super.new(name);
  endfunction
  
  
  task body();
     ahb_sequence_h=ahb_sequence1::type_id::create("ahb_sequence_h");
     apb_sequence_h=apb_sequence1::type_id::create("apb_sequence_h");
     fork
        ahb_sequence_h.start(p_sequencer.ahb_sequencer_h);
        apb_sequence_h.start(p_sequencer.apb_sequencer_h);
     join
  endtask
  
endclass
    

//========================================================================//
//                           VIRTUAL SEQUENCE  2                          //
//========================================================================//
class virtual_sequence2 extends base_virtual_sequence;
  
   ahb_sequence2 ahb_sequence_h;
   apb_sequence2 apb_sequence_h;
   ahb_sequencer ahb_sequencer_h;
   apb_sequencer apb_sequencer_h;
  
  `uvm_object_utils(virtual_sequence2)
  
  function new(string name="virtual_sequence2");
    super.new(name);
  endfunction
  
  
  task body();
     ahb_sequence_h=ahb_sequence2::type_id::create("ahb_sequence_h");
     apb_sequence_h=apb_sequence2::type_id::create("apb_sequence_h");
     fork
        ahb_sequence_h.start(p_sequencer.ahb_sequencer_h);
        apb_sequence_h.start(p_sequencer.apb_sequencer_h);
     join
  endtask
  
endclass
    

//========================================================================//
//                           VIRTUAL SEQUENCE  3                          //
//========================================================================//
class virtual_sequence3 extends base_virtual_sequence;
  
   ahb_sequence3 ahb_sequence_h;
   apb_sequence3 apb_sequence_h;
   ahb_sequencer ahb_sequencer_h;
   apb_sequencer apb_sequencer_h;
  
  `uvm_object_utils(virtual_sequence3)
  
  function new(string name="virtual_sequence3");
    super.new(name);
  endfunction
  
  
  task body();
     ahb_sequence_h=ahb_sequence3::type_id::create("ahb_sequence_h");
     apb_sequence_h=apb_sequence3::type_id::create("apb_sequence_h");
     fork
        ahb_sequence_h.start(p_sequencer.ahb_sequencer_h);
        apb_sequence_h.start(p_sequencer.apb_sequencer_h);
     join
  endtask
  
endclass
    
