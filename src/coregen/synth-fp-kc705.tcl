proc genFPCore {corename propertyList} {
	set coredir "./kc705"
	file mkdir $coredir
	if [file exists ./$coredir/$corename] {
		file delete -force ./$coredir/$corename
	}

	create_project -name local_synthesized_ip -in_memory -part xc7k325tffg900-2
	set_property board_part xilinx.com:kc705:part0:1.5 [current_project]
	create_ip -name floating_point -version 7.1 -vendor xilinx.com -library ip -module_name $corename -dir ./$coredir
	set_property -dict $propertyList [get_ips $corename]

	generate_target {instantiation_template} [get_files ./$coredir/$corename/$corename.xci]
	generate_target all [get_files  ./$coredir/$corename/$corename.xci]
	create_ip_run [get_files -of_objects [get_fileset sources_1] ./$coredir/$corename/$corename.xci]
	generate_target {Synthesis} [get_files  ./$coredir/$corename/$corename.xci]
	read_ip ./$coredir/$corename/$corename.xci
	synth_ip [get_ips $corename]
}

genFPCore "fp_mult32" [list CONFIG.Operation_Type {Multiply} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.Flow_Control {Blocking} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.Has_RESULT_TREADY {true} CONFIG.C_Latency {7} CONFIG.C_Rate {1}]
genFPCore "fp_div32" [list CONFIG.Operation_Type {Divide} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.Flow_Control {Blocking} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {No_Usage} CONFIG.Has_RESULT_TREADY {true} CONFIG.C_Latency {29} CONFIG.C_Rate {1}]
genFPCore "fp_add32" [list CONFIG.Operation_Type {Add_Subtract} CONFIG.Add_Sub_Value {Add} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {12} CONFIG.C_Rate {1}]
genFPCore "fp_sub32" [list CONFIG.Operation_Type {Add_Subtract} CONFIG.Add_Sub_Value {Subtract} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {12} CONFIG.C_Rate {1}]
genFPCore "fp_sqrt32" [list CONFIG.Operation_Type {Square_root} CONFIG.A_Precision_Type {Single} CONFIG.Axi_Optimize_Goal {Resources} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {29} CONFIG.C_Rate {1}]
genFPCore "fp_invsqrt32" [list CONFIG.Operation_Type {Rec_Square_Root} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {33} CONFIG.C_Rate {1}]
genFPCore "fp_accum32" [list CONFIG.Operation_Type {Accumulator} CONFIG.Add_Sub_Value {Add} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Optimization {Speed_Optimized} CONFIG.C_Mult_Usage {Medium_Usage} CONFIG.Maximum_Latency {true} CONFIG.C_Latency {23} CONFIG.C_Rate {1} CONFIG.Has_ARESETn {false} CONFIG.Has_A_TLAST {true} CONFIG.RESULT_TLAST_Behv {Pass_A_TLAST}]
genFPCore "fp32_to_fx16" [list CONFIG.Operation_Type {Float_to_fixed} CONFIG.Result_Precision_Type {Custom} CONFIG.C_Result_Exponent_Width {2} CONFIG.C_Result_Fraction_Width {14} CONFIG.Maximum_Latency {true} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {7} CONFIG.C_Rate {1}]
genFPCore "fx16_to_fp32" [list CONFIG.Operation_Type {Fixed_to_float} CONFIG.A_Precision_Type {Custom} CONFIG.C_A_Exponent_Width {2} CONFIG.C_A_Fraction_Width {14} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-1} CONFIG.C_Accum_Input_Msb {1} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {7} CONFIG.C_Rate {1}]


genFPCore "fp_mult64" [list CONFIG.Operation_Type {Multiply} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.Flow_Control {Blocking} CONFIG.A_Precision_Type {Double} CONFIG.C_A_Exponent_Width {11} CONFIG.C_A_Fraction_Width {53} CONFIG.Result_Precision_Type {Double} CONFIG.C_Result_Exponent_Width {11} CONFIG.C_Result_Fraction_Width {53} CONFIG.Has_RESULT_TREADY {true} CONFIG.C_Latency {16} CONFIG.C_Rate {1}]
genFPCore "fp_div64" [list CONFIG.Operation_Type {Divide} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.Flow_Control {Blocking} CONFIG.A_Precision_Type {Double} CONFIG.C_A_Exponent_Width {11} CONFIG.C_A_Fraction_Width {53} CONFIG.Result_Precision_Type {Double} CONFIG.C_Result_Exponent_Width {11} CONFIG.C_Result_Fraction_Width {53} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.Has_RESULT_TREADY {true} CONFIG.C_Latency {58} CONFIG.C_Rate {1}]
genFPCore "fp_add64" [list CONFIG.Operation_Type {Add_Subtract} CONFIG.Add_Sub_Value {Add} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.A_Precision_Type {Double} CONFIG.C_A_Exponent_Width {11} CONFIG.C_A_Fraction_Width {53} CONFIG.Result_Precision_Type {Double} CONFIG.C_Result_Exponent_Width {11} CONFIG.C_Result_Fraction_Width {53} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {15} CONFIG.C_Rate {1}]
genFPCore "fp_sub64" [list CONFIG.Operation_Type {Add_Subtract} CONFIG.Add_Sub_Value {Subtract} CONFIG.C_Mult_Usage {Max_Usage} CONFIG.A_Precision_Type {Double} CONFIG.C_A_Exponent_Width {11} CONFIG.C_A_Fraction_Width {53} CONFIG.Result_Precision_Type {Double} CONFIG.C_Result_Exponent_Width {11} CONFIG.C_Result_Fraction_Width {53} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {15} CONFIG.C_Rate {1}]
genFPCore "fp_sqrt64" [list CONFIG.Operation_Type {Square_root} CONFIG.A_Precision_Type {Double} CONFIG.C_A_Exponent_Width {11} CONFIG.C_A_Fraction_Width {53} CONFIG.Result_Precision_Type {Double} CONFIG.C_Result_Exponent_Width {11} CONFIG.C_Result_Fraction_Width {53} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {58} CONFIG.C_Rate {1}]
