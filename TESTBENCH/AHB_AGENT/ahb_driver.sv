

`define hif v_ahb_interface_h.ahb_driver_mp.ahb_driver_cb

class ahb_driver extends uvm_driver#(ahb_transaction);
   `uvm_component_utils(ahb_driver)

   ahb_transaction ahb_transaction_h;
   
   virtual ahb_interface v_ahb_interface_h;
   
   int ahb_address = 32'h8000_0000;
   
   int non_sequencial_transaction = 2;
   
   int sequencial_transaction = 3;
   
   int count;

   function new(string name = "ahb_driver",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(! uvm_config_db#(virtual ahb_interface)::get(this,"","ahb_database",v_ahb_interface_h)) begin
         `uvm_fatal("AHB-DRIVER ---> CONNECTION FAILED","");
      end
      else begin
         `uvm_info("AHB-DRIVER ---> CONNECTION DONE","",UVM_NONE);
      end

   endfunction
   

   task run_phase(uvm_phase phase);
      forever begin
         fork
            begin
               while(v_ahb_interface_h.hresetn==0) begin
                  @(posedge v_ahb_interface_h.hclk);
               end
            end
            begin
               if(v_ahb_interface_h.hresetn==0) begin
                  reset_logic();
               end
            end
         join_any
         disable fork;
         if(v_ahb_interface_h.hresetn==1) begin
            seq_item_port.get_next_item(ahb_transaction_h);
            count++;
            `uvm_info("AHB DRIVER ---> DATA RECIEVED","",UVM_NONE);
            driver_logic(ahb_transaction_h);
            seq_item_port.item_done();
         end
      end
   endtask


   /*================================================================*/
   /*                         RESET LOGIC                            */
   /*================================================================*/
   task reset_logic();
      v_ahb_interface_h.htrans   <= 'bx;
      v_ahb_interface_h.hreadyin <= 'bx;
      v_ahb_interface_h.hwrite   <= 'bx;
      v_ahb_interface_h.haddr    <= 'bx;
      v_ahb_interface_h.hburst   <= 'bx;
      v_ahb_interface_h.hwdata   <= 'bx;
      v_ahb_interface_h.hsize    <= 'bx;
      wait(v_ahb_interface_h.hresetn==1);
   endtask

   /*================================================================*/
   /*                         DRIVER LOGIC                           */
   /*================================================================*/
   task driver_logic(ahb_transaction trans);
      @(posedge v_ahb_interface_h.hclk);
      @(posedge v_ahb_interface_h.hclk);
      if(count==0) begin
         v_ahb_interface_h.htrans   <= non_sequencial_transaction;
      end
      else begin
         v_ahb_interface_h.htrans   <= sequencial_transaction;
      end
      v_ahb_interface_h.hreadyin <= trans.hreadyin;
      v_ahb_interface_h.hwrite   <= trans.hwrite;
      v_ahb_interface_h.hburst   <= trans.hburst;
      v_ahb_interface_h.hsize    <= trans.hsize;
      //====================================================//
      //                 FIXED BURST --> 10                 //
      //====================================================//
      if(trans.hburst==0) begin
         v_ahb_interface_h.haddr    <= trans.haddr;
      end
      //====================================================//
      //                 INCREMENT BURST --> 10             //
      //====================================================//
      if(trans.hburst==1) begin
         v_ahb_interface_h.haddr    <= ahb_address;
         ahb_address = ahb_address+4;
      end
      //====================================================//
      //                  WRAP BURST --> 16                 //
      //====================================================//
      if(trans.hburst==6) begin
         ahb_address = ahb_address+4;
         v_ahb_interface_h.haddr    <= ahb_address;
         if(ahb_address==32'h8000_0020) begin
            ahb_address = 32'h7fff_fff8;
         end
      end
      
      wait(v_ahb_interface_h.hreadyout==1);
      if(trans.hwrite==1) begin
         v_ahb_interface_h.hwdata   <= trans.hwdata;
      end
      else begin
         v_ahb_interface_h.hwdata   <= 0;
      end
   endtask

endclass
