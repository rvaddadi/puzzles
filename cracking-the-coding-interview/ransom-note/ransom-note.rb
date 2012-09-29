def ransom_note(message, magazine)
  to_dictionary = ->(string){
    string.split(' ').reduce(Hash.new(0)) do |dictionary, word|
      dictionary[word] += 1
      dictionary
    end
  }

  message_dictionary  = to_dictionary.(message)
  magazine_dictionary = to_dictionary.(magazine)

  message_dictionary.all? { |word, count| magazine_dictionary[word] >= count }
end
