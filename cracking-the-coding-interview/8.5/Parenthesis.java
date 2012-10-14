import java.util.HashSet;
import java.util.Set;

public class Parenthesis {

	public static Set<String> parenthesis(int quantity) {
		Set<String> parenthesisSet = new HashSet<>();

		if (quantity <= 0) {
			parenthesisSet.add("");
		} else {
			for (String parenthesis : parenthesis(quantity - 1)) {
				for (int i = 0; i <= parenthesis.length(); i++) {
					parenthesisSet.add(parenthesis.substring(0, i) + "()"
							+ parenthesis.substring(i));
				}
			}
		}

		return parenthesisSet;
	}

	public static void main(String[] args) {
		parenthesis(3);
	}
}
