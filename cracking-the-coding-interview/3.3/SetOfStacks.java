import java.util.ArrayList;

class SetOfStacksNode<T> {

	private T element;
	private SetOfStacksNode<T> next;
	private int count;

	public SetOfStacksNode(T element, SetOfStacksNode<T> next, int count) {
		this.element = element;
		this.next = next;
		this.count = count;
	}

	public T getElement() {
		return element;
	}

	public SetOfStacksNode<T> getNext() {
		return next;
	}

	public int getCount() {
		return count;
	}
}

class EmptyStackException extends RuntimeException {
	private static final long serialVersionUID = 950587380668383324L;
}

public class SetOfStacks<T> {

	private static final int DEFAULT_THRESHOLD = 3;

	private ArrayList<SetOfStacksNode<T>> stacks;
	private int threshold;

	public SetOfStacks() {
		this(DEFAULT_THRESHOLD);
	}

	public SetOfStacks(int threshold) {
		this.threshold = threshold;
		this.stacks = new ArrayList<>();
	}

	public void push(T element) {
		if (newStackNecessary()) {
			newStack(element);
		} else {
			addElementToCurrentStack(element);
		}
	}

	private void newStack(T element) {
		stacks.add(new SetOfStacksNode<T>(element, null, 1));
	}

	private void addElementToCurrentStack(T element) {
		SetOfStacksNode<T> currentStack = getCurrentStack();

		SetOfStacksNode<T> newStack = new SetOfStacksNode<T>(element,
				currentStack, currentStack.getCount() + 1);

		stacks.set(getCurrentStackIndex(), newStack);
	}

	public T pop() {
		T element = null;
		if (stacks.size() == 0) {
			throw new EmptyStackException();
		}

		SetOfStacksNode<T> currentStack = getCurrentStack();

		element = currentStack.getElement();

		if (currentStack.getCount() == 1) {
			stacks.remove(getCurrentStackIndex());
		} else {
			stacks.set(getCurrentStackIndex(), currentStack.getNext());
		}

		return element;
	}

	private boolean newStackNecessary() {
		return stacks.size() == 0 || getCurrentStack().getCount() > threshold;
	}

	private SetOfStacksNode<T> getCurrentStack() {
		return stacks.get(getCurrentStackIndex());
	}

	private int getCurrentStackIndex() {
		return stacks.size() - 1;
	}

	public static void main(String[] args) {
		SetOfStacks<Integer> setOfStacks = new SetOfStacks<Integer>();

		setOfStacks.push(1);
		setOfStacks.push(2);
		setOfStacks.push(3);
		setOfStacks.push(4);
		setOfStacks.push(5);
		setOfStacks.push(6);
		setOfStacks.push(7);
		setOfStacks.push(8);
		setOfStacks.push(9);
		setOfStacks.push(10);
		setOfStacks.push(11);
		setOfStacks.push(12);
		setOfStacks.push(13);

		setOfStacks.pop();
		setOfStacks.pop();
		setOfStacks.pop();
		setOfStacks.pop();
		setOfStacks.pop();
		setOfStacks.pop();
	}
}
