require 'spec_helper'

describe "frame" do
	before :each do
    @frame = Frame.new(1)
  end

	it "should have num equal to 1" do
		expect(@frame.num).to eq(1)
	end
	
	it "should have score equal to 0 at initial" do
		expect(@frame.score).to eq(0)
	end
	
	it "should have score equal to pins knocked down" do
		@frame.score_roll(1)
		expect(@frame.score).to eq(1)
	end
	
	it "should change state to :strike if 10 pins knocked down" do
		@frame.score_roll(10)
		expect(@frame.instance_variable_get(:@state)).to eq(:strike)
	end
	
	it "should change state to :incomplete if not rolled strike" do
		@frame.score_roll(5)
		expect(@frame.instance_variable_get(:@state)).to eq(:incomplete)
	end
	
	it "should change state to :open if score below 10 after two ball rolled" do
		@frame.score_roll(5)
		@frame.score_roll(4)
		expect(@frame.instance_variable_get(:@state)).to eq(:open)
	end
	
	it "should change state to :spare if score 10 after two ball rolled" do
		@frame.score_roll(5)
		@frame.score_roll(5)
		expect(@frame.instance_variable_get(:@state)).to eq(:spare)
	end
	
	it "should reduce bonus rolls by 1 when scoring bonus at state :spare" do
		@frame.instance_variable_set(:@state, :spare)
		@frame.instance_variable_set(:@bonus_rolls, 1)
		@frame.score_roll(5)
		expect(@frame.instance_variable_get(:@bonus_rolls)).to eq(0)
	end
	
	it "should reduce bonus rolls by 1 when scoring bonus at state :strike" do
		@frame.instance_variable_set(:@state, :strike)
		@frame.instance_variable_set(:@bonus_rolls, 2)
		@frame.score_roll(5)
		expect(@frame.instance_variable_get(:@bonus_rolls)).to eq(1)
	end
	
	it ".strike? should return true when state set to :strike" do
		@frame.instance_variable_set(:@state, :strike)
		expect(@frame.strike?).to eq(true)
	end
	
	it ".spare? should return true when state set to :spare" do
		@frame.instance_variable_set(:@state, :spare)
		expect(@frame.spare?).to eq(true)
	end
	
	it ".completed? should return true when state set to :open" do
		@frame.instance_variable_set(:@state, :open)
		expect(@frame.completed?).to eq(true)
	end
	
	it ".completed? should return true when state set to :strike" do
		@frame.instance_variable_set(:@state, :strike)
		expect(@frame.completed?).to eq(true)
	end
	
	it ".completed? should return true when state set to :spare" do
		@frame.instance_variable_set(:@state, :spare)
		expect(@frame.completed?).to eq(true)
	end
	
	it ".completed? should return false when state set to ::incomplete" do
		@frame.instance_variable_set(:@state, :incomplete)
		expect(@frame.completed?).to eq(false)
	end
	
	it ".score_finalized? should return true when state set to :spare with no bonus rolls" do
		@frame.instance_variable_set(:@state, :spare)
		@frame.instance_variable_set(:@bonus_rolls, 0)
		expect(@frame.score_finalized?).to eq(true)
	end
	
	it ".score_finalized? should return true when state set to :strike with no bonus rolls" do
		@frame.instance_variable_set(:@state, :strike)
		@frame.instance_variable_set(:@bonus_rolls, 0)
		expect(@frame.score_finalized?).to eq(true)
	end
end