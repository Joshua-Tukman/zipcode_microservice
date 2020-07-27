require 'sinatra'
require 'faraday'
require 'dotenv/load'
require 'pry'
require 'json'

get '/zipradius' do
  conn = Faraday.new("https://www.zipwise.com")
  response = conn.get("/webservices/radius.php?key=#{ENV['ZIPWISE_KEY']}&zip=#{params[:zip]}&radius=15&format=json")
  zipcodes = JSON.parse(response.body, symbolize_names: true)
  
  zipcodes[:results].map{|result| result[:zip]}
end
