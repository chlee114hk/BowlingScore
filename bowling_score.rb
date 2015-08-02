require_relative 'lib/bowling'

begin
	pins = ARGV[0].split(',').map(&:to_i)
	game = Bowling.new
	game.score_game(pins)
	puts game.total_score
end