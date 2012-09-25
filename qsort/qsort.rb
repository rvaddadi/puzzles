def qsort(array)
  if array.empty?
    array
  else
    pivot = array.pop
    smaller_than_pivot_partition, greater_than_pivot_partition = array.partition { |x| x < pivot }.map { |partition| qsort(partition) }
    smaller_than_pivot_partition + [pivot] + greater_than_pivot_partition
  end
end

p qsort([1, 2, 3, 4])
p qsort([4, 3, 2, 1])
p qsort([3, 4, 2, 1])
