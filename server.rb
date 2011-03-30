#!/usr/bin/env ruby

require 'rubygems'
require 'colored'
require 'pivotal-tracker'
require 'sinatra'
require 'yaml'

$yaml = File.open('config.yml').read()
$config = YAML::load( $yaml )
puts "#{$config}".yellow
puts "#{$config.keys}".green

get '/view/:name' do |name|
	@token = $config['token']
	@id = $config['project']
	@query = $config['queries'][name]
	
	PivotalTracker::Client.token = @token
	@project = PivotalTracker::Project.find(@id)
	@stories = @project.stories.all(@query)
	haml :list
end

get '/' do
	@queries = $config['queries']
	haml :index
end
