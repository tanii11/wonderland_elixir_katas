defmodule AlphabetCipher.Coder do

  def create() do
    0..26 |> Enum.map(fn i ->
      0..26 |> Enum.map(fn j ->
        97 + rem((i + j) , 26)
      end)
    end)
  end

  def encode(keyword, message) do
    key = keyword |> String.to_charlist
    mess = message |> String.to_charlist
    chart = create()
    results = 0..length(mess)-1 |> Enum.map( fn i ->
      Enum.at(chart, (Enum.at(mess, i) - 97)) |> Enum.at(Enum.at(key, rem(i, length(key))) - 97)
    end)
    results |> List.to_string

  end

  def decode(keyword, message) do
    key = keyword |> String.to_charlist
    mess = message |> String.to_charlist
    chart = create()
    #longitud del mensaje
    results = 0..length(mess)-1 |> Enum.map( fn i ->
      Enum.at(chart, (Enum.at(mess, i) - 97)) |> Enum.at(123-Enum.at(key, rem(i, length(key))))
    end)
    results |> List.to_string
  end

  def deciphaler(cipher, message) do
    cip = cipher |> String.to_charlist
    mess = message |> String.to_charlist
    chart = create()

    key = 0..length(mess)-1 |> Enum.map( fn i ->
      mess1 = Enum.at(mess, i) -97
      cip1 = Enum.at(cip, i)
      row = chart |> Enum.at(mess1)
      index_col = Enum.find_index(row, fn x ->  x == cip1 end)
      result = chart |> Enum.at(0) |> Enum.at(index_col) 
    end)

    results = Enum.map(2..Enum.count(key) -1, fn index ->
      pairs = key |> Enum.chunk_every(index)
      if Enum.at(pairs, 0) == Enum.at(pairs, 1) do
        Enum.at(pairs, 0) |> List.to_string
      end
    end)

    Enum.filter(results, & !is_nil(&1)) |> Enum.at(0)
  end
end
