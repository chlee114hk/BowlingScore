class Frame
	FRAME_COMPLETED_STATE = [:strike, :spare, :open]
	
	def initialize(frame_num)
		@num = frame_num
		@score = 0
		@bonus_rolls = 0
		@state = nil
		# Not need for calculating score, just keep it for tracing
		@rolls = Array.new
	end
	
	def score
		@score
	end

	def num
		@num
	end
	
	# Update score and state of frame
	def score_roll(pins)
		@score += pins
		case @state 
		when :strike, :spare
			@bonus_rolls -= 1
		# Roll second ball
		when :incomplete
			raise "Illegal roll with score #{pins} in a incomplete frame." if @score > 10
			@state = @score == 10 ? :spare : :open
			@bonus_rolls = 1 if @state == :spare
			@rolls << pins
		# Roll first ball
		else
			@state = @score == 10 ? :strike : :incomplete
			@bonus_rolls = 2 if @state == :strike
			@rolls << pins
		end
	end
	
	def strike?
    @state == :strike
  end

  def spare?
    @state == :spare
  end
	
	def completed?
		FRAME_COMPLETED_STATE.include?(@state)
	end
	
	def score_finalized?
		completed? && @bonus_rolls == 0
	end
end