require './lib/Game'
require './lib/review'
require './lib/system'
def read_library
  library = File.open('games.txt', 'r')
  library.each_line do |line|
    stuff = line.split(', ')
    new_game = Game.create(stuff[0], stuff[1], stuff[2])
  end
  library.close
end


def main_menu
  system('clear')
  list_games
  puts "* * * * * * * * * * * *"
  puts "   M A I N   M E N U   "
  puts "* * * * * * * * * * * *"
  puts "*  'A': Add Game      *"
  puts "*  'F': Find Games    *"
  puts "*  'S': Sort Games    *"
  puts "*  'X': Exit          *"
  puts "* * * * * * * * * * * *"
  puts "OR ENTER THE NUMBER OF"
  puts "THE GAME YOU'D LIKE TO ACCESS"
  user_input = gets.downcase.chomp

  if user_input == 'a'
    add_game
  elsif user_input == 'f'
    find_menu
  elsif user_input == 's'
    sort_how
  elsif user_input.to_i.to_s == user_input
    game_window(Game.all[user_input.to_i-1])
  elsif user_input == 'x'
    puts "AWWW!!! We'll miss you!!!!"
  else
    puts "AGHSJDKLF! Invalid Entry!!!"
    sleep(1)
    main_menu
  end
end

def add_game
  system('clear')
  puts "**********************************"
  puts    "Enter the name of the game"
  puts "**********************************"
  new_game_name = gets.capitalize.chomp
  system('clear')
  puts "**********************************"
  puts    "Enter the genre of #{new_game_name}"
  puts "**********************************"
  new_game_genre = gets.capitalize.chomp
  system('clear')
  puts "**********************************"
  puts    "Is #{new_game_name} single or multiplayer (s/m)?"
  puts "**********************************"
  new_game_playa = gets.downcase.chomp
  if new_game_playa[0] == "s"
    new_game_playa = "Single Player"
  elsif new_game_playa[0] == "m"
    new_game_playa = "Multi Player"
  end
  new_game = Game.create(new_game_name, new_game_genre, new_game_playa)
  puts "YAHOO! Game Entered!"
  main_menu
end

def game_window(this_game)
  system('clear')
  puts "\n #{this_game.name}  "
  puts "*******************************************************"
  puts "Genre: #{this_game.genre}"
  puts "Number of players: #{this_game.players}"
  puts "Systems: #{this_game.show_system}"
  puts "Average Review: #{this_game.review_average}"
  puts "*******************************************************"
  puts "add/destroy/mod category what "
  puts "To add a review out of 5 stars:  review add <ranking>"
  puts "Or 'b' to go back to the Main Menu"
  user_input = gets.chomp.split
  if user_input[0] == 'b'
    main_menu
  elsif user_input[0].downcase == "add"
    change_what = user_input[1]
    user_input.shift(2)
    if change_what == "review"
      if user_input.join("").to_i <= 5 && user_input.join("").to_i > 0
        this_game.create_review(user_input.join(" "))
        game_window(this_game)
      else
        puts "☠☠☠ Cheaters never win ☠☠☠"
        sleep(10)
        exit
      end
    elsif change_what == "system"
      this_game.create_system(user_input.join(" "))
      game_window(this_game)
    else
      this_game.modify(change_what, user_input.join(" "))
      game_window(this_game)
    end
  elsif user_input[0].downcase == "mod"
    change_what = user_input[1]
    user_input.shift(2)
    this_game.modify(change_what, user_input.join(" "))
    game_window(this_game)
  elsif user_input[0].downcase == "destroy"
    if user_input[1] == "name"
      user_input.shift(1)
      this_game.delete(user_input.join)
      main_menu
    else
      user_input.shift(1)
      this_game.delete(user_input.join)
      game_window(this_game)
    end
  else
    puts "ERROR! ERR0R! EЯЯ0Я!"
    sleep(3)
    game_window(this_game)
  end

  puts genre add ninja.split
  systems remove pc
end

def sort_how
  system('clear')
  puts "sort by (name[n]/genre[g]/number of players[p])"
  user_input = gets.downcase.chomp
  case user_input
  when 'n'
    Game.sort_by_name
    main_menu
  when 'g'
    Game.sort_by_genre
    main_menu
  when 'p'
    Game.sort_by_players
    main_menu
  else
    puts "Don't you know how to read?!"
    sleep(1)
    sort_how
  end
end

def find_menu
  puts 'Find what? '
  what_to_find = gets.downcase.chomp
  found_array = Game.find(what_to_find)
  system('clear')
  if found_array.length > 0
    puts "**********************************"
    found_array.each_with_index do |object, index|
      puts "#{index+1}: #{object.name}"
    end
    puts "**********************************"
    puts 'Enter the number of the game you want to access'
    puts 'Or enter anything else to go back to main menu...'
    user_input = gets.chomp
    if user_input.to_i.to_s == user_input
      game_window(Game.all[user_input.to_i-1])
    else
      main_menu
    end
  else
    puts "No matching games."
    sleep(1)
    main_menu
  end
end

def list_games
  puts "* * * * G A M E S * * * *"
  Game.all.each_with_index do |title, index|
    puts "#{index+1}: #{title.name} ✿ #{title.genre} ✿ #{title.players}"
  end
end
read_library
main_menu

