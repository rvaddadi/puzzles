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

    public static void main(String[] args) {

        Set<Integer> subject = new HashSet<>();

        subject.add(1);
        subject.add(2);
        subject.add(3);

        allSubsets(subject);
    }
}
