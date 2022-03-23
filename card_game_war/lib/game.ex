defmodule CardGameWar.Game do

  # feel free to use these cards or use your own data structure"
  @suits [:spade, :club, :diamond, :heart]
  @ranks [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
  @cards for suit <- @suits, rank <- @ranks, do: {suit, rank}

    #estructura de juego 1 y 2
  defstruct deck_p1: [], deck_p2: []

    #funcion para ver las cartas del juego
  def cards, do: @cards
   
  def new do
    #barajea las cartas 
    cards = @cards |> Enum.shuffle() |> Enum.shuffle() |> Enum.shuffle()
    #reparte 26 cartas a c/u
    {cards_p1, cards_p2} = Enum.split(cards, 26)
    #las guarda en el struct 
    %__MODULE__{deck_p1: cards_p1, deck_p2: cards_p2}
  end

    #funciones de casos base
    #en la primera: si el jugador 1 ya no tiene cartas: gana P1
    #en la segunda: si el jugador 2 ya no tiene cartas: gana P2
  def play(%__MODULE__{deck_p1: []} = _game), do: :player_two
  def play(%__MODULE__{deck_p2: []} = _game), do: :player_one
    #manda la lista de la struc de deck_p1 y deck_p2
  def play(%__MODULE__{deck_p1: [card_1 | other_cards_1 ], deck_p2: [card_2 | other_cards_2]} = game) do
    case round_winner(card_1, card_2) do
        #vuelve a mandar la funcion play, donde se guarda la nueva structura, añadiendo las cartas al ganador
      :player_one ->
        play(%{game | deck_p1: other_cards_1 ++ [card_1, card_2], deck_p2: other_cards_2})
      :player_two ->
        play(%{game | deck_p1: other_cards_1, deck_p2: other_cards_2 ++ [card_1, card_2]})
      error -> throw error
    end
  end

    #funcion que decide quien gana un round
  def round_winner({suit_1, rank_1}, {suit_2, rank_2})
  #aqui le dice que los valores que entren deben estar en @suit y en @ranks, si no mandara error
  when
    suit_1 in @suits
    and suit_2 in @suits
    and rank_1 in @ranks
    and rank_2 in @ranks
  do
  #va obtener el valor relativo de @ranks para ambos jugadores (rank_1 y rank_2)
    rel_val_1 = Enum.find_index(@ranks, &(&1 == rank_1))
    rel_val_2 = Enum.find_index(@ranks, &(&1 == rank_2))

    #reglas del juego
    cond do
      rel_val_1 > rel_val_2 -> :player_one
      rel_val_1 < rel_val_2 -> :player_two
      true ->
       #va obtener el valor relativo de @suits para ambos jugadores (suit_1 y suit_2)
        suit_rel_val_1 = Enum.find_index(@suits, &(&1 == suit_1))
        suit_rel_val_2 = Enum.find_index(@suits, &(&1 == suit_2))

        cond do
          suit_rel_val_1 > suit_rel_val_2 -> :player_one
          suit_rel_val_1 < suit_rel_val_2 -> :player_two
          true -> {:error, "The 2 cards are the same! Come on!"}
        end
    end
  end
end