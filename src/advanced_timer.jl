module advanced_timer

export start_advanced_timer, pause_advanced_timer, reset_advanced_timer, print_timer_stats

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

function start(time_this::class_timing_info)
    time_this.start = time();
    time_this.active = true;
    time_this.num_calls += 1
end

function pause(time_this::class_timing_info)
    if time_this.active
      time_this.total += (time() - time_this.start)
      time_this.active = false;
    else
        error("cannot pause inactive timer")
    end
end

GLOBAL_timer = class_advanced_timer();

function start_advanced_timer()
    start(GLOBAL_timer.grand_total)
end

function start_advanced_timer(str::String)
    GLOBAL_timer::class_advanced_timer
    if (GLOBAL_timer.grand_total.active)
        if ~(str in keys(GLOBAL_timer.times))
          GLOBAL_timer.times[str] = class_timing_info();
        end
        start(GLOBAL_timer.times[str])
    else
        error("timer not active")
    end
end

function pause_advanced_timer(str::String)
  GLOBAL_timer::class_advanced_timer
  if (GLOBAL_timer.grand_total.active)
    if ~(str in keys(GLOBAL_timer.times))
        error(str * " is not included in timer dictionary")
    end
    pause(GLOBAL_timer.times[str])
  else
      error("timer not active")
  end
end

function pause_advanced_timer()
    pause(GLOBAL_timer.grand_total)
end

function reset_advanced_timer()
  GLOBAL_timer::class_advanced_timer
  GLOBAL_timer.grand_total = class_timing_info()
  GLOBAL_timer.times = Dict{String,class_timing_info}();
end


function round_num(num,k=1)
  return round(num*10^k)/10^k
end

function show_percent(val,total)
  return string(round_num(100*val/total)) * "%"
end

function print_timer_stats()
  GLOBAL_timer::class_advanced_timer
  heading = "========= Time statistics =========";
  println(heading)
    max_string_length = 0;
    for label in keys(GLOBAL_timer.times)
        max_string_length = max(length(label),max_string_length)
    end

    padsize =  max_string_length + 3;

    # percentage time, number of calls
    println(rpad("Label",padsize), rpad("Time",8), "#calls")
    total = GLOBAL_timer.grand_total.total
    for label in keys(GLOBAL_timer.times)
        this_time = GLOBAL_timer.times[label];
        @assert(!this_time.active)
        println( rpad(label, padsize), rpad(show_percent(this_time.total,total), 8), this_time.num_calls)
    end

    # total time
    println( "Total time (seconds):  ", round_num(total, 3) )

    println(repeat("=",length(heading)))
end



end # module
