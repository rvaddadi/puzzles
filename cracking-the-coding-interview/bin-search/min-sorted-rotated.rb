def min_sorted_rotated(array)
  return if array.empty?

  first = array.first
  last  = array.last

  if first <= last
    first
  else
    size         = array.size
    middle_index = size / 2

    search_interval = first < array[middle_index] ?
                        (middle_index + 1)..size :
                        1..middle_index

    min_sorted_rotated(array[search_interval])
  end
end
