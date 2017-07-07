class Converter

  # Class custom initialize method
  # Command: ruby Converter.new.start
  def initialize
    get_dictionary
    get_keypad
    get_input unless ENV["CONVERTER_ENV"] == "test"
  end

  # Method to read the dictionary file and store it in a global array
  def get_dictionary
    @dictionary_words = File.read("dictionary.txt").split("\n").map(&:downcase)
  end

  # Get user input
  # Validate the number entered by user.
  def get_input
    puts "Please enter a 10 digit number (It should not contain 0 or 1):"
    number = gets.chomp
    get_key_combinations(number)
  end

  # Hash of numbers associated with alphabets as on a phone keypad.
  def get_keypad
    @keypad = {
      "2" => ['a','b','c'],
      "3" => ['d','e','f'],
      "4" => ['g','h','i'],
      "5" => ['j','k','l'],
      "6" => ['m','n','o'],
      "7" => ['p','q','r','s'],
      "8" => ['t','u','v'],
      "9" => ['w','x','y','z']
    }
  end

  # Method to check if the given number is valid or not
  # It checks if the number is of 10 digits and does not contain 0 or 1.
  def check_valid_number(number)
    unless (number.length == 10 && number.match(/^[2-9]*$/))
      raise "The given number is not valid. Please try again"
    end
  end

  # Method to create all possible word combinations using the keypad letters.
  def get_key_combinations(number)
    check_valid_number(number)
    # Convert the number into an array
    number_array = number.split("")

    # Convert that array of numbers into a array of characters maching each of the number from keypad list.
    key_characters = number_array.map{|n| @keypad[n]}

    # Take all possible combinations of the words on the keys. 
    # Product of each key's characters with all other key's characters
    begin
      key_words = key_characters.shift.product(*key_characters).map(&:join)
    rescue TypeError
      return "The number you have entered is not a valid number. Please try again."
    end

    search_word_combinations(key_words)
  end

  # Method to search all possible combinations against dictionary.
  def search_word_combinations(key_words)
    final_words = []
    # Loop to get all combinations of words (Minimum word length 3)
    i = 2
    while i < 7 do
      a = key_words.map{|x| x[0..i]}.uniq
      b = key_words.map{|y| y[i+1..-1]}.uniq

      # Find all matching words from dictionary
      lookup_one = @dictionary_words & a
      lookup_two = @dictionary_words & b

      # Combining the lookup result arrays
      merge_lookup = lookup_one.product(lookup_two)
      final_words << merge_lookup unless merge_lookup.empty?
      i += 1
    end

    # Get exact matches
    exact_matches = @dictionary_words & key_words
    final_words << exact_matches

    # Flatten final array by one level.
    p final_words.flatten(1)
  end

end

Converter.new