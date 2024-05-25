
class apb_transaction extends uvm_sequence_item;

   bit [3:0] psel;
   bit penable;
   bit pwrite;
   rand bit [31:0]prdata;
   bit [31:0]pwdata;
   bit [31:0]paddr;

   `uvm_object_utils_begin(apb_transaction)
   `uvm_field_int(psel,UVM_ALL_ON)
   `uvm_field_int(penable,UVM_ALL_ON)
   `uvm_field_int(pwrite,UVM_ALL_ON)
   `uvm_field_int(prdata,UVM_ALL_ON)
   `uvm_field_int(pwdata,UVM_ALL_ON)
   `uvm_field_int(paddr,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "apb_sequence");
      super.new(name);
   endfunction

   
endclass
