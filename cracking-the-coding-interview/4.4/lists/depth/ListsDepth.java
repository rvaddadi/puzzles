package lists.depth;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

class Node<T> {

	private T value;
	private Node<T> left;
	private Node<T> right;

	public Node(T value) {
		this.value = value;
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
}

public class ListsDepth {

	public static <T> ArrayList<LinkedList<Node<T>>> depthLists(Node<T> root) {
		ArrayList<LinkedList<Node<T>>> lists = new ArrayList<>();
		Stack<Node<T>> currentDepth = new Stack<>();
		Stack<Node<T>> nextDepth = new Stack<>();
		LinkedList<Node<T>> list;
		Node<T> currentNode;

		nextDepth.push(root);

		while (!nextDepth.isEmpty()) {
			while (!nextDepth.isEmpty()) {
				currentDepth.push(nextDepth.pop());
			}

			list = new LinkedList<>();

			while (!currentDepth.empty()) {
				currentNode = currentDepth.pop();
				list.add(currentNode);
				if (currentNode.getLeft() != null) {
					nextDepth.push(currentNode.getLeft());
				}
				if (currentNode.getRight() != null) {
					nextDepth.push(currentNode.getRight());
				}
			}

			lists.add(list);
		}

		return lists;
	}

	public static void main(String[] args) {
		Node<Integer> node1 = new Node<>(1);
		Node<Integer> node2 = new Node<>(2);
		Node<Integer> node3 = new Node<>(3);
		Node<Integer> node4 = new Node<>(4);
		Node<Integer> node5 = new Node<>(5);
		Node<Integer> node6 = new Node<>(6);

		node4.setLeft(node2);
		node4.setRight(node6);
		node2.setLeft(node1);
		node2.setRight(node3);
		node6.setLeft(node5);

		depthLists(node4);
	}
}
