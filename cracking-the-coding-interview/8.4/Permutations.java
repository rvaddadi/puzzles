import java.util.HashSet;
import java.util.Set;

public class Permutations {

	public static Set<String> permutations(String string) {
		Set<String> permutations = new HashSet<>();
		char head;
		String tail;
		Set<String> subpermutations;
		int i;

		if (string.length() < 1) {
			permutations.add(string);
		}
		else {
			head = string.charAt(0);
			tail = string.substring(1);

			subpermutations = permutations(tail);

			for (String subpermutation : subpermutations) {
				for (i = 0; i <= subpermutation.length(); i++) {
					permutations.add(subpermutation.substring(0, i) + head
							+ subpermutation.substring(i));
				}
			}

		}

		return permutations;
	}
	
	public static void main(String[] args) {
		permutations("abc");
	}
}
