require_relative 'frame'

class Bowling
	MAX_FRAME = 10

	def initialize
		@frames = [Frame.new(1)]
		@scoring = Array.new
	end
	
	def last_frame?(frame)
		frame.num == MAX_FRAME
	end
	
	# Update frames' score given number of pins knocked down in a roll
	def score_roll(pins)
		raise "Illegal roll with score #{pins}." if ! (0..10).include?(pins)
	
		current_frame = @frames.last
		
		raise "Rolls being scored excess the limit of a valid game." if last_frame?(current_frame) && current_frame.score_finalized?
		
		# Score bonuses for frames with strike and spare, 
		# remove from quene when score of frame finalized. 
		@scoring.delete_if {|f| 
			f.score_roll(pins)
			f.score_finalized? 
		}
		
		# All frames compeleted, only bonus rolls left (if any)
		return if last_frame?(current_frame) && current_frame.completed?
		
		if current_frame.completed?
			current_frame = Frame.new(current_frame.num + 1) 
			@frames << current_frame
		end

		current_frame.score_roll(pins)
		
		# Add to quene for scoring bonus of strikes and spares
		@scoring << current_frame if current_frame.strike? || current_frame.spare?
	end
	
	# Process score of each frame given pins knocked down in every roll
	def score_game(all_pins)
		all_pins.each { |p| score_roll(p) }
	end
	
	def total_score
		@frames.map(&:score).inject(:+)
	end
end