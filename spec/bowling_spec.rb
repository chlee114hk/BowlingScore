require 'spec_helper'

describe "bowling" do
	before :each do
    @game = Bowling.new
  end
	
	it ".last_frame? should be at frame 10" do
		expect(@game.last_frame?(Frame.new(10))).to eq(true)
	end
	
	it "have scroe 300 for pins data 10,10,10,10,10,10,10,10,10,10,10,10" do
		@game.score_game([10,10,10,10,10,10,10,10,10,10,10,10])
		expect(@game.total_score).to eq(300)
	end
	
	it "have scroe 20 for pins data 1,2,3,4,5,5" do
		@game.score_game([1,2,3,4,5,5])
		expect(@game.total_score).to eq(20)
	end
	
	it "have scroe 48 for pins data 9,1,10,8,0,2" do
		@game.score_game([9,1,10,8,0,2])
		expect(@game.total_score).to eq(48)
	end
	
	it "have scroe 50 for pins data 10,0,0,9,1,0,0,8,2,0,0,7,3,0,0,6,4,0,0" do
		@game.score_game([10,0,0,9,1,0,0,8,2,0,0,7,3,0,0,6,4,0,0])
		expect(@game.total_score).to eq(50)
	end
	
	it "have scroe 150 for 10 spares with all 5 pins" do
		@game.score_game([5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5])
		expect(@game.total_score).to eq(150)
	end
	
	it "have scroe 90 for all 9 pins" do
		@game.score_game([9,0,8,1,7,2,6,3,5,4,4,5,6,3,7,2,8,1,9,0])
		expect(@game.total_score).to eq(90)
	end
	
	it "have scroe 0 for all misses" do
		@game.score_game([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
		expect(@game.total_score).to eq(0)
	end
	
	it "have scroe 30 for a strike followed by a spare" do
		@game.score_game([10, 9, 1])
		expect(@game.total_score).to eq(30)
	end
	
	it "have scroe 30 for a spare followed by a strike" do
		@game.score_game([9, 1, 10])
		expect(@game.total_score).to eq(30)
	end
	
	it "with illegal score should raise error" do
	  expect{@game.score_game([-1])}.to raise_error("Illegal roll with score -1.")
	end
	
	it "with illegal score in incomplete frame should raise error" do
	  expect{@game.score_game([6,5])}.to raise_error("Illegal roll with score 5 in a incomplete frame.")
	end
	
	it "with to many rolls being scored should raise error" do
	  expect{@game.score_game([10,10,10,10,10,10,10,10,10,10,10,10,10])}.to raise_error("Rolls being scored excess the limit of a valid game.")
	end
end