$Sim_Time = 60.0 #Simulation time
$Loop = 1000.000 #Number of repeat

$caseofstore

class HomeController < ApplicationController
  def index
	
  end 
  
  def reg
  	require 'nokogiri'
	require 'open-uri'

	doc = Nokogiri::HTML(open("http://www.kma.go.kr/weather/observation/currentweather.jsp"))
	@temp= doc.css('.table_develop3/tbody/tr/td')[5].inner_text.to_f #기온 입력받음
	
	
  	time_input = Time.new
  	@when = (time_input.hour.to_i+9)%24 #시간 입력받음
  	
  	@when = 15
  	if @when > 22 or @when < 4
		@test = false
	else
		@test = true
  	end
  	
  	@case = params[:region] #매장 입력받음
  	@rain_temp = params[:weather_sel] #날씨 입력받음
  	 if @rain_temp == '2'
  	 	@rain = 1
  	 else
  	 	@rain = 0
  	 end 
  	  # index의 form tag로부터 case를 입력받음.
  	
  	case @case
	when '강남구청' #강남구청
		@people = 400
  		@sell = 0*@when + 0*@temp + 0*@rain + 0*@people + -0.321130*13 + -0.030100*222 + 40
	when '경희대' #경희대
		@people = 400
  		@sell = -1.456411*@when + 0.272137*@temp + -10.280128*@rain + 0.009125*@people + -0.321130*10 + -0.030100*582 + 35.225627
	when '고려대' #고려대
		@people = -0.05994*@when + -0.12447*@temp + -0.88200*@rain + 95.49629
  		@sell = -1.02767*@when + 0.58743*@temp + -18.01713*@rain + -0.04399*@people + -0.321130*22 + -0.030100*115 + 38.26728
	when '성균관대' #성균관대
		@people = 400
		@sell = 0*@when + 0*@temp + 0*@rain + 0*@people + -0.321130*34 + -0.030100*368 + 40
	when '성신여대' #성신여대
		@people = -2.57075*@when + 0.09513*@temp + 2.64670*@rain + 122.88162
		@sell = -0.99247*@when + 0.59120*@temp + -16.45908*@rain + 0.01776*@people + -0.321130*55 + -0.030100*255 + 31.12694
	when '숭실대' #숭실대
		@people = -4.9817*@when + -0.8677*@temp + 4.1975*@rain + 289.2915
		@sell = -1.90592*@when + 1.05869*@temp + -42.25273*@rain + -0.11498*@people + -0.321130*13 + -0.030100*171 + 88.94809
	when '시립대' #시립대
		@people = 400
		@sell = -0.09641*@when + 1.15864*@temp + -15.08857*@rain + 0.03304*@people + -0.321130*10 + -0.030100*684 + 18.42574
	when '신촌점' #신촌점
		@people = 400
		@sell = 0*@when + 0*@temp + 0*@rain + 0*@people + -0.321130*46 + -0.030100*174 + 40
	when '이화여대' #이화여대
		@people = 400
		@sell = -0.396582*@when + 0.051492*@temp + -16.909194*@rain + 0.003536*@people + -0.321130*79 + -0.030100*201 + 36.448036
	else
		@sell = NULL
	end
  	
  	@lamda = $Sim_Time / @sell
  	$caseofstore = @case
  	
  	redirect_to "/home/resultview?lamda=#{@lamda}" # 모르겠어  
  
  end
  
  def resultview
  	
  	time_input = Time.new
  	@when = (time_input.hour.to_i+9)%24
  	@when2 = time_input.min
  	
  	@caseofstore = $caseofstore
    @throughput=0.0
  	@mean_num=0.0
  	@mean_time=0.0
	
	for i in 0..$Loop #Simulate 1,000,000 times
		@end_time = $Sim_Time #Total time to simulate
		@Ta = params[:lamda].to_f #Mean time between arrivals #이거 회귀식으로 받아와야댐
		@Ts = 4.0 #Mean service time
		@m = 3 #no of servers
		@time = 0.0 #Simulation time
		@t1 = 0.0 #Time for next event #1 (arrival)
		@t2 = $Sim_Time #Time for next event #2 (departure)
		@n = 0 #Number of customers in the system
		@k = 10 #buffer space
		@c = 0.0 #Number of service completions
		@s = 0.0 #Area of number of customers in system
		@tn = @time #Variable for "last event time"
		@x = 0.0 #Throughput
		@l = 0.0 #Mean number in the system
		@w = 0.0 #Mean residence time
			
		# Main simulation loop
		while @time < @end_time do
			if @t1 < @t2 #Event #1 (arrival)
				@time = @t1
				@s = @s + @n * (@time - @tn) #Update area under "s" curve
							
				if @n < @k
			 		@n = @n + 1
					@tn = @time #tn = "last event time" for next event
					@t1 = @time + expntl1(@Ta);
				end
							
				if @n == 1
					@t2 = @time + expntl2(@Ts);
				end
				  
			else
				@time = @t2
				@s = @s + @n * (@time - @tn) #Update area under "s" curve
							
				if @n > @m
					@n -= @m
				else
					@n = 0
					@tn = @time #tn = "last event time" for next event
					@c = @c + 1 #Increment number of completions
				end
							
				if @n > 0
					@t2 = @time + expntl2(@Ts);
				else
					@t2 = @end_time
				end
					
			end #if else
		end #while
	    
		@x = @c / @time #Compute throughput rate
		@l = @s / @time #Compute mean number in system
		@w = @l / @x #Compute mean residence or system time

		if @l > 0
			@throughput += @c
			@mean_num += @l
			@mean_time += @w		
		end #if

	end #for
	
  	@throughput /= $Loop #시간당 판매량
  	@mean_num /= $Loop #대기 인원 평균
  	@mean_time /= $Loop #대기 시간 평균
  	
  	# logger.debug("================================")
  	# logger.debug("throughput : #{@throughput}")
  	# logger.debug("mean_num : #{@mean_num}")
  	# logger.debug("mean_time : #{@mean_time}")
  	
  end #index


  def expntl1(x) #Generate exponential RV with mean x
    #Uniform random number from 0 to 1
  	#Pull a uniform RV (0 < z < 1)
  	begin
  	  @z=rand()
    end while (@z == 0) || (@z == 1)
  
  	return -x * Math.log(@z)
    
  end #expntl1

  
  def expntl2(x) #Generate exponential RV with mean x
    #Uniform random number from 0 to 1
  	#Pull a uniform RV (0 < z < 1)
  	begin
  		@z=rand(0.499..0.505)
    end while (@z == 0) || (@z == 1)
  
  	return -x * Math.log(@z)
    
  end #expntl2

end #class