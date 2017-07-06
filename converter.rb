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
		key_words = key_characters.shift.product(*key_characters)
		p key_words
  end

end

Converter.new