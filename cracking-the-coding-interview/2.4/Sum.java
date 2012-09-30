class Digit {

	private int value;
	private Digit next;

	public Digit(int value) {
		this.value = value;
		this.next = null;
	}

	public Digit(int value, Digit next) {
		this.value = value;
		this.next = next;
	}

	public Digit getNext() {
		return next;
	}

	public void setNext(Digit next) {
		this.next = next;
	}

	public int getValue() {
		return value;
	}
}

public class Sum {

	public static Digit sum(Digit factor1, Digit factor2) {
		Digit sum;
		Digit nextDigitSum;
		Digit currentDigitSum;
		int nextValue;
		int carry;

		sum = null;
		carry = 0;
		currentDigitSum = null;

		while (factor1 != null || factor2 != null) {
			nextValue = 0;
			if (factor1 == null) {
				nextValue = factor2.getValue() + carry;
				carry = 0;
			} else if (factor2 == null) {
				nextValue = factor1.getValue() + carry;
				carry = 0;
			} else {
				nextValue = factor1.getValue() + factor2.getValue() + carry;
				carry = 0;
				if (nextValue > 9) {
					nextValue -= 10;
					carry = 1;
				}
			}

			nextDigitSum = new Digit(nextValue);

			if (sum == null) {
				sum = nextDigitSum;
			} else {
				currentDigitSum.setNext(nextDigitSum);
			}

			currentDigitSum = nextDigitSum;

			if (factor1 != null) {
				factor1 = factor1.getNext();
			}
			if (factor2 != null) {
				factor2 = factor2.getNext();
			}
		}

		return sum;
	}

	public static void main(String[] args) {
		Digit factor1 = new Digit(3, new Digit(1, new Digit(5)));
		Digit factor2 = new Digit(5, new Digit(9, new Digit(2)));

		sum(factor1, factor2);
	}
}