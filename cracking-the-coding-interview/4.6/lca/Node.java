package lca;

public class Node<T> {

	private T value;
	private Node<T> left;
	private Node<T> right;

	public Node(T value) {
		this.value = value;
	}

	public boolean isAncestor(Node<T> child) {
		return child != null
				&& (this == child || (left != null && left.isAncestor(child)) || (right != null && right
						.isAncestor(child)));
	}

	public boolean isCommonAncestor(Node<T> child1, Node<T> child2) {
		return isAncestor(child1) && isAncestor(child2);
	}

	public boolean isLca(Node<T> child1, Node<T> child2) {
		return isCommonAncestor(child1, child2)
				&& (left == null || !left.isCommonAncestor(child1, child2))
				&& (right == null || !right.isCommonAncestor(child1, child2));
	}

	public Node<T> lca(Node<T> child1, Node<T> child2) {
		if (isLca(child1, child2)) {
			return this;
		}
		if (left != null && left.isCommonAncestor(child1, child2)) {
			return left.lca(child1, child2);
		}
		if (right != null && right.isCommonAncestor(child1, child2)) {
			return right.lca(child1, child2);
		}

		return null;
	}

	public static void main(String[] args) {
		Node<Integer> node1 = new Node<>(1);
		Node<Integer> node2 = new Node<>(2);
		Node<Integer> node3 = new Node<>(3);
		Node<Integer> node4 = new Node<>(4);
		Node<Integer> node5 = new Node<>(5);
		Node<Integer> node6 = new Node<>(6);
		Node<Integer> node7 = new Node<>(7);

		node4.setLeft(node3);
		node4.setRight(node6);

		node3.setLeft(node1);
		node3.setRight(node2);

		node6.setLeft(node5);
		node6.setRight(node7);

		node4.lca(node4, node4);

		node4.lca(node3, node6);

		node4.lca(node2, node4);

		node4.lca(node1, node2);

		node4.lca(node1, node7);
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
