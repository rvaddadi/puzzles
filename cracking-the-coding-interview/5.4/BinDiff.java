public class BinDiff {
	public static int binDiff(int a, int b) {
		String diffString = Integer.toBinaryString(a ^ b);
		int result = 0;

		for (int i = 0; i < diffString.length(); i++) {
			if (diffString.charAt(i) == '1') {
				result += 1;
			}
		}

		return result;
	}
	
	public static void main(String[] args) {
		binDiff(31, 14);
	}
}
