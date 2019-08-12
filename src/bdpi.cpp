#include <math.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>






float fixed_to_float(uint32_t fixed, int bits, int intbits) {
	fixed = (fixed&((1<<bits)-1));
	bool sign = (fixed>>(bits-1));

	float ret = 0;
	if ( sign ) {
		uint32_t fixedneg = ((~fixed)+1)&((1<<bits)-1);
		//uint32_t fixedneg = (~fixed)+1;
		ret = -((float)fixedneg)/(1<<(bits-intbits));
	}
	else {
		ret = ((float)fixed)/(1<<(bits-intbits));
	}

	return ret;
}

uint32_t float_to_fixed(float radian, int bits, int intbits) {
	uint32_t integer_portion = (uint32_t)radian;
	uint32_t frac_portion = (uint32_t)((radian - integer_portion) * (1<<(bits-intbits)));
	uint32_t fixed = (integer_portion<<(bits-intbits))|frac_portion;

	return fixed&((1<<bits)-1);
}

extern "C" uint32_t bdpi_fixed_to_float(uint32_t fixed, int bits, int intbits) {
    float x = fixed_to_float(fixed,bits,intbits);
	return *(uint32_t*)&x;
}

extern "C" uint32_t bdpi_float_to_fixed(uint32_t radian, int bits, int intbits) {
    float rad  = *(float*)&radian;
    return float_to_fixed(rad,bits,intbits);
}


extern "C" uint32_t bdpi_sqrt32(uint32_t data) {
	float r = sqrt(*(float*)&data);
	return *(uint32_t*)&r;
}
extern "C" uint64_t bdpi_sqrt64(uint64_t data) {
	double r = sqrt(*(double*)&data);
	return *(uint64_t*)&r;
}


extern "C" uint32_t bdpi_sincos(uint32_t data) {
	// input: phase in radians
	// only lower 16 bits are valid
	// fixed point, 3 bit integer part, 16-3=13 bit fraction
	// output: {sin,cos} 16 bits each, 2 bits integer fixed point
	float fdata = fixed_to_float(data, 16, 3);
	float fsin = sin(fdata);
	float fcos = cos(fdata);
	return (float_to_fixed(fsin, 16, 2)<<16) | float_to_fixed(fcos, 16, 2);
}

extern "C" uint32_t bdpi_atan(uint32_t x, uint32_t y) {
	// input: cartesian, only 16 bits are valid for both x and y
	// fixed point, 2 bit integer part
	// output: atan, 16 bits, 3 bits integer part
	float fx = fixed_to_float(x, 16, 2);
	float fy = fixed_to_float(y, 16, 2);
	float fatan = atan2(fy, fx);
	return float_to_fixed(fatan, 16, 3);
}

extern "C" uint32_t bdpi_invsqrt32(uint32_t data) {
	float r = 1/sqrt(*(float*)&data);
	return *(uint32_t*)&r;
}

extern "C" uint32_t bdpi_accum(uint32_t val, uint32_t last, uint32_t prev){
    int y = last;
    float x = *(float*)&val;
    float rv = *(float*)&prev;
    rv += x;
    return *(uint32_t*)&rv;
}
