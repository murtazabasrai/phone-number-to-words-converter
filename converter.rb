class Converter

  # Class initialize method
  def initialize
    get_input
    get_dictionary
    get_keypad
    get_key_combinations(@number)
  end

  # Method to read the dictionary file and store it in a global array
  def get_dictionary
    @dictionary_words = File.read("dictionary.txt").split("\n").map(&:downcase)
  end

  # Get user input
  # Validate the number entered by user.
  def get_input
    puts "Please enter a 10 digit number (It should not contain 0 or 1):"
    @number = gets.chomp
    unless (@number.length == 10 && @number.match(/^[2-9]*$/))
      puts "The number which you entered is invalid."
      # Call the method again if the number is not valid.
      get_input
    end
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

  # Method to create all possible word combinations using the keypad letters.
  def get_key_combinations(number)
    # Convert the number into an array
    number_array = number.split("")

    # Convert that array of numbers into a array of characters maching each of the number from keypad list.
    key_characters = number_array.map{|n| @keypad[n]}

    # Take all possible combinations of the words on the keys. 
    # Product of each key's characters with all other key's characters
    key_words = key_characters.shift.product(*key_characters).map(&:join)

    search_word_combinations(key_words)
  end

  # Method to search all possible combinations against dictionary.
  def search_word_combinations(key_words)
    # Starting point for array as minimum word length is 3 characters
    i = 2
    # Create a blank array to store final output.
    final_words = []

    # Loop to get all combinations of words (Minimum word length 3)
    # Lookup those combinations against dictionary & find all matching words.
    while i < 7 do
      # First array of unique starting letters
      a = key_words.map{|x| x[0..i]}.uniq
      # Second array of unique ending letters
      b = key_words.map{|y| y[i+1..-1]}.uniq

      # Checking first array of word combinations with dictionary
      lookup_one = @dictionary_words & a

      # Checking second array of word combinations with dictionary 
      lookup_two = @dictionary_words & b

      # Combining the lookup result arrays
      merge_lookup = lookup_one.product(lookup_two)

      # Inserting the combined array into the final result result array if combined array is not null
      final_words << merge_lookup unless merge_lookup.empty?

      # Increment the loop counter
      i += 1
    end

    # Get exact match
    exact_matches = @dictionary_words & key_words
    final_words << exact_matches

    # Flatten final array by one level.
    p final_words.flatten(1)
  end

end

Converter.new