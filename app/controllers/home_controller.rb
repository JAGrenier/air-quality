class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=80226&distance=0&API_KEY=D9063C5B-5536-4936-B684-DF396C3E2295'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    if @output.empty? 
      @final_output = 'Error'
    elsif !@output 
      @final_output = 'Error'
    else
      @final_output = @output[0]['AQI']
    end

    if @final_output <= 50 
      @api_color = 'bg-green-300'
    elsif @final_output >= 51 && @final_output <= 100 
      @api_color = 'bg-yellow-300'
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = 'bg-orange-300'
    elsif @final_output >= 151 && @final_output <= 200 
      @api_color = 'bg-red-300'
    elsif @final_output >= 201 && @final_output <= 300 
      @api_color = 'bg-purple-300'
    elsif @final_output >= 301 && @final_output <= 500 
      @api_color = 'bg-rose-300'
    else  
      @api_color = 'bg-gray-300'
    end
    
  end
end
