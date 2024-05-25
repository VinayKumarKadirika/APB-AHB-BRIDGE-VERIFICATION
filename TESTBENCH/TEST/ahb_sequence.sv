
/*=====================================================================*/
/*                      BASE SEQUENCE                                  */
/*=====================================================================*/
class ahb_base_sequence extends uvm_sequence#(ahb_transaction);
   `uvm_object_utils(ahb_base_sequence)

   ahb_transaction ahb_transaction_h;

   function new(string name = "ahb_base_sequence");
      super.new(name);
   endfunction

  
endclass




/*=====================================================================*/
/*                          SEQUENCE 1                                 */
/*=====================================================================*/
class ahb_sequence1 extends ahb_base_sequence;
   `uvm_object_utils(ahb_sequence1)

   function new(string name = "ahb_sequence1");
      super.new(name);
   endfunction
      
      
   task body();
      repeat(10) begin
         ahb_transaction_h = ahb_transaction::type_id::create("ahb_transaction_h");
         start_item(ahb_transaction_h);
         ahb_transaction_h.randomize();
         finish_item(ahb_transaction_h);
      end
   endtask   
endclass



/*=====================================================================*/
/*                          SEQUENCE 2                                 */
/*=====================================================================*/
class ahb_sequence2 extends ahb_base_sequence;
   `uvm_object_utils(ahb_sequence2)

   function new(string name = "ahb_sequence2");
      super.new(name);
   endfunction

   task body();
      repeat(10) begin
         ahb_transaction_h = ahb_transaction::type_id::create("ahb_transaction_h");
         start_item(ahb_transaction_h);
         ahb_transaction_h.randomize with {hburst==1;};
         finish_item(ahb_transaction_h);
      end
   endtask   
endclass


/*=====================================================================*/
/*                          SEQUENCE 3                                 */
/*=====================================================================*/
class ahb_sequence3 extends ahb_base_sequence;
   `uvm_object_utils(ahb_sequence3)

   function new(string name = "ahb_sequence3");
      super.new(name);
   endfunction

   task body();
      repeat(16) begin
         ahb_transaction_h = ahb_transaction::type_id::create("ahb_transaction_h");
         start_item(ahb_transaction_h);
         ahb_transaction_h.randomize with {hburst==6;};
         finish_item(ahb_transaction_h);
      end
   endtask   
endclass
