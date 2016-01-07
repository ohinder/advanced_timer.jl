using advanced_timer
using Base.Test

# write your own tests here
begin
  reset_advanced_timer()
  start_advanced_timer();
  start_advanced_timer("test");
  pause_advanced_timer("test");
  start_advanced_timer("takes time");
  dot(rand(1000000),rand(1000000))
  pause_advanced_timer("takes time");
  pause_advanced_timer();
  print_timer_stats()
end
