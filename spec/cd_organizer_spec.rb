require 'Rspec'
require 'Game'
require 'Genre'

describe Game do

  before do
    Game.clear
  end

  it 'creates an instance of system' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.should be_an_instance_of Game
  end
  it 'pushes object into games array' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    Game.all.should eq [new_game]
  end
  it 'modifies the name' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.modify(1, "Colla Poopie")
    new_game.name.should eq "Colla Poopie"
    new_game.genre.should eq "FPS"
  end
  it 'modifies the genre' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.modify(2, "travel")
    new_game.genre.should eq "travel"
    new_game.name.should eq "Colla Doodie"
  end
  it 'modifies the players' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.modify(3, "single")
    new_game.players.should eq "single"
    new_game.genre.should eq "FPS"
    new_game.name.should eq "Colla Doodie"
  end
  it 'deletes the game' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.delete(1, 0)
    Game.all.length.should eq 0
  end
  it 'deletes the genre' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.delete(2, 0)
    new_game.genre.should eq ""
    new_game.name.should eq "Colla Doodie"
  end
  it 'deletes the players' do
    new_game = Game.create("Colla Doodie", "FPS", "multi")
    new_game.delete(3, 0)
    new_game.players.should eq ""
    new_game.genre.should eq "FPS"
    new_game.name.should eq "Colla Doodie"
  end
  it 'sorts by game name' do
    new_game = Game.create("Blah", "Blah", "blah")
    another_game = Game.create("Cheese", "Cheese", "Cheese")
    and_another_game = Game.create("Apple", "Apple", "Apple")
    Game.sort_by_name
    Game.all.should eq [and_another_game, new_game, another_game]
  end
  it 'sorts by genre' do
    new_game = Game.create("Blah", "Blah", "blah")
    and_another_game = Game.create("Cheese", "Cheese", "Cheese")
    another_game = Game.create("Apple", "Apple", "Apple")
    Game.sort_by_genre
    Game.all.should eq [another_game, new_game, and_another_game]
  end
  it 'sorts by players name' do
    new_game = Game.create("Blah", "Blah", "elah")
    another_game = Game.create("Cheese", "Cheese", "aheese")
    and_another_game = Game.create("Apple", "Apple", "zpple")
    Game.sort_by_players
    Game.all.should eq [another_game, new_game, and_another_game]
  end

end
