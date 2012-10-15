public class Queens {
	public static void eightQueens() {
		eightQueens(new int[8], 0);
	}

	private static void eightQueens(int[] queens, int index) {
		int tentative;
		int i;
		boolean valid;
		int distance;

		for (tentative = 0; tentative < 8; tentative++) {
			valid = true;

			for (i = 0; valid && i < index; i++) {
				distance = Math.abs(tentative - queens[i]);
				if (distance == 0 || distance == index - i) {
					valid = false;
				}
			}

			if (valid) {
				queens[index] = tentative;
				if (index == 7) {
					printQueens(queens);
				} else {
					eightQueens(queens, index + 1);
				}
			}
		}
	}

	public static void printQueens(int[] queens) {
		int i;
		int j;

		for (i = 0; i < 8; i++) {
			for (j = 0; j < 8; j++) {
				if (queens[i] == j) {
					System.out.print("x");
				} else {
					System.out.print(".");
				}
			}
			System.out.println("\n");
		}

		System.out.println("\n");
	}

	public static void main(String[] args) {
		eightQueens();
	}
}
