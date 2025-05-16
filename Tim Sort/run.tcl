read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib
read_hdl timsort8.v
elaborate
set_top_module timsort8
read_sdc timsort8.sdc
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium
syn_generic
syn_map
syn_opt
report_area > ./tim-2/area.rep
report_power > ./tim-2/power.rep
report_timing > ./tim-2/timing_unconstrained.rep



