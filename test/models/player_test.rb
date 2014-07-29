require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should not save invalid player" do
    player = Player.new
    assert player.invalid?
    assert_not player.errors[:name].empty?
    assert_not player.errors[:club].empty?
    assert_not player.errors[:country].empty?
    assert_not player.save
  end
  
  test "should not save invalid cricketer" do
    player = Cricketer.new
    assert player.invalid?
    assert_not player.errors[:name].empty?
    assert_not player.errors[:club].empty?
    assert_not player.errors[:country].empty?
    assert_not player.save
  end
  test "should not save invalid footballer" do
    player = Footballer.new
    assert player.invalid?
    assert_not player.errors[:name].empty?
    assert_not player.errors[:club].empty?
    assert_not player.errors[:country].empty?
    assert_not player.save
  end
  
  test "should save the valid batsman " do
    player = Batsman.new(name: "sachin", club: "mumbai", country: "india")
    assert player.valid?
    assert player.errors[:name].empty?
    assert player.errors[:club].empty?
    assert player.errors[:country].empty?
    
    assert player.save
  end
  
  test "should save the valid bowler " do
    player = Bowler.new(name: "irfan", club: "mumbai", country: "india")
    assert player.valid?
    assert player.errors[:name].empty?
    assert player.errors[:club].empty?
    assert player.errors[:country].empty?
    
    assert player.save
  end
  
  test "should save the valid striker " do
    player = Striker.new(name: "messi", club: "fcb", country: "spain")
    assert player.valid?
    assert player.errors[:name].empty?
    assert player.errors[:club].empty?
    assert player.errors[:country].empty?
    
    assert player.save
  end
  
  test "should save the valid defender " do
    player = Defender.new(name: "robino", club: "mcity", country: "brazil")
    assert player.valid?
    assert player.errors[:name].empty?
    assert player.errors[:club].empty?
    assert player.errors[:country].empty?
    
    assert player.save
  end
  
  
end
