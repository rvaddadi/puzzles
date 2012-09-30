package node;

import java.util.HashSet;
import java.util.Set;

public class Node<T> {

	private T value;
	private Node<T> left;
	private Node<T> right;

	public Node(T value) {
		this.value = value;
		this.left = null;
		this.right = null;
	}

	public boolean isBalanced() {
		return isBalanced(new HashSet<Integer>(), 0);
	}

	private boolean isBalanced(Set<Integer> leafsDepths, int currentDepth) {

		currentDepth++;

		if (isLeaf()) {
			leafsDepths.add(currentDepth);
		}

		if (!checkLeafsDepths(leafsDepths)) {
			return false;
		}

		if (left != null && !left.isBalanced(leafsDepths, currentDepth)) {
			return false;
		}

		if (right != null && !right.isBalanced(leafsDepths, currentDepth)) {
			return false;
		}

		return true;
	}

	private boolean checkLeafsDepths(Set<Integer> leafsDepths) {
		int size = leafsDepths.size();
		Integer[] leafsDepthsArray = leafsDepths.toArray(new Integer[0]);

		return size < 2
				|| (size == 2 && Math.abs(leafsDepthsArray[0]
						- leafsDepthsArray[1]) == 1);
	}

	private boolean isLeaf() {
		return left == null && right == null;
	}

	public Node<T> getLeft() {
		return left;
	}

	public void setLeft(Node<T> left) {
		this.left = left;
	}

	public Node<T> getRight() {
		return right;
	}

	public void setRight(Node<T> right) {
		this.right = right;
	}

	public T getValue() {
		return value;
	}

	public static void main(String[] args) {
		Node<Integer> node1 = new Node<>(1);
		Node<Integer> node2 = new Node<>(2);
		Node<Integer> node3 = new Node<>(3);
		Node<Integer> node4 = new Node<>(4);
		Node<Integer> node5 = new Node<>(5);
		
		node1.isBalanced(); // true
		
		node1.setLeft(node2);

		node1.isBalanced(); // true
		
		node1.setRight(node3);

		node1.isBalanced(); // true

		node2.setLeft(node4);
		
		node1.isBalanced(); // true
		
		node2.setRight(node5);
		
		node1.isBalanced(); // true
		
		node4.setLeft(node5);
		
		node1.isBalanced(); // false
	}
}
