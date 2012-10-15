public class Representations {

	public static int representations(int n) {
		return representations(n, 25);
	}

	private static int representations(int n, int max) {
		int representations;

		representations = 0;

		if (n == 0) {
			representations = 1;
		} else if (n > 0) {
			if (25 <= max && n >= 25) {
				representations += representations(n - 25, 25);
			}
			if (10 <= max && n >= 10) {
				representations += representations(n - 10, 10);
			}
			if (5 <= max && n >= 5) {
				representations += representations(n - 5, 5);
			}
			if (1 <= max && n >= 1) {
				representations += representations(n - 1, 1);
			}
		}

		return representations;
	}

	// solution from book to confirm my answer
	public static int makeChange(int n, int denom) {
		int next_denom = 0;
		switch (denom) {
		case 25:
			next_denom = 10;
			break;
		case 10:
			next_denom = 5;
			break;
		case 5:
			next_denom = 1;
			break;
		case 1:
			return 1;
		}
		int ways = 0;
		for (int i = 0; i * denom <= n; i++) {
			ways += makeChange(n - i * denom, next_denom);
		}
		return ways;
	}

	public static void main(String[] args) {
		representations(1);
		representations(3);
		representations(8);
		representations(10);
		representations(11);

		representations(100);
		makeChange(100, 25);
	}
}
