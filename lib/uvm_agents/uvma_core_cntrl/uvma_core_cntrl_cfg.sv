// 
// Copyright 2020 OpenHW Group
// Copyright 2020 Datum Technology Corporation
// Copyright 2020 Silicon Labs, Inc.
//
// Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

`ifndef __UVMA_CORE_CNTRL_CFG_SV__
`define __UVMA_CORE_CNTRL_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all
 * Clock & Reset agent (uvma_core_cntrl_agent_c) components.
 */

 virtual class uvma_core_cntrl_cfg_c extends uvm_object;

    // Major mode enable controls
   rand bit                      enabled;
   rand uvm_active_passive_enum  is_active;
   rand bit                      scoreboarding_enabled;
   bit                           disable_all_csr_checks;
   bit [CSR_MASK_WL-1:0]         disable_csr_check_mask;
   rand bit                      cov_model_enabled;
   rand bit                      trn_log_enabled;

   // ISS configuration
   bit                           use_iss;
   string                        iss_control_file = "ovpsim.ic";

   // RISC-V ISA Configuration
   rand corev_mxl_t              xlen;
   rand int unsigned             ilen;

   rand bit                      ext_i_supported;
   rand bit                      ext_a_supported;
   rand bit                      ext_m_supported;
   rand bit                      ext_c_supported;
   rand bit                      ext_b_supported;
   rand bit                      ext_p_supported;
   rand bit                      ext_v_supported;
   rand bit                      ext_f_supported;
   rand bit                      ext_d_supported;
   rand bit                      ext_zifencei_supported;
   rand bit                      ext_zicsr_supported;

   rand bit                      mode_s_supported;
   rand bit                      mode_u_supported;

   rand bit                      pmp_supported;   
   rand bit                      debug_supported;

   rand bit                      unaligned_access_supported;
   rand bit                      unaligned_access_amo_supported;

   // Mask of CSR addresses that are not supported in this core
   // post_randomize() will adjust this based on extension and mode support
   bit [CSR_MASK_WL-1:0]         unsupported_csr_mask;   

   // Common parameters
   int unsigned                  num_mhpmcounters;
   uvma_core_cntrl_pma_region_c  pma_regions[];

   // Common bootstrap addresses
   // The valid bits should be constrained if the bootstrap signal is not valid for this core configuration
   rand bit [MAX_XLEN-1:0]       hart_id;
   bit                           hart_id_plusarg_valid;

   rand bit [MAX_XLEN-1:0]       boot_addr;
   rand bit                      boot_addr_valid;
   bit                           boot_addr_plusarg_valid;

   rand bit [MAX_XLEN-1:0]       mtvec_addr;
   rand bit                      mtvec_addr_valid;
   bit                           mtvec_addr_plusarg_valid;

   rand bit [MAX_XLEN-1:0]       dm_halt_addr;
   rand bit                      dm_halt_addr_valid;
   bit                           dm_halt_addr_plusarg_valid;

   rand bit [MAX_XLEN-1:0]       dm_exception_addr;
   rand bit                      dm_exception_addr_valid;
   bit                           dm_exception_addr_plusarg_valid;
   
   rand bit [MAX_XLEN-1:0]       nmi_addr;
   rand bit                      nmi_addr_valid;
   bit                           nmi_addr_plusarg_valid;

   `uvm_field_utils_begin(uvma_core_cntrl_cfg_c);
      `uvm_field_int (                         enabled                        , UVM_DEFAULT          )
      `uvm_field_enum(uvm_active_passive_enum, is_active                      , UVM_DEFAULT          )
      `uvm_field_int (                         scoreboarding_enabled          , UVM_DEFAULT          )
      `uvm_field_int (                         disable_all_csr_checks         , UVM_DEFAULT          )
      `uvm_field_int (                         disable_csr_check_mask         , UVM_DEFAULT | UVM_NOPRINT )
      `uvm_field_int (                         cov_model_enabled              , UVM_DEFAULT          )
      `uvm_field_int (                         trn_log_enabled                , UVM_DEFAULT          )
      `uvm_field_enum(corev_mxl_t,             xlen                           , UVM_DEFAULT          )
      `uvm_field_int (                         ilen                           , UVM_DEFAULT | UVM_DEC)
      `uvm_field_int(                          ext_i_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_a_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_m_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_c_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_b_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_p_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_f_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_d_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_v_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          ext_zifencei_supported         , UVM_DEFAULT          )
      `uvm_field_int(                          ext_zicsr_supported            , UVM_DEFAULT          )
      `uvm_field_int(                          mode_s_supported               , UVM_DEFAULT          )
      `uvm_field_int(                          mode_u_supported               , UVM_DEFAULT          )
      `uvm_field_int(                          pmp_supported                  , UVM_DEFAULT          )
      `uvm_field_int(                          debug_supported                , UVM_DEFAULT          )
      `uvm_field_int(                          unaligned_access_supported     , UVM_DEFAULT          )
      `uvm_field_int(                          unaligned_access_amo_supported , UVM_DEFAULT          )

      `uvm_field_int(                          num_mhpmcounters               , UVM_DEFAULT          )
      `uvm_field_array_object(                 pma_regions                    , UVM_DEFAULT          )
      `uvm_field_int(                          hart_id                        , UVM_DEFAULT          )
      `uvm_field_int(                          boot_addr                      , UVM_DEFAULT          )
      `uvm_field_int(                          boot_addr_valid                , UVM_DEFAULT          )
      `uvm_field_int(                          boot_addr_plusarg_valid        , UVM_DEFAULT          )
      `uvm_field_int(                          mtvec_addr                     , UVM_DEFAULT          )
      `uvm_field_int(                          mtvec_addr_valid               , UVM_DEFAULT          )
      `uvm_field_int(                          mtvec_addr_plusarg_valid       , UVM_DEFAULT          )      
      `uvm_field_int(                          dm_halt_addr                   , UVM_DEFAULT          )
      `uvm_field_int(                          dm_halt_addr_valid             , UVM_DEFAULT          )
      `uvm_field_int(                          dm_halt_addr_plusarg_valid     , UVM_DEFAULT          )
      `uvm_field_int(                          dm_exception_addr              , UVM_DEFAULT          )
      `uvm_field_int(                          dm_exception_addr_valid        , UVM_DEFAULT          )
      `uvm_field_int(                          dm_exception_addr_plusarg_valid, UVM_DEFAULT          )
      `uvm_field_int(                          nmi_addr                       , UVM_DEFAULT          )
      `uvm_field_int(                          nmi_addr_valid                 , UVM_DEFAULT          )
      `uvm_field_int(                          nmi_addr_plusarg_valid         , UVM_DEFAULT          )
   `uvm_field_utils_end
      
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft cov_model_enabled      == 1;
      soft trn_log_enabled        == 1;
   }
   
   constraint scoreboard_cons {
      (!use_iss) -> (scoreboarding_enabled == 0);      
   }
   
   constraint addr_xlen_align_cons {
      if (xlen == MXL_32) {
         boot_addr[MAX_XLEN-1:32]         == '0;         
         mtvec_addr[MAX_XLEN-1:32]        == '0;
         dm_halt_addr[MAX_XLEN-1:32]      == '0;
         dm_exception_addr[MAX_XLEN-1:32] == '0;
         nmi_addr[MAX_XLEN-1:32]          == '0;      
      } else if (xlen == MXL_64) {
         boot_addr[MAX_XLEN-1:64]         == '0;         
         mtvec_addr[MAX_XLEN-1:64]        == '0;
         dm_halt_addr[MAX_XLEN-1:64]      == '0;
         dm_exception_addr[MAX_XLEN-1:64] == '0;
         nmi_addr[MAX_XLEN-1:64]          == '0;
      }
   }

   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_cv_base_cfg");

   /**
    * post randomization hooks
    * 1. Set unsupported_csr_mask based on extensions/modes supported
    */
   extern function void post_randomize();

   /**
    * Custom print additions
    */
   extern function void do_print(uvm_printer printer);

   /**    
    * Read a plusarg to fix a configuration value
    */
   extern function bit read_cfg_plusarg_xlen(string field, ref bit[MAX_XLEN-1:0] value);

   /**    
    * Set unsupported_csr_mask based on extensions/modes supported
    */
   extern virtual function void set_unsupported_csr_mask();

   /**
    * Sample parameters of the core DUT
    * Requires initialized context
    */
   pure virtual function void sample_parameters(uvma_core_cntrl_cntxt_c cntxt);

   /**
    * Disable a CSR check in the scoreboard by CSR name
    */
   extern virtual function void disable_csr_check(string name);

   /**
    * Read plusargs from YAML to configure CSR check plusargs
    */
   extern virtual function void read_disable_csr_check_plusargs();

   /**
    * Get list of supported CSRs
    */
   extern function void get_supported_csrs(ref string csrs[$]);   

   /**
    * Get Imperas ISS noinhibit_mask for configuring number of perf counters
    */
   extern virtual function bit[31:0] get_noinhibit_mask();

 endclass : uvma_core_cntrl_cfg_c

function uvma_core_cntrl_cfg_c::new(string name="uvme_cv_base_cfg");
   
   super.new(name);

   if ($test$plusargs("USE_ISS")) 
      use_iss = 1;

   // Read plusargs for defaults
   if (read_cfg_plusarg_xlen("hart_id", hart_id)) begin
      hart_id_plusarg_valid = 1;
      hart_id.rand_mode(0);
   end

   if (read_cfg_plusarg_xlen("boot_addr", boot_addr)) begin
      boot_addr_plusarg_valid = 1;
      boot_addr.rand_mode(0);
   end

   if (read_cfg_plusarg_xlen("mtvec_addr", mtvec_addr)) begin
      mtvec_addr_plusarg_valid = 1;
      mtvec_addr.rand_mode(0);
   end
   
   if (read_cfg_plusarg_xlen("dm_halt_addr", dm_halt_addr)) begin
      dm_halt_addr_plusarg_valid = 1;
      dm_halt_addr.rand_mode(0);
   end

   if (read_cfg_plusarg_xlen("dm_exception_addr", dm_exception_addr)) begin
      dm_exception_addr_plusarg_valid = 1;
      dm_exception_addr.rand_mode(0);
   end

   if (read_cfg_plusarg_xlen("nmi_addr", nmi_addr)) begin
      nmi_addr_plusarg_valid = 1;
      nmi_addr.rand_mode(0);
   end

endfunction : new

function bit uvma_core_cntrl_cfg_c::read_cfg_plusarg_xlen(string field, ref bit[MAX_XLEN-1:0] value);

   string str_val;

   if ($value$plusargs($sformatf("%s=0x%%s", field), str_val)) begin
      value = str_val.atohex();
      return 1;
   end
   if ($value$plusargs($sformatf("%s=%%s", field), str_val)) begin
      value = str_val.atoi();
      return 1;
   end

   return 0;

endfunction : read_cfg_plusarg_xlen

function void uvma_core_cntrl_cfg_c::post_randomize();

   set_unsupported_csr_mask();
   read_disable_csr_check_plusargs();

endfunction : post_randomize

function void uvma_core_cntrl_cfg_c::do_print(uvm_printer printer);

   super.do_print(printer);

   // Print out CSRs that are supported
   printer.print_string("-----------------------------", "--------------------------------------------------------------------");
   begin
      instr_csr_t csr;

      csr = csr.first();
      while (1) begin
         if (unsupported_csr_mask[csr]) 
            printer.print_string(csr.name(), "Unsupported");
         else if (disable_all_csr_checks || disable_csr_check_mask[csr])
            printer.print_string(csr.name(), "Supported but not checked in scoreboard");
         else
            printer.print_string(csr.name(), "Supported and checked in scoreboard");

         if (csr == csr.last()) break;
         csr = csr.next();
      end
   end
   printer.print_string("-----------------------------", "--------------------------------------------------------------------");

endfunction : do_print

function void uvma_core_cntrl_cfg_c::set_unsupported_csr_mask();

   // Initially set all CSRs as unsupported
   unsupported_csr_mask = '1;

   // Restore CSR locations with actual CSRs in the privileged spec or debug spec
   begin
      instr_csr_t csr;
      csr = csr.first();
      while (1) begin
         unsupported_csr_mask[csr] = 1'b0;

         if (csr == csr.last()) break;
         csr = csr.next();
      end
   end

   // Remove S-mode CSRs is S mode not supported
   if (!mode_s_supported) begin
      unsupported_csr_mask[SSTATUS] = 1;
      unsupported_csr_mask[SEDELEG] = 1;
      unsupported_csr_mask[SIDELEG] = 1;
      unsupported_csr_mask[SIE] = 1;
      unsupported_csr_mask[STVEC] = 1;
      unsupported_csr_mask[SCOUNTEREN] = 1;
      unsupported_csr_mask[SSCRATCH] = 1;
      unsupported_csr_mask[SEPC] = 1;
      unsupported_csr_mask[SCAUSE] = 1;
      unsupported_csr_mask[STVAL] = 1;
      unsupported_csr_mask[SIP] = 1;
      unsupported_csr_mask[SATP] = 1;

      unsupported_csr_mask[MEDELEG] = 1;
      unsupported_csr_mask[MIDELEG] = 1;
      unsupported_csr_mask[MCOUNTEREN] = 1;
   end

   // Remove U-mode CSRs is S mode not supported
   if (!mode_u_supported) begin
      unsupported_csr_mask[USTATUS] = 1;
      unsupported_csr_mask[UIE] = 1;
      unsupported_csr_mask[UTVEC] = 1;    
      unsupported_csr_mask[USCRATCH] = 1;
      unsupported_csr_mask[UEPC] = 1;
      unsupported_csr_mask[UCAUSE] = 1;
      unsupported_csr_mask[UTVAL] = 1;
      unsupported_csr_mask[UIP] = 1;  
      unsupported_csr_mask[CYCLE] = 1;
      unsupported_csr_mask[TIME] = 1;
      unsupported_csr_mask[INSTRET] = 1;
      unsupported_csr_mask[CYCLEH] = 1;
      unsupported_csr_mask[TIMEH] = 1;
      unsupported_csr_mask[INSTRETH] = 1;
      unsupported_csr_mask[SCOUNTEREN] = 1;
      
      for (int i = 0; i < MAX_NUM_HPMCOUNTERS; i++) begin
         unsupported_csr_mask[HPMCOUNTER3+i] = 1;
         unsupported_csr_mask[HPMCOUNTER3H+i] = 1;         
      end
   end

   // Remove debug mode CSRs if DEBUG not supported
   if (!debug_supported) begin
      unsupported_csr_mask[TSELECT] = 1;
      unsupported_csr_mask[TDATA1] = 1;
      unsupported_csr_mask[TDATA2] = 1;
      unsupported_csr_mask[TDATA3] = 1;
      unsupported_csr_mask[TINFO] = 1;
      unsupported_csr_mask[MCONTEXT] = 1;
      unsupported_csr_mask[SCONTEXT] = 1;
      unsupported_csr_mask[DCSR] = 1;
      unsupported_csr_mask[DPC] = 1;
      unsupported_csr_mask[DSCRATCH0] = 1;
      unsupported_csr_mask[DSCRATCH1] = 1;      
   end

   // Remove floating-point CSRs if no floating point supported
   if (!ext_f_supported && !ext_d_supported) begin
      unsupported_csr_mask[FFLAGS] = 1;
      unsupported_csr_mask[FRM] = 1;
      unsupported_csr_mask[FCSR] = 1;
   end

   // Remove pmp CSRs if PMP not supported
   if (!pmp_supported) begin
      unsupported_csr_mask[PMPCFG0] = 1;
      unsupported_csr_mask[PMPCFG1] = 1;
      unsupported_csr_mask[PMPCFG2] = 1;
      unsupported_csr_mask[PMPCFG3] = 1;
      unsupported_csr_mask[PMPADDR0] = 1;
      unsupported_csr_mask[PMPADDR1] = 1;
      unsupported_csr_mask[PMPADDR2] = 1;
      unsupported_csr_mask[PMPADDR3] = 1;
      unsupported_csr_mask[PMPADDR4] = 1;
      unsupported_csr_mask[PMPADDR5] = 1;
      unsupported_csr_mask[PMPADDR6] = 1;
      unsupported_csr_mask[PMPADDR7] = 1;
      unsupported_csr_mask[PMPADDR8] = 1;
      unsupported_csr_mask[PMPADDR9] = 1;
      unsupported_csr_mask[PMPADDR10] = 1;
      unsupported_csr_mask[PMPADDR11] = 1;
      unsupported_csr_mask[PMPADDR12] = 1;
      unsupported_csr_mask[PMPADDR13] = 1;
      unsupported_csr_mask[PMPADDR14] = 1;
      unsupported_csr_mask[PMPADDR15] = 1;
   end

   // Remove vector-mode CSRs
   if (!ext_v_supported) begin
      unsupported_csr_mask[VSTART] = 1;
      unsupported_csr_mask[VXSTAT] = 1;
      unsupported_csr_mask[VXRM] = 1;
      unsupported_csr_mask[VL] = 1;
      unsupported_csr_mask[VTYPE] = 1;
      unsupported_csr_mask[VLENB] = 1;
   end

   // Remove unsupported hpm counters
   for (int i = num_mhpmcounters; i < MAX_NUM_MHPMCOUNTERS; i++) begin
      unsupported_csr_mask[MHPMEVENT3+i] = 1;
      unsupported_csr_mask[MHPMCOUNTER3+i] = 1;
      unsupported_csr_mask[MHPMCOUNTER3H+i] = 1;
   end

endfunction : set_unsupported_csr_mask

function void uvma_core_cntrl_cfg_c::read_disable_csr_check_plusargs();

   // +disable_all_csr_checks is defined turn off all CSR checks
   if ($test$plusargs("DISABLE_ALL_CSR_CHECKS")) begin
      disable_all_csr_checks = 1;
   end

   // Parse individual CSR checks
   begin
      string disable_csr_plusarg;
      

      if ($value$plusargs("DISABLE_CSR_CHECK=%s", disable_csr_plusarg)) begin
         string csr;
         for (int i = 0; i < disable_csr_plusarg.len(); i++) begin            
            // Read a + -> disable the accumulated CSR
            if (disable_csr_plusarg.substr(i,i) == "+") begin
               disable_csr_check(csr);
               csr = "";
            end
            else begin
               csr = { csr, disable_csr_plusarg.substr(i,i) };
            end
         end

         if (csr != "")
            disable_csr_check(csr);
      end
   end

endfunction : read_disable_csr_check_plusargs

function void uvma_core_cntrl_cfg_c::get_supported_csrs(ref string csrs[$]);

   instr_csr_t csr;

   // Start from empty queue
   csrs.delete();

   csr = csr.first();
   while (1) begin
      if (!unsupported_csr_mask[csr])
         csrs.push_back(csr.name());

      if (csr == csr.last()) break;

      csr = csr.next();
   end

endfunction : get_supported_csrs

function bit[31:0] uvma_core_cntrl_cfg_c::get_noinhibit_mask();

   bit [31:0] mask = 32'hffff_fff8;
   
   for (int i = 0; i < this.num_mhpmcounters; i++) begin
      mask[i+3] = 1'b0;
   end

   return mask;

endfunction : get_noinhibit_mask

function void uvma_core_cntrl_cfg_c::disable_csr_check(string name);

   // Fatal error if passed a CSR check which is non-existent
   if (!csr_name2addr.exists(name)) begin
      `uvm_fatal("CV32E40XCFG", $sformatf("CSR [%s] does not exist", name));
   end

   disable_csr_check_mask[csr_name2addr[name]] = 1;   
   
endfunction : disable_csr_check

`endif // __UVMA_CORE_CNTRL_CFG_SV__


