$Sim_Time = 60.0 #Simulation time
$Loop = 100.000 #Number of repeat

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
 
  	@case = params[:region] #매장 입력받음
  	@rain_temp = params[:weather_sel] #날씨 입력받음
  	 if @rain_temp == '2'
  	 	@rain = 1
  	 else
  	 	@rain = 0
  	 end 
  	  # index의 form tag로부터 case를 입력받음.
  	
  	if @case == '강남구청'
		if @when >= 8 or @when < 11
  			@u1 = 153
  			@u2 = 198
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 228
  			@u2 = 370
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 116
  			@u2 = 178
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(2.4123 + 0.0025*@people - 0.0026*@temp)
		else
			@sell = Math.exp(2.4123 + 0.0025*@people - 0.0026*@temp - 0.0614)
		end
	
	elsif @case == '경희대'
		if @when >= 8 or @when < 11
  			@u1 = 226
  			@u2 = 285
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 518
  			@u2 = 549
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 413
  			@u2 = 471
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(2.7528 + 0.0005*@people + 0.0082*@temp)
		else
			@sell = Math.exp(2.7528 + 0.0005*@people + 0.0082*@temp + 0.0191)
		end
	
	elsif @case == '고려대'
		if @when >= 8 or @when < 11
  			@u1 = 325
  			@u2 = 496
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 657
  			@u2 = 1257
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 281
  			@u2 = 557
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(2.1231 + 0.0014*@people + 0.0074*@temp)
		else
			@sell = Math.exp(2.1231 + 0.0014*@people + 0.0074*@temp + 0.0187)
		end
	
	elsif @case == '성균관대'
		if @when >= 8 or @when < 11
  			@u1 = 196
  			@u2 = 231
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 503
  			@u2 = 575
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 380
  			@u2 = 471
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(1.4484 + 0.0044*@people + 0.0137*@temp)
		else
			@sell = Math.exp(1.4484 + 0.0044*@people + 0.0137*@temp - 0.0300)
		end
	  	
	elsif @case == '성신여대'
		if @when >= 8 or @when < 11
  			@u1 = 65
  			@u2 = 75
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 91
  			@u2 = 113
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 49
  			@u2 = 75
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(0.8733 + 0.0266*@people + 0.0092*@temp)
		else
			@sell = Math.exp(0.8733 + 0.0266*@people + 0.0092*@temp + 0.0003)
		end
		
	elsif @case == '숭실대'
		if @when >= 8 or @when < 11
  			@u1 = 128
  			@u2 = 168
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 175
  			@u2 = 195
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 97
  			@u2 = 118
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(2.0869 + 0.0038*@people + 0.0090*@temp)
		else
			@sell = Math.exp(2.0869 + 0.0038*@people + 0.0090*@temp - 0.0038)
		end
	
	elsif @case == '시립대'
		if @when >= 8 or @when < 11
  			@u1 = 53
  			@u2 = 75
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 100
  			@u2 = 137
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 86
  			@u2 = 104
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(2.775 + 0.0086*@people + 0.0047*@temp)
		else
			@sell = Math.exp(2.775 + 0.0086*@people + 0.0047*@temp - 0.0067)
		end
		
	elsif @case == '신촌점'
		if @when >= 8 or @when < 11
  			@u1 = 673
  			@u2 = 783
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 1505
  			@u2 = 1544
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 944
  			@u2 = 1113
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(3.9303 + 0.0007*@people + 0.0012*@temp)
		else
			@sell = Math.exp(3.9303 + 0.0007*@people + 0.0012*@temp - 0.0401)
		end
	  	
	elsif @case == '이화여대'
		if @when >= 8 or @when < 11
  			@u1 = 386
  			@u2 = 527
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 11 or @when < 17
	  		@u1 = 1438
  			@u2 = 1595
  			@people = uniform(@u1, @u2)
	  	elsif @when >= 17 or @when < 22
	  		@u1 = 952
  			@u2 = 1092
  			@people = uniform(@u1, @u2)
		else
			@people = 0
	  	end
	  	
	  	if @rain == 1
	  		@sell = Math.exp(3.1698 + 0.0004*@people - 0.0035*@temp)
		else
			@sell = Math.exp(3.1698 + 0.0004*@people - 0.0035*@temp - 0.0308*@rain)
		end
	
	else
		@sell = 0.1
	end
  	
  	if @sell <= 0
		@sell = 0.1
	end
  	
  	@lamda = $Sim_Time / @sell

  	redirect_to "/home/resultview?lamda=#{@lamda}"
  
  end
  
  def resultview
  	
  	time_input = Time.new
  	@when = (time_input.hour.to_i+9)%24
  	if @when > 22 or @when < 8
		@test = false
	else
		@test = true
  	end
  	
  	
  	@when2 = time_input.min
  	
    @throughput=0.0
  	@mean_num=0.0
  	@mean_time=0.0
	
	for i in 0..$Loop #Simulate 100 times
		@end_time = $Sim_Time #Total time to simulate
		@Ta = params[:lamda].to_f #Mean time between arrivals #이거 회귀식으로 받아와야댐
		if @Ta > 10
			@Ts = 4.0 #Mean service time
		else @Ts = (7/50)*@Ta + 2.6
		end
		@m = 4 #no of servers
		@time = 0.0 #Simulation time
		@t1 = 0.0 #Time for next event #1 (arrival)
		@t2 = $Sim_Time #Time for next event #2 (departure)
		@n = 0 #Number of customers in the system
		@k = 20 #buffer space
		@c = 0.0 #Number of service completions
		@s = 0.0 #Area of number of customers in system
		@tn = @time #Variable for "last event time"
		@x = 0.0 #Throughput
		@l = 0.0 #Mean number in the system
		@w = 0.0 #Mean residence time
			
		# Main simulation loop
		while @time < @end_time
			if @t1 < @t2 #Event #1 (arrival)
				@time = @t1
				@s = @n * (@time - @tn) + @s #Update area under "s" curve
							
				if @n < @k
			 		@n = @n + 1
			 	end
				
				@tn = @time #tn = "last event time" for next event
				@t1 = @time + expntl1(@Ta)
							
				if @n == 1
					@t2 = @time + expntl2(@Ts)
				end
				  
			else
				@time = @t2
				@s = @n * (@time - @tn) + @s #Update area under "s" curve
							
				if @n > @m
					@n = @n - @m
				else
					@n = 0
				end	
				
				@tn = @time #tn = "last event time" for next event
				@c = @c + 1 #Increment number of completions
							
				if @n > 0
					@t2 = @time + expntl2(@Ts)
				else
					@t2 = @end_time
				end
					
			end #if else
		end #while
	    
		@x = @c / @time #Compute throughput rate
		@l = @s / @time #Compute mean number in system
		@w = @l / @x #Compute mean residence or system time

		if @l > 0
			@throughput = @throughput + @c
			@mean_num = @mean_num + @l
			@mean_time = @mean_time + @w		
		end #if

	end #for
	
  	@throughput /= $Loop #시간당 판매량
  	@mean_num /= $Loop #대기 인원 평균
  	@mean_time /= $Loop #대기 시간 평균
  	
  	logger.debug("================================")
  	logger.debug("lamda : #{@Ta}")
  	logger.debug("throughput : #{@throughput}")
  	logger.debug("mean_num : #{@mean_num}")
  	logger.debug("mean_time : #{@mean_time}")
  	
  end #index

  def uniform(u1, u2)
    #Uniform random number from u1 to u2
  	#Pull a uniform RV (u1 < s < u2)
  	begin
  	  @u=rand(u1..u2)
    end while (@u == u1) || (@u == u2)

  	return @u
    
  end #uniform
  
  def expntl1(x) #Generate exponential RV with mean x
    #Uniform random number from 0 to 1
  	#Pull a uniform RV (0 < v < 1)
  	begin
  	  @v=rand()
    end while (@v == 0) || (@v == 1)
	
  	return -x * Math.log(@v)
    
  end #expntl1

  
  def expntl2(y) #Generate exponential RV with mean y
    #Uniform random number from 0.33 to 0.4
  	#Pull a uniform RV (0 < z < 1)
  	begin
  		@z=rand(0.34..0.40)
    end while (@z == 0) || (@z == 1)
  
  	return -y * Math.log(@z)
    
  end #expntl2

end #class