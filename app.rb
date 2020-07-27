require 'sinatra'
require 'faraday'
require 'dotenv/load'
require 'pry'

get '/zipradius' do
  conn = Faraday.new("https://www.zipwise.com")
  response = conn.get("/webservices/radius.php?key=#{ENV['ZIPWISE_KEY']}&zip=#{params[:zip]}&radius=#{params[:radius]}&format=json")
  zipcodes = JSON.parse(response.body, symbolize_names: true)
  zipcodes[:results].map{|result| result[:zip]}
end
