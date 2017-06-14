using advanced_timer
using Base.Test

# write your own tests here
begin
  timer = class_advanced_timer()
  start_advanced_timer(timer);
  start_advanced_timer(timer,"test");
  pause_advanced_timer(timer,"test");
  start_advanced_timer(timer,"takes time");
  dot(rand(1000000),rand(1000000))
  pause_advanced_timer(timer,"takes time");
  start_advanced_timer(timer,"abc");
  dot(randn(100),randn(100))
  pause_advanced_timer(timer,"abc");
  pause_advanced_timer(timer);
  print_timer_stats(timer)

  timer2 = class_advanced_timer()
  start_advanced_timer(timer2);
  start_advanced_timer(timer2,"test");
  pause_advanced_timer(timer2,"test");
  start_advanced_timer(timer2,"takes time");
  dot(rand(1000000),rand(1000000))
  pause_advanced_timer(timer2,"takes time");
  pause_advanced_timer(timer2);
  print_timer_stats(timer2)

  merged_timers = merge_timers(timer,timer2)
  print_timer_stats(merged_timers)
end
