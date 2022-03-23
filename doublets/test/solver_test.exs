defmodule Doublets.SolverTest do
  use ExUnit.Case
  import Doublets.Solver

  test "with word links found" do
    assert ["head", "heal", "teal", "tell", "tall", "tail"] ==
           doublets("head", "tail")

    assert ["door", "boor", "book", "look", "lock"] ==
           doublets("door", "lock")

    assert ["bank", "bonk", "book", "look", "loon", "loan"] ==
           doublets("bank", "loan")

    assert ["wheat", "cheat", "cheap", "cheep", "creep", "creed", "breed", "bread"] ==
           doublets("wheat", "bread")
  end

  test "with no word links found" do
    assert [] == doublets("ye", "freezer")
  end

  test "find solution" do
   assert ["head", "heal"] == 
     find_solution([["head", "heal"], ["head", "tell"]], "heal")
   assert ["look", "lock", "bonk"] ==
     find_solution([["look", "lock", "bank"], ["look", "lock", "bonk"]], "bonk")
   assert nil == find_solution([], "bonk")
  end
  test "complete seq variantes" do
   assert [["book", "boor"], ["book", "look"], ["book", "bonk"]] ==
    complete_seq_variants(["book"])
   assert [["tell", "teal"], ["tell", "tall"]] ==
    complete_seq_variants(["tell"])
   assert [] == complete_seq_variants([""])
  end
  test "find variants" do
    assert ["boor", "look", "bonk"] == find_variants("book")
    assert ["look", "loan"] == find_variants("loon")
    assert ["heal"] == find_variants("head")
    assert [] == find_variants("")
  end

  test "same length words" do
    assert ["liken", "impar", "untie", "wheat", "cheat", "cheap", "cheep", "creep",
    "creed", "bread"] == same_length_words("breed")
    assert [] == same_length_words ("ye")
  end
  test "distance" do
    assert 1 == distance("head", "heal")
    assert 2 == distance("door", "book")
    assert 4 == distance("look", "wheat")
    assert 0 == distance("head", "head")
    assert 0 == distance("", "")

  end

  test "last_word" do 
    assert "tall" ==
       last_word(["head", "heal", "tell", "tall"])
    assert "look" ==
       last_word(["door", "boor", "look"])
    assert "cheep" ==
       last_word(["cheep"])
  end

  test "last_word with empty list" do
     assert nil ==
     last_word([])
  end
end
