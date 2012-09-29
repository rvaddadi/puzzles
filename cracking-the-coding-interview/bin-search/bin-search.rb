def bin_search(array, element)
  return if array.empty?

  middle         = array.size / 2
  middle_element = array[middle]

  if element == middle_element
    element
  else
    search_interval = element < middle_element ? 0...middle : (middle + 1)..-1
    bin_search(array[search_interval], element)
  end
end
