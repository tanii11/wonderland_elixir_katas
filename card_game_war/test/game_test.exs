defmodule CardGameWar.GameTest do
  use ExUnit.Case
  import CardGameWar.Game
 
  test "the highest rank wins the cards in the round" do
    assert "Player 1 Win" == 
           CardGameWar.Game.game([{:diamond, :ace}], [{:spade, 7}]) 
  end

  test "queens are higher rank than jacks" do
   assert "Player 2 Win" == 
           CardGameWar.Game.game([{:diamond, :jack}], [{:spade, :queen}]) 
  end

  test "kings are higher rank than queens" do
    assert "Player 1 Win" == 
           CardGameWar.Game.game([{:club, :king}], [{:spade, :queen}]) 
  end

  test "aces are higher rank than kings" do
    assert "Player 2 Win" == 
           CardGameWar.Game.game([{:club, :king}], [{:heart, :ace}]) 
  end

  test "if the ranks are equal, clubs beat spades" do
    assert "Player 1 Win" == 
           CardGameWar.Game.game([{:club, 4}], [{:spade, 4}]) 
  end

  test "if the ranks are equal, diamonds beat clubs" do
    assert "Player 2 Win" == 
           CardGameWar.Game.game([{:club, :king}], [{:diamond, :king}]) 
  end

  test "if the ranks are equal, hearts beat diamonds" do
    assert "Player 1 Win" == 
           CardGameWar.Game.game([{:heart, 7}], [{:diamond, 7}])   
  end

  # test "the player loses when they run out of cards" do
  #   assert "Player 1 Win" == 
  #          CardGameWar.Game.game(_, [])
  # end

end
