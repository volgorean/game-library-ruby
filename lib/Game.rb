class Game
  attr_reader(:name, :genre, :players, :reviews, :systems)
  @@games = []
  def initialize(name, genre, players)
    @name = name
    @genre = genre
    @players = players
    @reviews = []
    @systems = []
  end

  def Game.create(name, genre, players)
    new_game = Game.new(name, genre, players)
    @@games << new_game
    new_game
  end

  def Game.all
    @@games
  end

  def Game.sort_by_name
    @@games.sort!{ |x, y| x.name <=> y.name }
  end

  def Game.sort_by_genre
    @@games.sort!{ |x, y| x.genre <=> y.genre }
  end

  def Game.sort_by_players
    @@games.sort!{ |x, y| y.players <=> x.players }
  end

  def Game.clear
    @@games = []
  end

  def Game.find(what)
    found_array = []
    @@games.each do |game|
      if (game.name.downcase.include? what) || (game.genre.downcase.include? what) || (game.players.downcase.include? what)
        found_array << game
      end
      game.systems.each do |system|
        if system.system.downcase.include? what
          found_array << game
        end
      end
    end
    found_array
  end

  def create_review(review)
    new_review = Review.new(review)
    @reviews << new_review
    new_review
  end

  def review_average
    length = @reviews.length
    if length == 0
      "☆" * 5
    else
      total_reviews = 0
      reviews.each do |review|
        total_reviews += review.review.to_i
      end
      "☭" * (total_reviews/length) + "☆" * (5-total_reviews/length)
    end
  end

  def create_system(system)
    new_system = System.new(system)
    @systems << new_system
    new_system
  end

  def show_system
    output = ""
    systems.each do |system|
      output += (system.system + " ")
    end
    output
  end

  def modify(index, change)
    case index
    when "name"
      @name = change
    when "genre"
      @genre = change
    when "players"
      @players = change
    end
  end

  def delete(category)
    case category
    when "name"
      @@games.delete(self)
    when "genre"
      @genre = ""
    when "players"
      @players = ""
    end
  end
end


