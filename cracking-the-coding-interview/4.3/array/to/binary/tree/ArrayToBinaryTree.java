package array.to.binary.tree;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

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

public class ArrayToBinaryTree {

	public static <T> Node<T> convert(List<T> array) {
		Iterator<T> i = array.iterator();
		Node<T> newLeftNode;
		Node<T> newRightNode;
		Node<T> currentNode;
		Node<T> root = null;
		Queue<Node<T>> queue = new LinkedList<>();

		while (i.hasNext()) {
			newLeftNode = new Node<>(i.next());

			if (queue.isEmpty()) {
				root = newLeftNode;
				queue.add(root);
			} else {
				currentNode = queue.remove();
				currentNode.setLeft(newLeftNode);
				queue.add(newLeftNode);

				if (i.hasNext()) {
					newRightNode = new Node<>(i.next());
					currentNode.setRight(newRightNode);
					queue.add(newRightNode);
				}
			}
		}

		return root;
	}

	public static void main(String[] args) {
		convert(new ArrayList<Integer>() {
			private static final long serialVersionUID = 1799242814083026542L;

			{
				add(1);
				add(2);
				add(3);
				add(4);
				add(5);
				add(6);
			}
		});
	}
}
