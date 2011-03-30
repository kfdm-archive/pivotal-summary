#!/usr/bin/env ruby

require 'rubygems'
require 'colored'
require 'pivotal-tracker'
require 'sinatra'
require 'yaml'

$yaml = File.open('config.yml').read()
$config = YAML::load( $yaml )

get '/view/:name' do |name|
	@token = $config['token']
	@id = $config['project']
	@queries = $config['queries']
	@query = @queries[name]
	
	PivotalTracker::Client.token = @token
	@project = PivotalTracker::Project.find(@id)
	@stories = @project.stories.all(@query)
	haml :list
end

get '/' do
	@queries = $config['queries']
	haml :index
end
