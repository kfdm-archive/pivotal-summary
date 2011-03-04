def format_state(str)
	case(str)
	when 'started'
		return "#{str}".yellow
	when 'rejected'
		return "#{str}".red
	when 'finished','delivered','accepted'
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

def format_story(story)
	puts "#{story.name} - #{format_state(story.current_state)} - #{format_type(story.story_type)} - #{story.estimate}"
	puts story.url
	puts
end
