package subtree;

import java.util.LinkedList;
import java.util.Queue;

public class Tree<T> {

	private T value;
	private Tree<T> left;
	private Tree<T> right;

	public Tree(T value) {
		this.value = value;
	}

	public boolean isSubtree(Tree<T> search) {
		Queue<Tree<T>> queue = new LinkedList<>();
		Tree<T> subtree;

		queue.add(this);

		while (!queue.isEmpty()) {
			subtree = queue.remove();
			if (match(subtree, search)) {
				return true;
			}

			if (subtree.getLeft() != null) {
				queue.add(subtree.getLeft());
			}
			if (subtree.getRight() != null) {
				queue.add(subtree.getRight());
			}
		}

		return false;
	}

	private static <T> boolean match(Tree<T> subtree, Tree<T> search) {
		return search == null || (subtree != null &&
				subtree.getValue().equals(search.getValue()) &&
				match(subtree.getLeft(), search.getLeft()) &&
				match(subtree.getRight(), search.getRight())
				);
	}
	
	public static void main(String[] args) {
		Tree<Integer> tree2 = new Tree<>(2);
		Tree<Integer> tree3 = new Tree<>(3);
		Tree<Integer> tree7 = new Tree<>(7);
		Tree<Integer> tree5 = new Tree<>(5);
		Tree<Integer> tree6 = new Tree<>(6);
		Tree<Integer> tree12 = new Tree<>(12);
		Tree<Integer> tree15 = new Tree<>(15);
		Tree<Integer> tree3_2 = new Tree<>(3);
		Tree<Integer> tree2_2 = new Tree<>(2);
		Tree<Integer> tree1 = new Tree<>(1);

		tree2.setLeft(tree3);
		tree2.setRight(tree7);
		
		tree3.setLeft(tree5);
		tree3.setRight(tree6);
		
		tree7.setLeft(tree12);
		tree7.setRight(tree15);
		
		tree15.setLeft(tree3_2);
		
		tree3_2.setLeft(tree2_2);
		tree3_2.setRight(tree1);
		

		tree2.isSubtree(tree3_2);
	}

	public Tree<T> getLeft() {
		return left;
	}

	public void setLeft(Tree<T> left) {
		this.left = left;
	}

	public Tree<T> getRight() {
		return right;
	}

	public void setRight(Tree<T> right) {
		this.right = right;
	}

	public T getValue() {
		return value;
	}
}
