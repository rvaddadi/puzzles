public class NextBitCount {

	public static String[] nextBitCount(String n) {
		int index;
		String prependedN;
		String smallest;
		String largest;

		prependedN = "0" + n;

		index = prependedN.lastIndexOf("01");

		largest = prependedN.substring(0, index) + "10"
				+ rightOnes(prependedN.substring(index + 2));

		index = n.lastIndexOf("10");

		smallest = n.substring(0, index) + "01" + n.substring(index + 2);

		return new String[] { smallest, largest };
	}

	private static String rightOnes(String n) {
		String result;
		int i;

		result = "";

		for (i = 0; i < n.length(); i++) {
			if (n.charAt(i) == '0') {
				result = "0" + result;
			} else {
				result += "1";
			}
		}

		return result;
	}

	public static void main(String[] args) {
		nextBitCount("10110");
		nextBitCount("10111");
	}
}
