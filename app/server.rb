# server.rb
require 'logger'
require 'sinatra'
set :logger, Logger.new(STDOUT)
require 'sinatra/config_file'
config_file '../appmeta.yml'
config_file '../SHA_HEAD.yml'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require 'json'

# Endpoints
get '/' do
  logger.info('Example log - get / - HELLO WORLD')
  return 'Hello World'
end

get '/status' do
  logger.info('Example log - get status')
  content_type :json
  {
    myapplication: [
      version: settings.version,
      description: settings.description,
      lastcommitsha: settings.last_commit_sha
    ]
  }.to_json
end

# API endpoints
namespace '/api/v1' do
  before do
    content_type 'application/json'
  end
  # An example API endpoint
  get '/service1' do
    {
      data1: 'value1',
      data2: 'value2',
      data3: 'value3'
    }.to_json
  end
end
