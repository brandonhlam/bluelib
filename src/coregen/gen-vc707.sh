#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
rm -rf vc707

vivado -mode batch -source synth-fp-vc707.tcl -nolog -nojournal
vivado -mode batch -source synth-cordic-vc707.tcl -nolog -nojournal

