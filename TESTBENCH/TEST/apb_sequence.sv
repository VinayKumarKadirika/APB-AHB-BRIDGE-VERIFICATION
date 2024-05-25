//=================================================================================//
//                             BASE SEQUENCE                                       //
//=================================================================================//
class apb_base_sequence extends uvm_sequence#(apb_transaction);
   `uvm_object_utils(apb_base_sequence)
      
   function new(string name = "apb_base_sequence");
      super.new(name);
   endfunction

endclass


//=================================================================================//
//                                SEQUENCE 1                                       //
//=================================================================================//
class apb_sequence1 extends apb_base_sequence;
   `uvm_object_utils(apb_sequence1)
      
   apb_transaction apb_transaction_h;
   
   function new(string name = "apb_sequence1");
      super.new(name);
   endfunction


   task body();
      repeat(10) begin
         apb_transaction_h = apb_transaction::type_id::create("apb_transaction_h");
         start_item(apb_transaction_h);
         apb_transaction_h.randomize();
         finish_item(apb_transaction_h);
      end
   endtask

endclass

//=================================================================================//
//                                SEQUENCE 2                                       //
//=================================================================================//
class apb_sequence2 extends apb_base_sequence;
   `uvm_object_utils(apb_sequence2)
      
   apb_transaction apb_transaction_h;
   
   function new(string name = "apb_sequence2");
      super.new(name);
   endfunction


   task body();
      repeat(10) begin
         apb_transaction_h = apb_transaction::type_id::create("apb_transaction_h");
         start_item(apb_transaction_h);
         apb_transaction_h.randomize();
         finish_item(apb_transaction_h);
      end
   endtask

endclass

//=================================================================================//
//                               SEQUENCE 3                                        //
//=================================================================================//
class apb_sequence3 extends apb_base_sequence;
   `uvm_object_utils(apb_sequence3)
      
   apb_transaction apb_transaction_h;
   
   function new(string name = "apb_sequence3");
      super.new(name);
   endfunction


   task body();
      repeat(16) begin
         apb_transaction_h = apb_transaction::type_id::create("apb_transaction_h");
         start_item(apb_transaction_h);
         apb_transaction_h.randomize();
         finish_item(apb_transaction_h);
      end
   endtask

endclass

