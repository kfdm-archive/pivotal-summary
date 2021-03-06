#!/usr/bin/env ruby
# https://github.com/jsmestad/pivotal-tracker
#
# Please setup your pivotal tracker key
# defaults write com.pivotaltracker token <key>
# defaults write com.pivotaltracker name <name>
#
# Requires the following gems
# sudo gem install pivotal-tracker colored

require 'rubygems'
require 'pivotal-tracker'
require 'colored'
require '_common'

@token = `defaults read com.pivotaltracker token`
@owner = `defaults read com.pivotaltracker name`
@state = ['accepted']
@yesterday = (Time.now - 86400).strftime("%m/%d/%Y")

puts "Printing tickets since #{@yesterday.cyan}"

PivotalTracker::Client.token = @token

@projects = PivotalTracker::Project.all
@projects.each do |project|
	begin
		@a_project = PivotalTracker::Project.find(project.id)
		puts project.name.yellow.bold
		stories = @a_project.stories.all(:owner => @owner,
				:state => @state, 
				:modified_since => @yesterday
			)
		
		stories.each do |story|
			format_story(story)
		end
	rescue RestClient::BadRequest => e
		puts "Error reading from Project #{project.name}".red.bold
	end
end
