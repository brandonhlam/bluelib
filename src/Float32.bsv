package Float32;

import Vector::*;
import FIFO::*;
import FloatingPoint::*;


import "BDPI" function Bit#(32) bdpi_sqrt32(Bit#(32) data);
import "BDPI" function Bit#(32) bdpi_invsqrt32(Bit#(32) data);
import "BDPI" fixed_to_float function Bit#(32) bdpi_fx2fp(Bit#(32) data, Bit#(32) bits, Bit#(32) intbits);
import "BDPI" float_to_fixed = function Bit#(32) bdpi_fp2fx(Bit#(32) data, Bit#(32) bits, Bit#(32) intbits);
import "BDPI" function ActionValue#(Bit#(32)) bdpi_accum(Bit#(32) val,Bit#(32) last,Bit#(32) prev);

typedef 7 MultLatency32;
typedef 7 ConvertLatency;
typedef 12 AddLatency32;
typedef 12 SubLatency32;
typedef 29 DivLatency32;
typedef 29 SqrtLatency32;
typedef 23 AccumLatency32;
typedef 33 InvSqrtLatency32;

interface FpFilterImportIfc#(numeric type width);
	method Action enq(Bit#(width) a);
	method ActionValue#(Bit#(width)) get;
endinterface

interface FpPairImportIfc#(numeric type width);
	method Action enqa(Bit#(width) a);
	method Action enqb(Bit#(width) b);
	method ActionValue#(Bit#(width)) get;
endinterface

interface FpConvertImportIfc#(numeric type inWidth, numeric type outWidth);
	method Action enq(Bit#(inWidth) a);
	method Action deq;
	method Bit#(outWidth) first;
endinterface

interface FpAccumImportIfc#(numeric type width);
	method Action enq(Bit#(width) a);
    method Action isLast(Bit#(1) last);
	method ActionValue#(Bit#(width)) get;
endinterface



interface FpConvertIfc#(numeric type inWidth, numeric type outWidth);
	method Action enq(Bit#(inWidth) a);
	method Action deq;
	method Bit#(outWidth) first;
endinterface

interface FpAccumIfc#(numeric type width);
	method Action enq(Bit#(width) a,Bit#(1) last);
	method Action deq;
	method Bit#(width) first;
endinterface

interface FpFilterIfc#(numeric type width);
	method Action enq(Bit#(width) a);
	method Action deq;
	method Bit#(width) first;
endinterface
interface FpPairIfc#(numeric type width);
	method Action enq(Bit#(width) a, Bit#(width) b);
	method Action deq;
	method Bit#(width) first;
endinterface

import "BVI" fp_sub32 =
module mkFpSubImport32#(Clock aclk, Reset arst) (FpPairImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);

	method enqa(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
	method enqb(s_axis_b_tdata) enable(s_axis_b_tvalid) ready(s_axis_b_tready) clocked_by(aclk);

	schedule (
		get, enqa, enqb
	) CF (
		get, enqa, enqb
	);
endmodule
import "BVI" fp_add32 =
module mkFpAddImport32#(Clock aclk, Reset arst) (FpPairImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);

	method enqa(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
	method enqb(s_axis_b_tdata) enable(s_axis_b_tvalid) ready(s_axis_b_tready) clocked_by(aclk);

	schedule (
		get, enqa, enqb
	) CF (
		get, enqa, enqb
	);
endmodule
import "BVI" fp_mult32 =
module mkFpMultImport32#(Clock aclk, Reset arst) (FpPairImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);

	method enqa(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
	method enqb(s_axis_b_tdata) enable(s_axis_b_tvalid) ready(s_axis_b_tready) clocked_by(aclk);

	schedule (
		get, enqa, enqb
	) CF (
		get, enqa, enqb
	);
endmodule
import "BVI" fp_div32 =
module mkFpDivImport32#(Clock aclk, Reset arst) (FpPairImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);

	method enqa(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
	method enqb(s_axis_b_tdata) enable(s_axis_b_tvalid) ready(s_axis_b_tready) clocked_by(aclk);

	schedule (
		get, enqa, enqb
	) CF (
		get, enqa, enqb
	);
endmodule
import "BVI" fp_sqrt32 =
module mkFpSqrtImport32#(Clock aclk, Reset arst) (FpFilterImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);
	method enq(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
  
	schedule (
		get, enq
	) CF (
		get, enq
	);
endmodule

import "BVI" fp_invSqrt32 =
module mkFpInvSqrtImport32#(Clock aclk, Reset arst) (FpFilterImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);
	method enq(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
  
	schedule (
		get, enq
	) CF (
		get, enq
	);
endmodule

import "BVI" fp_accum32 =
module mkFpAccumImport32#(Clock aclk, Reset arst) (FpAccumImportIfc#(32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);
	method enq(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
	method isLast(s_axis_a_tlast) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
  
	schedule (
		get, enq, isLast
	) CF (
		get, enq, isLast
	);
endmodule

import "BVI" fp32_to_fx16 =
module mkFp32ToFx16Import32#(Clock aclk, Reset arst) (FpConvertImportIfc#(32,16));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);
	method enq(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
  
	schedule (
		get, enq
	) CF (
		get, enq
	);
endmodule

import "BVI" fx16_to_fp32 =
module mkFx16ToFp32Import32#(Clock aclk, Reset arst) (FpConvertImportIfc#(16,32));
	default_clock no_clock;
	default_reset no_reset;

	input_clock (aclk) = aclk;
	method m_axis_result_tdata get enable(m_axis_result_tready) ready(m_axis_result_tvalid) clocked_by(aclk);
	method enq(s_axis_a_tdata) enable(s_axis_a_tvalid) ready(s_axis_a_tready) clocked_by(aclk);
  
	schedule (
		get, enq
	) CF (
		get, enq
	);
endmodule

module mkFpSub32 (FpPairIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(SubLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(SubLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(SubLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpPairImportIfc#(32) fp_sub <- mkFpSubImport32(curClk, curRst);
	rule getOut;
		let v <- fp_sub.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a, Bit#(32) b);
`ifdef BSIM
	Bool asign = a[31] == 1;
	Bool bsign = b[31] == 1;
	Bit#(8) ae = truncate(a>>23);
	Bit#(8) be = truncate(b>>23);
	Bit#(23) as = truncate(a);
	Bit#(23) bs = truncate(b);
	Float fa = Float{sign: asign, exp: ae, sfd: as};
	Float fb = Float{sign: bsign, exp: be, sfd: bs};
	Float fm = fa - fb;
	//outQ.enq( {fm.sign?1:0,fm.exp,fm.sfd} );
	latencyQs[0].enq( {fm.sign?1:0,fm.exp,fm.sfd} );
`else
		fp_sub.enqa(a);
		fp_sub.enqb(b);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule


module mkFpAdd32 (FpPairIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(AddLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(AddLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(AddLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpPairImportIfc#(32) fp_add <- mkFpAddImport32(curClk, curRst);
	rule getOut;
		let v <- fp_add.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a, Bit#(32) b);
`ifdef BSIM
	Bool asign = a[31] == 1;
	Bool bsign = b[31] == 1;
	Bit#(8) ae = truncate(a>>23);
	Bit#(8) be = truncate(b>>23);
	Bit#(23) as = truncate(a);
	Bit#(23) bs = truncate(b);
	Float fa = Float{sign: asign, exp: ae, sfd: as};
	Float fb = Float{sign: bsign, exp: be, sfd: bs};
	Float fm = fa + fb;

	//outQ.enq( {fm.sign?1:0,fm.exp,fm.sfd} );
	latencyQs[0].enq( {fm.sign?1:0,fm.exp,fm.sfd} );
`else
		fp_add.enqa(a);
		fp_add.enqb(b);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFpMult32 (FpPairIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(MultLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(MultLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(MultLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpPairImportIfc#(32) fp_mult <- mkFpMultImport32(curClk, curRst);
	rule getOut;
		let v <- fp_mult.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a, Bit#(32) b);
`ifdef BSIM
	Bool asign = a[31] == 1;
	Bool bsign = b[31] == 1;
	Bit#(8) ae = truncate(a>>23);
	Bit#(8) be = truncate(b>>23);
	Bit#(23) as = truncate(a);
	Bit#(23) bs = truncate(b);
	Float fa = Float{sign: asign, exp: ae, sfd: as};
	Float fb = Float{sign: bsign, exp: be, sfd: bs};
	Float fm = fa * fb;
	//outQ.enq( {fm.sign?1:0,fm.exp,fm.sfd} );
	latencyQs[0].enq( {fm.sign?1:0,fm.exp,fm.sfd} );
`else
		fp_mult.enqa(a);
		fp_mult.enqb(b);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFpDiv32 (FpPairIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(DivLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(DivLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(DivLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpPairImportIfc#(32) fp_div <- mkFpDivImport32(curClk, curRst);
	rule getOut;
		let v <- fp_div.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a, Bit#(32) b);
`ifdef BSIM
	Bool asign = a[31] == 1;
	Bool bsign = b[31] == 1;
	Bit#(8) ae = truncate(a>>23);
	Bit#(8) be = truncate(b>>23);
	Bit#(23) as = truncate(a);
	Bit#(23) bs = truncate(b);
	Float fa = Float{sign: asign, exp: ae, sfd: as};
	Float fb = Float{sign: bsign, exp: be, sfd: bs};
	Float fm = fa / fb;
	//outQ.enq( {fm.sign?1:0,fm.exp,fm.sfd} );
	latencyQs[0].enq( {fm.sign?1:0,fm.exp,fm.sfd} );
`else
		fp_div.enqa(a);
		fp_div.enqb(b);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFpSqrt32 (FpFilterIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(SqrtLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(SqrtLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(SqrtLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpFilterImportIfc#(32) fp_sqrt <- mkFpSqrtImport32(curClk, curRst);
	rule getOut;
		let v <- fp_sqrt.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a);
`ifdef BSIM
	latencyQs[0].enq( bdpi_sqrt32(a) );
`else
		fp_sqrt.enq(a);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFpInvSqrt32 (FpFilterIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(InvSqrtLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(InvSqrtLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(InvSqrtLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpFilterImportIfc#(32) fp_invsqrt <- mkFpInvSqrtImport32(curClk, curRst);
	rule getOut;
		let v <- fp_invsqrt.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a);
`ifdef BSIM
	latencyQs[0].enq( bdpi_invsqrt32(a) );
`else
		fp_invsqrt.enq(a);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFpAccum32 (FpAccumIfc#(32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
    Reg#(Bit#(32)) rv <- mkReg(0);
	Vector#(AccumLatency32, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(AccumLatency32)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(AccumLatency32)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpAccumImportIfc#(32) fp_accum <- mkFpAccumImport32(curClk, curRst);
	rule getOut;
		let v <- fp_accum.get;
		outQ.enq(v);
	endrule
`endif

method Action enq(Bit#(32) a,Bit#(1) last);
`ifdef BSIM
    let b = rv;
	Bool asign = a[31] == 1;
	Bool bsign = b[31] == 1;
	Bit#(8) ae = truncate(a>>23);
	Bit#(8) be = truncate(b>>23);
	Bit#(23) as = truncate(a);
	Bit#(23) bs = truncate(b);
	Float fa = Float{sign: asign, exp: ae, sfd: as};
	Float fb = Float{sign: bsign, exp: be, sfd: bs};
	Float fm = fa + fb;
    Bit#(32) temp = {fm.sign?1:0,fm.exp,fm.sfd};
    if(last == 1'b1) begin
	    latencyQs[0].enq(temp);
        rv <= 0;
    end else begin
        rv <= temp;
    end
`else
		fp_accum.enq(a);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(32) first;
		return outQ.first;
	endmethod
endmodule

module mkFp32ToFx16 (FpConvertIfc#(32,16));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(16)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(ConvertLatency, FIFO#(Bit#(16))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(ConvertLatency)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(ConvertLatency)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpConvertImportIfc#(32,16) fp2fx <- mkFp32ToFx16Import32(curClk, curRst);
	rule getOut;
		let v <- fp2fx.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a);
`ifdef BSIM
	latencyQs[0].enq( truncate(bdpi_fp2fx(a)) );
`else
		fp2fx.enq(a);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(16) first;
		return outQ.first;
	endmethod
endmodule

module mkFx16ToFp32 (FpConvertIfc#(16,32));
	Clock curClk <- exposeCurrentClock;
	Reset curRst <- exposeCurrentReset;

	FIFO#(Bit#(32)) outQ <- mkFIFO;
`ifdef BSIM
	Vector#(ConvertLatency, FIFO#(Bit#(32))) latencyQs <- replicateM(mkFIFO);
	for (Integer i = 0; i < valueOf(ConvertLatency)-1; i=i+1 ) begin
		rule relay;
			latencyQs[i].deq;
			latencyQs[i+1].enq(latencyQs[i].first);
		endrule
	end
	rule relayOut;
		Integer lastIdx = valueOf(ConvertLatency)-1;
		latencyQs[lastIdx].deq;
		outQ.enq(latencyQs[lastIdx].first);
	endrule
`else
	FpConvertImportIfc#(16,32) fx2fp <- mkFx16ToFp32Import32(curClk, curRst);
	rule getOut;
		let v <- fx2fp.get;
		outQ.enq(v);
	endrule
`endif

	method Action enq(Bit#(32) a);
`ifdef BSIM
	latencyQs[0].enq( bdpi_fx2fp(zeroExtend(a)) );
`else
		fp2fx.enq(a);
`endif
	endmethod
	method Action deq;
		outQ.deq;
	endmethod
	method Bit#(16) first;
		return outQ.first;
	endmethod
endmodule

endpackage: Float32
