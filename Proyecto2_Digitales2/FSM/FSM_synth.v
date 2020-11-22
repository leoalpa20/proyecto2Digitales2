/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "FSM_synth.v:1" *)
module FSM_synth(clk, init, reset, MF_empty_umbral_in, VC_empty_umbral_in, D_empty_umbral_in, MF_full_umbral_in, VC_full_umbral_in, D_full_umbral_in, MF_err_sig_in, VC0_err_sig_in, VC1_err_sig_in, D0_err_sig_in, D1_err_sig_in, MF_empty_sig_in, VC0_empty_sig_in, VC1_empty_sig_in, D0_empty_sig_in, D1_empty_sig_in, MF_full_umbral_out_e, VC_full_umbral_out_e, D_full_umbral_out_e, MF_empty_umbral_out_e, VC_empty_umbral_out_e, D_empty_umbral_out_e, error_out_e, active_out_e, idle_out_e, reset_out);
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _000_;
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _001_;
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _002_;
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _003_;
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _004_;
  (* src = "FSM_synth.v:64" *)
  wire [2:0] _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  (* src = "FSM_synth.v:34" *)
  input D0_empty_sig_in;
  (* src = "FSM_synth.v:27" *)
  input D0_err_sig_in;
  (* src = "FSM_synth.v:35" *)
  input D1_empty_sig_in;
  (* src = "FSM_synth.v:28" *)
  input D1_err_sig_in;
  (* src = "FSM_synth.v:16" *)
  input [2:0] D_empty_umbral_in;
  (* src = "FSM_synth.v:45" *)
  output [2:0] D_empty_umbral_out_e;
  (* src = "FSM_synth.v:21" *)
  input [2:0] D_full_umbral_in;
  (* src = "FSM_synth.v:41" *)
  output [2:0] D_full_umbral_out_e;
  (* src = "FSM_synth.v:31" *)
  input MF_empty_sig_in;
  (* src = "FSM_synth.v:14" *)
  input [2:0] MF_empty_umbral_in;
  (* src = "FSM_synth.v:43" *)
  output [2:0] MF_empty_umbral_out_e;
  (* src = "FSM_synth.v:24" *)
  input MF_err_sig_in;
  (* src = "FSM_synth.v:19" *)
  input [2:0] MF_full_umbral_in;
  (* src = "FSM_synth.v:39" *)
  output [2:0] MF_full_umbral_out_e;
  (* src = "FSM_synth.v:32" *)
  input VC0_empty_sig_in;
  (* src = "FSM_synth.v:25" *)
  input VC0_err_sig_in;
  (* src = "FSM_synth.v:33" *)
  input VC1_empty_sig_in;
  (* src = "FSM_synth.v:26" *)
  input VC1_err_sig_in;
  (* src = "FSM_synth.v:15" *)
  input [2:0] VC_empty_umbral_in;
  (* src = "FSM_synth.v:44" *)
  output [2:0] VC_empty_umbral_out_e;
  (* src = "FSM_synth.v:20" *)
  input [2:0] VC_full_umbral_in;
  (* src = "FSM_synth.v:40" *)
  output [2:0] VC_full_umbral_out_e;
  (* src = "FSM_synth.v:49" *)
  output active_out_e;
  (* src = "FSM_synth.v:8" *)
  input clk;
  (* src = "FSM_synth.v:48" *)
  output error_out_e;
  (* src = "FSM_synth.v:50" *)
  output idle_out_e;
  (* src = "FSM_synth.v:9" *)
  input init;
  (* src = "FSM_synth.v:10" *)
  input reset;
  (* src = "FSM_synth.v:51" *)
  output reset_out;
  (* onehot = 32'd1 *)
  wire [4:0] state;
  NOT _091_ (
    .A(MF_err_sig_in),
    .Y(_071_)
  );
  NOT _092_ (
    .A(VC0_err_sig_in),
    .Y(_072_)
  );
  NAND _093_ (
    .A(_072_),
    .B(_071_),
    .Y(_073_)
  );
  NOT _094_ (
    .A(D1_err_sig_in),
    .Y(_074_)
  );
  NOR _095_ (
    .A(D0_err_sig_in),
    .B(VC1_err_sig_in),
    .Y(_075_)
  );
  NAND _096_ (
    .A(_075_),
    .B(_074_),
    .Y(_076_)
  );
  NOR _097_ (
    .A(_076_),
    .B(_073_),
    .Y(_077_)
  );
  NAND _098_ (
    .A(reset),
    .B(state[2]),
    .Y(_078_)
  );
  NOR _099_ (
    .A(_078_),
    .B(init),
    .Y(_079_)
  );
  NAND _100_ (
    .A(_079_),
    .B(_077_),
    .Y(_080_)
  );
  NOR _101_ (
    .A(_077_),
    .B(state[3]),
    .Y(_081_)
  );
  NOR _102_ (
    .A(state[1]),
    .B(state[3]),
    .Y(_082_)
  );
  NOR _103_ (
    .A(_082_),
    .B(_081_),
    .Y(_083_)
  );
  NOT _104_ (
    .A(init),
    .Y(_084_)
  );
  NAND _105_ (
    .A(reset),
    .B(_084_),
    .Y(_085_)
  );
  NAND _106_ (
    .A(VC0_empty_sig_in),
    .B(MF_empty_sig_in),
    .Y(_086_)
  );
  NOT _107_ (
    .A(VC1_empty_sig_in),
    .Y(_087_)
  );
  NOT _108_ (
    .A(D0_empty_sig_in),
    .Y(_088_)
  );
  NOR _109_ (
    .A(_088_),
    .B(_087_),
    .Y(_089_)
  );
  NAND _110_ (
    .A(_089_),
    .B(D1_empty_sig_in),
    .Y(_090_)
  );
  NOR _111_ (
    .A(_090_),
    .B(_086_),
    .Y(_006_)
  );
  NOR _112_ (
    .A(_006_),
    .B(_085_),
    .Y(_007_)
  );
  NAND _113_ (
    .A(_007_),
    .B(_083_),
    .Y(_008_)
  );
  NAND _114_ (
    .A(_008_),
    .B(_080_),
    .Y(_023_)
  );
  NOT _115_ (
    .A(reset),
    .Y(_029_)
  );
  NOT _116_ (
    .A(state[3]),
    .Y(_009_)
  );
  NOR _117_ (
    .A(D1_err_sig_in),
    .B(VC1_err_sig_in),
    .Y(_010_)
  );
  NOR _118_ (
    .A(_073_),
    .B(D0_err_sig_in),
    .Y(_011_)
  );
  NAND _119_ (
    .A(_011_),
    .B(_010_),
    .Y(_012_)
  );
  NAND _120_ (
    .A(_012_),
    .B(_009_),
    .Y(_013_)
  );
  NOT _121_ (
    .A(state[4]),
    .Y(_014_)
  );
  NOT _122_ (
    .A(state[2]),
    .Y(_015_)
  );
  NAND _123_ (
    .A(_015_),
    .B(_014_),
    .Y(_016_)
  );
  NOR _124_ (
    .A(_016_),
    .B(_013_),
    .Y(_017_)
  );
  NOR _125_ (
    .A(_017_),
    .B(_084_),
    .Y(_018_)
  );
  NOR _126_ (
    .A(_018_),
    .B(state[0]),
    .Y(_019_)
  );
  NOR _127_ (
    .A(_019_),
    .B(_029_),
    .Y(_069_)
  );
  NOT _128_ (
    .A(_082_),
    .Y(_020_)
  );
  NAND _129_ (
    .A(_020_),
    .B(_013_),
    .Y(_021_)
  );
  NOT _130_ (
    .A(_006_),
    .Y(_022_)
  );
  NOR _131_ (
    .A(_022_),
    .B(_021_),
    .Y(_024_)
  );
  NOR _132_ (
    .A(_024_),
    .B(state[4]),
    .Y(_025_)
  );
  NOR _133_ (
    .A(_025_),
    .B(_085_),
    .Y(_070_)
  );
  NOR _134_ (
    .A(_029_),
    .B(_009_),
    .Y(idle_out_e)
  );
  NOR _135_ (
    .A(_020_),
    .B(_078_),
    .Y(active_out_e)
  );
  NOT _136_ (
    .A(state[1]),
    .Y(_026_)
  );
  NOR _137_ (
    .A(_029_),
    .B(_026_),
    .Y(_027_)
  );
  NOT _138_ (
    .A(_027_),
    .Y(_028_)
  );
  NOR _139_ (
    .A(_028_),
    .B(state[3]),
    .Y(error_out_e)
  );
  NOR _140_ (
    .A(_029_),
    .B(state[4]),
    .Y(_030_)
  );
  NAND _141_ (
    .A(_030_),
    .B(D_empty_umbral_out_e[0]),
    .Y(_031_)
  );
  NAND _142_ (
    .A(D_empty_umbral_in[0]),
    .B(state[4]),
    .Y(_032_)
  );
  NAND _143_ (
    .A(_032_),
    .B(_031_),
    .Y(_000_[0])
  );
  NAND _144_ (
    .A(_030_),
    .B(D_empty_umbral_out_e[1]),
    .Y(_034_)
  );
  NAND _145_ (
    .A(D_empty_umbral_in[1]),
    .B(state[4]),
    .Y(_035_)
  );
  NAND _146_ (
    .A(_035_),
    .B(_034_),
    .Y(_000_[1])
  );
  NAND _147_ (
    .A(_030_),
    .B(D_empty_umbral_out_e[2]),
    .Y(_036_)
  );
  NAND _148_ (
    .A(D_empty_umbral_in[2]),
    .B(state[4]),
    .Y(_037_)
  );
  NAND _149_ (
    .A(_037_),
    .B(_036_),
    .Y(_000_[2])
  );
  NAND _150_ (
    .A(_030_),
    .B(VC_empty_umbral_out_e[0]),
    .Y(_038_)
  );
  NAND _151_ (
    .A(VC_empty_umbral_in[0]),
    .B(state[4]),
    .Y(_039_)
  );
  NAND _152_ (
    .A(_039_),
    .B(_038_),
    .Y(_004_[0])
  );
  NAND _153_ (
    .A(_030_),
    .B(VC_empty_umbral_out_e[1]),
    .Y(_040_)
  );
  NAND _154_ (
    .A(VC_empty_umbral_in[1]),
    .B(state[4]),
    .Y(_041_)
  );
  NAND _155_ (
    .A(_041_),
    .B(_040_),
    .Y(_004_[1])
  );
  NAND _156_ (
    .A(_030_),
    .B(VC_empty_umbral_out_e[2]),
    .Y(_042_)
  );
  NAND _157_ (
    .A(VC_empty_umbral_in[2]),
    .B(state[4]),
    .Y(_043_)
  );
  NAND _158_ (
    .A(_043_),
    .B(_042_),
    .Y(_004_[2])
  );
  NAND _159_ (
    .A(_030_),
    .B(MF_empty_umbral_out_e[0]),
    .Y(_044_)
  );
  NAND _160_ (
    .A(MF_empty_umbral_in[0]),
    .B(state[4]),
    .Y(_045_)
  );
  NAND _161_ (
    .A(_045_),
    .B(_044_),
    .Y(_002_[0])
  );
  NAND _162_ (
    .A(_030_),
    .B(MF_empty_umbral_out_e[1]),
    .Y(_046_)
  );
  NAND _163_ (
    .A(MF_empty_umbral_in[1]),
    .B(state[4]),
    .Y(_047_)
  );
  NAND _164_ (
    .A(_047_),
    .B(_046_),
    .Y(_002_[1])
  );
  NAND _165_ (
    .A(_030_),
    .B(MF_empty_umbral_out_e[2]),
    .Y(_048_)
  );
  NAND _166_ (
    .A(MF_empty_umbral_in[2]),
    .B(state[4]),
    .Y(_049_)
  );
  NAND _167_ (
    .A(_049_),
    .B(_048_),
    .Y(_002_[2])
  );
  NAND _168_ (
    .A(_030_),
    .B(D_full_umbral_out_e[0]),
    .Y(_050_)
  );
  NAND _169_ (
    .A(D_full_umbral_in[0]),
    .B(state[4]),
    .Y(_051_)
  );
  NAND _170_ (
    .A(_051_),
    .B(_050_),
    .Y(_001_[0])
  );
  NAND _171_ (
    .A(_030_),
    .B(D_full_umbral_out_e[1]),
    .Y(_052_)
  );
  NAND _172_ (
    .A(D_full_umbral_in[1]),
    .B(state[4]),
    .Y(_053_)
  );
  NAND _173_ (
    .A(_053_),
    .B(_052_),
    .Y(_001_[1])
  );
  NAND _174_ (
    .A(_030_),
    .B(D_full_umbral_out_e[2]),
    .Y(_054_)
  );
  NAND _175_ (
    .A(D_full_umbral_in[2]),
    .B(state[4]),
    .Y(_055_)
  );
  NAND _176_ (
    .A(_055_),
    .B(_054_),
    .Y(_001_[2])
  );
  NAND _177_ (
    .A(_030_),
    .B(VC_full_umbral_out_e[0]),
    .Y(_056_)
  );
  NAND _178_ (
    .A(VC_full_umbral_in[0]),
    .B(state[4]),
    .Y(_057_)
  );
  NAND _179_ (
    .A(_057_),
    .B(_056_),
    .Y(_005_[0])
  );
  NAND _180_ (
    .A(_030_),
    .B(VC_full_umbral_out_e[1]),
    .Y(_058_)
  );
  NAND _181_ (
    .A(VC_full_umbral_in[1]),
    .B(state[4]),
    .Y(_059_)
  );
  NAND _182_ (
    .A(_059_),
    .B(_058_),
    .Y(_005_[1])
  );
  NAND _183_ (
    .A(_030_),
    .B(VC_full_umbral_out_e[2]),
    .Y(_060_)
  );
  NAND _184_ (
    .A(VC_full_umbral_in[2]),
    .B(state[4]),
    .Y(_061_)
  );
  NAND _185_ (
    .A(_061_),
    .B(_060_),
    .Y(_005_[2])
  );
  NAND _186_ (
    .A(_030_),
    .B(MF_full_umbral_out_e[0]),
    .Y(_062_)
  );
  NAND _187_ (
    .A(MF_full_umbral_in[0]),
    .B(state[4]),
    .Y(_063_)
  );
  NAND _188_ (
    .A(_063_),
    .B(_062_),
    .Y(_003_[0])
  );
  NAND _189_ (
    .A(_030_),
    .B(MF_full_umbral_out_e[1]),
    .Y(_064_)
  );
  NAND _190_ (
    .A(MF_full_umbral_in[1]),
    .B(state[4]),
    .Y(_065_)
  );
  NAND _191_ (
    .A(_065_),
    .B(_064_),
    .Y(_003_[1])
  );
  NAND _192_ (
    .A(_030_),
    .B(MF_full_umbral_out_e[2]),
    .Y(_066_)
  );
  NAND _193_ (
    .A(MF_full_umbral_in[2]),
    .B(state[4]),
    .Y(_067_)
  );
  NAND _194_ (
    .A(_067_),
    .B(_066_),
    .Y(_003_[2])
  );
  NOR _195_ (
    .A(_027_),
    .B(_079_),
    .Y(_068_)
  );
  NOR _196_ (
    .A(_068_),
    .B(_077_),
    .Y(_033_)
  );
  DFF _197_ (
    .C(clk),
    .D(_029_),
    .Q(state[0])
  );
  DFF _198_ (
    .C(clk),
    .D(_033_),
    .Q(state[1])
  );
  DFF _199_ (
    .C(clk),
    .D(_023_),
    .Q(state[2])
  );
  DFF _200_ (
    .C(clk),
    .D(_070_),
    .Q(state[3])
  );
  DFF _201_ (
    .C(clk),
    .D(_069_),
    .Q(state[4])
  );
  DFF _202_ (
    .C(clk),
    .D(_003_[0]),
    .Q(MF_full_umbral_out_e[0])
  );
  DFF _203_ (
    .C(clk),
    .D(_003_[1]),
    .Q(MF_full_umbral_out_e[1])
  );
  DFF _204_ (
    .C(clk),
    .D(_003_[2]),
    .Q(MF_full_umbral_out_e[2])
  );
  DFF _205_ (
    .C(clk),
    .D(_005_[0]),
    .Q(VC_full_umbral_out_e[0])
  );
  DFF _206_ (
    .C(clk),
    .D(_005_[1]),
    .Q(VC_full_umbral_out_e[1])
  );
  DFF _207_ (
    .C(clk),
    .D(_005_[2]),
    .Q(VC_full_umbral_out_e[2])
  );
  DFF _208_ (
    .C(clk),
    .D(_001_[0]),
    .Q(D_full_umbral_out_e[0])
  );
  DFF _209_ (
    .C(clk),
    .D(_001_[1]),
    .Q(D_full_umbral_out_e[1])
  );
  DFF _210_ (
    .C(clk),
    .D(_001_[2]),
    .Q(D_full_umbral_out_e[2])
  );
  DFF _211_ (
    .C(clk),
    .D(_002_[0]),
    .Q(MF_empty_umbral_out_e[0])
  );
  DFF _212_ (
    .C(clk),
    .D(_002_[1]),
    .Q(MF_empty_umbral_out_e[1])
  );
  DFF _213_ (
    .C(clk),
    .D(_002_[2]),
    .Q(MF_empty_umbral_out_e[2])
  );
  DFF _214_ (
    .C(clk),
    .D(_004_[0]),
    .Q(VC_empty_umbral_out_e[0])
  );
  DFF _215_ (
    .C(clk),
    .D(_004_[1]),
    .Q(VC_empty_umbral_out_e[1])
  );
  DFF _216_ (
    .C(clk),
    .D(_004_[2]),
    .Q(VC_empty_umbral_out_e[2])
  );
  DFF _217_ (
    .C(clk),
    .D(_000_[0]),
    .Q(D_empty_umbral_out_e[0])
  );
  DFF _218_ (
    .C(clk),
    .D(_000_[1]),
    .Q(D_empty_umbral_out_e[1])
  );
  DFF _219_ (
    .C(clk),
    .D(_000_[2]),
    .Q(D_empty_umbral_out_e[2])
  );
  assign reset_out = reset;
endmodule
