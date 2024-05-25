class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)


   apb_transaction apb_trans;
   ahb_transaction ahb_trans;

   `uvm_analysis_imp_decl(_name)
   uvm_analysis_imp#(apb_transaction,scoreboard) apb_mon2scor;
   uvm_analysis_imp_name#(ahb_transaction,scoreboard) ahb_mon2scor;

   int mem_pwdata[$];
   int mem_prdata[$];
   int mem_paddr[$];
   int mem_hwdata[$];
   int mem_hrdata[$];
   int mem_haddr[$];

   int paddr;
   int haddr;
   int pwdata;
   int hwdata;
   int prdata;
   int hrdata;

   semaphore apb_sema = new(1);
   semaphore ahb_sema = new(1);

   covergroup cg();
      cp1:coverpoint apb_trans.psel{ bins b1_1[1] = {0,1};}
      cp2:coverpoint apb_trans.penable;
      cp3:coverpoint apb_trans.pwrite{ bins b3_1[1] = {1}; bins b3_2[1] = {0};}
      cp4:coverpoint apb_trans.paddr { bins b4_1[10] = {[32'h8000_0000:32'h8000_03ff]}; }
      cp5:coverpoint apb_trans.pwdata{ bins b5_1[10] = {[32'h0000_0000:32'hffff_ffff]}; }
      cp6:coverpoint apb_trans.prdata{ bins b6_1[1] = {[32'h0000_0000:32'hffff_ffff]}; }
      cp7:coverpoint ahb_trans.hwrite{ bins b7_1[1] = {1}; bins b7_2[1] = {0};}
      cp8:coverpoint ahb_trans.haddr { bins b8_1[10] = {[32'h8000_0000:32'h8000_03ff]}; }
      cp9:coverpoint ahb_trans.hwdata{ bins b9_1[10] = {[32'h0000_0000:32'hffff_ffff]}; }
      cp10:coverpoint ahb_trans.hrdata{ bins b10_1[1]= {[32'h0000_0000:32'hffff_ffff]}; }
      cp11:coverpoint ahb_trans.hburst{ bins b11_1[1] = {0,1,6};}
      cp12:coverpoint ahb_trans.htrans{ bins b12_1[1] = {2,3};}
      cp14:cross cp3,cp5;
      cp15:cross cp7,cp9;
   endgroup



   function new(string name = "scoreboard",uvm_component parent=null);
      super.new(name,parent);
      cg=new;
      apb_mon2scor = new("apb_mon2scor",this);
      ahb_mon2scor = new("ahb_mon2scor",this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_trans=apb_transaction::type_id::create("apb_trans",this);
      ahb_trans=ahb_transaction::type_id::create("ahb_trans",this);
   endfunction

   function void write_name(ahb_transaction ahb_trans);
      this.ahb_trans = ahb_trans;
      if(ahb_trans.hreadyin==1 || ahb_trans.hreadyout==1) begin
         `uvm_info("SCOREBOARD ---> AHB DATA RECIEVED","",UVM_NONE);
         mem_hwdata.push_back(ahb_trans.hwdata);
         mem_hrdata.push_back(ahb_trans.hrdata);
         mem_haddr.push_back(ahb_trans.haddr);
         ahb_sema.put(1);
      end
   endfunction
   
   function void write(apb_transaction apb_trans);
      this.apb_trans = apb_trans;
      if(apb_trans.psel==1 && apb_trans.penable==1) begin
         `uvm_info("SCOREBOARD ---> APB DATA RECIEVED","",UVM_NONE);
         mem_pwdata.push_back(apb_trans.pwdata);
         mem_prdata.push_back(apb_trans.prdata);
         mem_paddr.push_back(apb_trans.paddr);
         apb_sema.put(1);
      end
   endfunction
   
   task run_phase(uvm_phase phase);
      forever begin
         
         apb_sema.get(1);
         ahb_sema.get(1);

         cg.sample();

         pwdata = mem_pwdata.pop_front();
         prdata = mem_prdata.pop_front();
         paddr  = mem_paddr.pop_front();
         hwdata = mem_hwdata.pop_front();
         hrdata = mem_hrdata.pop_front();
         haddr  = mem_haddr.pop_front();
        
         `uvm_info("SB ---> TEMP VARS",$sformatf("PWDATA=%0h,HWDATA=%0h",pwdata,hwdata),UVM_NONE);
         `uvm_info("SB ---> TEMP VARS",$sformatf("PRDATA=%0h,HRDATA=%0h",prdata,hrdata),UVM_NONE);
         `uvm_info("SB ---> TEMP VARS",$sformatf("PADDR=%0h,HADDR=%0h",paddr,haddr),UVM_NONE);
         
         if(ahb_trans.hreadyin==1 && apb_trans.psel==1 && apb_trans.penable==1) begin
            `uvm_info("SCOREBOARD CHECK ---> DATA COMPARED","",UVM_NONE);
            if(ahb_trans.hwrite==1 && apb_trans.pwrite==1) begin
               if(paddr==haddr && pwdata==hwdata) begin
                  `uvm_info("SCOREBOARD PASS ---> APB & AHB ADDR AND DATA MATCHED","",UVM_NONE);
               end
               else begin
                  `uvm_info("SCOREBOARD FAIL ---> APB & AHB ADDR AND DATA MIS MATCHED","",UVM_NONE);
               end
            end
         end
         else begin
            #10;
         end
         
         if(ahb_trans.hreadyout==1 && apb_trans.psel==1 && apb_trans.penable==1) begin
            if(ahb_trans.hwrite==0 && apb_trans.pwrite==0) begin
               if(apb_trans.prdata==ahb_trans.hrdata) begin
                  `uvm_info("SCOREBOARD PASS ---> APB & AHB RDATA MATCHED","",UVM_NONE);
               end
               else begin
                  `uvm_info("SCOREBOARD FAIL ---> APB & AHB RDATA MIS MATCHED","",UVM_NONE);
               end
            end
         end
         else begin
            #10;
         end
     
   
      end
      
   endtask

   function void check_phase(uvm_phase phase);
      $display("-------------------------------------------------------------");
      `uvm_info("MY_COVERAGE",$sformatf("%0f",cg.get_coverage()),UVM_NONE);
      $display("-------------------------------------------------------------");
   endfunction



endclass


