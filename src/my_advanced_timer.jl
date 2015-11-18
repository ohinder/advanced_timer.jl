module my_advanced_timer

export start_advanced_timer, pause_advanced_timer, reset_advanced_timer, print_timer_stats

type class_advanced_timer

	start_times::Dict{String,Float64}
	total_times::Dict{String,Float64}

	function class_advanced_timer()
		this = new();
		this.start_times = Dict{String,Float64}()
		this.total_times = Dict{String,Float64}()

		return this;
	end
end

function round_num(num,k=1)
  return round(num*10^k)/10^k
end

function show_percent(val,total)
  return round_num(100*val/total)
end

GLOBAL_timer = class_advanced_timer();

function start_advanced_timer()
    start_advanced_timer("Total")
end

function start_advanced_timer(str::String)
  GLOBAL_timer::class_advanced_timer
  GLOBAL_timer.start_times[str] = time();
end

function pause_advanced_timer(str::String)
  GLOBAL_timer::class_advanced_timer
  if ~(str in keys(GLOBAL_timer.total_times))
    GLOBAL_timer.total_times[str] = 0.0;
  end
  time_passage = (time() - GLOBAL_timer.start_times[str]);
  GLOBAL_timer.total_times[str] = GLOBAL_timer.total_times[str] + time_passage;
end

function pause_advanced_timer()
    pause_advanced_timer("Total")
end

function reset_advanced_timer()
  GLOBAL_timer::class_advanced_timer
  GLOBAL_timer.total_times = Dict{String,Float64}()
end

function print_timer_stats(standardize_by)
  GLOBAL_timer::class_advanced_timer
  println("======= Time statistics =======")
  if standardize_by != ""
    total = GLOBAL_timer.total_times[standardize_by]
    println( standardize_by, " = ", round_num(total, 3) )
    for label in keys(GLOBAL_timer.total_times)
      if label != standardize_by
        println( label, " = ", show_percent(GLOBAL_timer.total_times[label],total), " %" )
      end
    end
  else
    for label in keys(GLOBAL_timer.total_times)
      println( label, " = ", round_num(GLOBAL_timer.total_times[label], 3) )
    end
  end
end

function print_timer_stats()
    print_timer_stats("Total")
end


end # module
