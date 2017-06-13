module advanced_timer

export start_advanced_timer, pause_advanced_timer, print_timer_stats, get_elapsed_time, class_advanced_timer

type class_timing_info
    start::Float64
    total::Float64
    active::Bool
    num_calls::Int64

    function class_timing_info()
        return new(0.0,0.0,false,0)
    end
end

type class_advanced_timer
  grand_total::class_timing_info
	times::Dict{String,class_timing_info}

	function class_advanced_timer()
		this = new();
    this.grand_total = class_timing_info();
		this.times = Dict{String,class_timing_info}();
		return this;
	end
end


function elapsed_time(time_this::class_timing_info)
    return time_this.total + (time() - time_this.start)
end

function start(time_this::class_timing_info)
    time_this.start = time();
    time_this.active = true;
    time_this.num_calls += 1
end

function pause(time_this::class_timing_info)
    if time_this.active
      time_this.total = elapsed_time(time_this) #+= (time() - time_this.start)
      time_this.active = false;
    else
        error("cannot pause inactive timer")
    end
end

function start_advanced_timer(timer::class_advanced_timer)
    start(timer.grand_total)
end

function start_advanced_timer(timer::class_advanced_timer, str::String)
    timer::class_advanced_timer
    if (timer.grand_total.active)
        if ~(str in keys(timer.times))
          timer.times[str] = class_timing_info();
        end
        start(timer.times[str])
    else
        error("timer not active")
    end
end

function pause_advanced_timer(timer::class_advanced_timer,str::String)
  if (timer.grand_total.active)
    if ~(str in keys(timer.times))
        error(str * " is not included in timer dictionary")
    end
    pause(timer.times[str])
  else
      error("timer not active")
  end
end

function pause_advanced_timer(timer::class_advanced_timer)
    pause(timer.grand_total)
end


#function reset_advanced_timer(timer::class_advanced_timer)
#  timer::class_advanced_timer
#  timer.grand_total = class_timing_info()
#  timer.times = Dict{String,class_timing_info}();
#end


function round_num(num,k=1)
  return round(num*10^k)/10^k
end

function show_percent(val,total)
  return string(round_num(100*val/total)) * "%"
end

function print_timer_stats(timer::class_advanced_timer)
  heading = "========= Time statistics =========";
  println(heading)
    max_string_length = 0;
    for label in keys(timer.times)
        max_string_length = max(length(label),max_string_length)
    end

    padsize =  max_string_length + 3;

    # percentage time, number of calls
    println(rpad("Label",padsize), rpad("Time",8), "#calls")
    total = timer.grand_total.total
    for label in keys(timer.times)
        this_time = timer.times[label];
        @assert(!this_time.active)
        println( rpad(label, padsize), rpad(show_percent(this_time.total,total), 8), this_time.num_calls)
    end

    # total time
    println( "Total time (seconds):  ", round_num(total, 3) )

    println(repeat("=",length(heading)))
end



function get_elapsed_time(timer::class_advanced_timer)
    return elapsed_time(timer.grand_total)
end

function get_elapsed_time(timer::class_advanced_timer, str::String)
    return elapsed_time(timer.times[str])
end

function merge_timers(timer1::class_advanced_timer, timer2::class_advanced_timer)

end

########################
## GLOBAL TIMER FUNCTIONS
#########################

#=
GLOBAL_timer = class_advanced_timer();

function start_advanced_timer()
    start_advanced_timer(GLOBAL_timer)
end
function start_advanced_timer(str::String)
    start_advanced_timer(GLOBAL_timer, str)
end

function pause_advanced_timer()
    pause_advanced_timer(GLOBAL_timer)
end

function pause_advanced_timer(str::String)
    pause_advanced_timer(GLOBAL_timer, str)
end

function reset_advanced_timer()
    GLOBAL_timer = class_advanced_timer()
end

function print_timer_stats()
    print_timer_stats(GLOBAL_timer)
end

function get_advanced_timer()
    return GLOBAL_timer
end

function get_elapsed_time()
    return get_elapsed_time(GLOBAL_timer)
end

function get_elapsed_time(str::String)
    return get_elapsed_time(GLOBAL_timer,str)
end=#


end # module
