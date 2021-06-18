class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=80226&distance=0&API_KEY=D9063C5B-5536-4936-B684-DF396C3E2295'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    if @output.empty? 
      @final_output = "Error"
    elsif !@output 
      @final_output = "Error"
    else
      @final_output = @output[0]['AQI']
    end
    
  end
end
