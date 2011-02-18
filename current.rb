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

@token = `defaults read com.pivotaltracker token`
@owner = `defaults read com.pivotaltracker name`
@state = ['unstarted', 'started', 'finished', 'delivered', 'rejected']
@today = Time.now.strftime("%m/%d/%Y")

def format_state(str)
	case(str)
	when 'started'
		return "#{str}".yellow
	when 'rejected'
		return "#{str}".red
	when 'finished','delivered'
	  return "#{str}".green
	when 'unstarted'
		return "#{str}".blue
	else
		return str
	end
end

def format_type(str)
  case(str)
  when 'feature'
    return "#{str}".yellow
  when 'chore'
    return "#{str}".blue
  when 'bug'
    return "#{str}".red
  when 'release'
    return "#{str}".green
  else
    return str
  end
end

puts "Printing tickets for #{@today.cyan}"

PivotalTracker::Client.token = @token

@projects = PivotalTracker::Project.all
@projects.each do |project|
	begin
		@a_project = PivotalTracker::Project.find(project.id)
		puts "#{project.name.yellow.bold} - https://www.pivotaltracker.com/projects/#{project.id}"
		stories = @a_project.stories.all(
				:owner => @owner,
				:state => @state
			)
		
		stories.each do |story|
			puts "#{story.name} - #{format_state(story.current_state)} - #{format_type(story.story_type)} - #{story.estimate}"
			puts story.url
			puts
		end
	rescue RestClient::BadRequest => e
		puts "Error reading from Project #{project.name}".red.bold
	end
end
