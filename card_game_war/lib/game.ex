defmodule CardGameWar.Game do

  # feel free to use these cards or use your own data structure"
  def suits, do: [:spade, :club, :diamond, :heart]
  def ranks, do: [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
  
  def cards do
    for suit <- suits,
        rank <- ranks do
      {suit, rank}
    end
  end
  
  def call_cards do
    cards = cards() |> Enum.shuffle()

    player1 = 0..25 |> Enum.map(fn i ->
      Enum.at(cards, i)
    end)
    player2 = 26..length(cards)-1 |> Enum.map(fn i ->
      Enum.at(cards, i)
    end)
    win = game(player1, player2)
  end

  def game(_, []), do: "Player 1 Win"
  def game([], _), do: "Player 2 Win"
  def game([h | t], [h2 | t2]) do

    rank1 = rankToValue(elem(h, 1)) 
    rank2 = rankToValue(elem(h2, 1)) 
    suit1 = suitToValue(elem(h, 0)) 
    suit2 = suitToValue(elem(h2, 0))

    cond do
      rank1 > rank2 -> game(t++[h2]++[h], t2)
      rank1 < rank2 -> game(t, t2++[h]++[h2])
      true ->
        if suit1 > suit2 do
          game(t++[h2]++[h], t2)
        else
          game(t, t2++[h]++[h2])
        end
    end
 end


  def rankToValue(rank) do
    cond do
      rank == :ace   -> 14
      rank == :king  -> 13
      rank == :queen -> 12
      rank == :jack  -> 11
      true -> rank
    end
  end

  def suitToValue(suit) do

    cond do
      suit == :heart   -> 4
      suit == :diamond -> 3
      suit == :club    -> 2
      true -> 1
    end
  end

end
