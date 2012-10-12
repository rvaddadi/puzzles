import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Subsets {

    public static <T> Set<Set<T>> allSubsets(Set<T> set) {

        Set<Set<T>> subsets;
        Set<T> subset;
        List<T> list;
        int mask;
        int i;

        list = new ArrayList<>(set);
        subsets = new HashSet<>();

        for (mask = 0; mask < 1 << list.size(); mask++) {
            subset = new HashSet<>();
            for (i = 0; i < list.size(); i++) {
                if ((mask & 1 << i) == 0) {
                    subset.add(list.get(i));
                }
            }
            subsets.add(subset);
        }

        return subsets;
    }

    @SuppressWarnings("unchecked")
    public static <T> Set<Set<T>> allSubsetsRecursive(Set<T> set) {

        Set<Set<T>> subsets;
        Set<T> newSubset;
        T head;
        Set<T> tail;

        subsets = new HashSet<>();

        if (set.isEmpty()) {
            subsets.add(set);
        }
        else {
            head = (T) set.toArray()[0];
            tail = new HashSet<>(set);
            tail.remove(head);

            for (Set<T> subset : allSubsetsRecursive(tail)) {
                subsets.add(subset);
                newSubset = new HashSet<>(subset);
                newSubset.add(head);
                subsets.add(newSubset);
            }
        }

        return subsets;
    }

    public static void main(String[] args) {

        Set<Integer> subject = new HashSet<>();

        subject.add(1);
        subject.add(2);
        subject.add(3);

        allSubsets(subject);
        allSubsetsRecursive(subject);
    }
}
