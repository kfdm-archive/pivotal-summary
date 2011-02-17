#!/usr/bin/env ruby
# https://github.com/jsmestad/pivotal-tracker
#
# Please setup your pivotal tracker key
# defaults write com.pivotaltracker token <key>
# defaults write com.pivotaltracker name <name>

require 'rubygems'
require 'pivotal-tracker'
require 'colored'

PivotalTracker::Client.token = `defaults read com.pivotaltracker token`

@yesterday = (Time.now - 86400).strftime("%m/%d/%Y")
puts "Printing tickets since #{@yesterday}"

@projects = PivotalTracker::Project.all
@projects.each do |project|
	begin
		@a_project = PivotalTracker::Project.find(project.id)
		puts project.name.yellow.bold
		stories = @a_project.stories.all(:owner => `defaults read com.pivotaltracker name`,
				:state => 'accepted', 
				:modified_since => @yesterday
			)
		
		stories.each do |story|
			puts story.name
			puts story.url
			puts
		end
	rescue RestClient::BadRequest => e
		puts "Error reading from Project #{project.name}".red.bold
	end
end
