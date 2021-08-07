class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @zip_code = params['zip_code'] || 80226

    puts @zip_code

    @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_code}&distance=0&API_KEY=D9063C5B-5536-4936-B684-DF396C3E2295"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    if @output.empty? 
      @final_output = 'Error'
      @reporting_area = @zip_code
    elsif !@output 
      @final_output = 'Error'
      @reporting_area = @zip_code
    else
      @final_output = @output[0]['AQI']
      @reporting_area = @output[0]['ReportingArea']
    end   

  
    if @final_output == 'Error'
      @api_color = 'bg-gray-300'
      @description = "An Error has occured, that may be due to the airNow API not having data for #{@zip_code}"
    elsif @final_output <= 50 
      @api_color = 'bg-green-300'
      @description = 'Good: Air quality is satisfactory, and air pollution poses little or no risk.'
    elsif @final_output >= 51 && @final_output <= 100 
      @api_color = 'bg-yellow-300'
      @description = 'Moderate: Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.'
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = 'bg-orange-300'
      @description = 'Unhealthy for Sensitive Groups: Members of sensitive groups may experience health effects. The general public is less likely to be affected.'
    elsif @final_output >= 151 && @final_output <= 200 
      @api_color = 'bg-red-300'
      @description = 'Unhealthy: Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.'
    elsif @final_output >= 201 && @final_output <= 300 
      @api_color = 'bg-purple-300'
      @description = 'Very Unhealthy: Health alert: The risk of health effects is increased for everyone.'
    elsif @final_output >= 301 && @final_output <= 500 
      @api_color = 'bg-rose-300'
      @description = 'Hazardous: Health warning of emergency conditions: everyone is more likely to be affected.'
    else  
      @api_color = 'bg-gray-300'
      @description = 'Error'
    end
    
  end
end
