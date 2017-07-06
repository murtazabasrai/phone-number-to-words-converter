class Converter

	# Class initialize method
	def initialize
		get_input
		get_dictionary
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
		unless (number.length == 10 && number.match(/^[2-9]*$/))
			puts "The number which you entered is invalid."
			# Call the method again if the number is not valid.
			get_input
		else
			p number
		end
	end

	# Hash of numbers associated with alphabets as on a phone keypad.
	def keypad
    @letters = {
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

end

Converter.new