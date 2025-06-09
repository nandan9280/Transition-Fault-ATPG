# Specify the SDC version
set sdc_version 2.0

# 1. Define primary clock
create_clock -name clk -period 3 [get_ports clk]

# 2. Define clock latencies (source latency = delay from source to clock network)
set_clock_latency -source -max 0.7 [get_clocks clk]
set_clock_latency -source -min 0.05 [get_clocks clk]

# 3. Add uncertainty (used in setup and hold margin analysis)
set_clock_uncertainty -setup 0.8 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]

# 4. Input delays for 'a' and 'b'
# Make sure these are declared as buses or collections
set_input_delay -max 0.5 -clock clk [get_ports {a[*]}]
set_input_delay -min 0.1 -clock clk [get_ports {a[*]}]
set_input_delay -max 0.5 -clock clk [get_ports {b[*]}]
set_input_delay -min 0.1 -clock clk [get_ports {b[*]}]

# 5. Output delays for y[31:0] or [all_outputs] if named properly
set_output_delay -max 0.9 -clock clk [all_outputs]
set_output_delay -min 0.1 -clock clk [all_outputs]

