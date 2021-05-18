#using advanced_timer
using Main.advanced_timer
using Test
using LinearAlgebra

# write your own tests here
begin
  timer =  Main.advanced_timer.class_advanced_timer()
  Main.advanced_timer.start_advanced_timer(timer);
  Main.advanced_timer.start_advanced_timer(timer,"test");
  Main.advanced_timer.pause_advanced_timer(timer,"test");
  Main.advanced_timer.start_advanced_timer(timer,"takes time");
  LinearAlgebra.dot(rand(1000000),rand(1000000))
  Main.advanced_timer.pause_advanced_timer(timer,"takes time");
  Main.advanced_timer.start_advanced_timer(timer,"abc");
  LinearAlgebra.dot(randn(100),randn(100))
  Main.advanced_timer.pause_advanced_timer(timer,"abc");
  Main.advanced_timer.pause_advanced_timer(timer);
  Main.advanced_timer.print_timer_stats(timer)

  timer2 = Main.advanced_timer.class_advanced_timer()
  Main.advanced_timer.start_advanced_timer(timer2);
  Main.advanced_timer.start_advanced_timer(timer2,"test");
  Main.advanced_timer.pause_advanced_timer(timer2,"test");
  Main.advanced_timer.start_advanced_timer(timer2,"takes time");
  LinearAlgebra.dot(rand(1000000),rand(1000000))
  Main.advanced_timer.pause_advanced_timer(timer2,"takes time");
  Main.advanced_timer.pause_advanced_timer(timer2);
  Main.advanced_timer.print_timer_stats(timer2)

  merged_timers = Main.advanced_timer.merge_timers(timer,timer2)
  Main.advanced_timer.print_timer_stats(merged_timers)
end
