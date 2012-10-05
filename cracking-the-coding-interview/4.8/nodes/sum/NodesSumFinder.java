package nodes.sum;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Node {

	private int value;
	private Node left;
	private Node right;

	public Node(int value) {
		this.value = value;
	}

	public Node getLeft() {
		return left;
	}

	public void setLeft(Node left) {
		this.left = left;
	}

	public Node getRight() {
		return right;
	}

	public void setRight(Node right) {
		this.right = right;
	}

	public int getValue() {
		return value;
	}
}

class NodesSum {

	private List<Node> nodes;
	private int sum;

	public NodesSum(List<Node> nodes, int sum) {
		this.nodes = nodes;
		this.sum = sum;
	}

	public List<Node> getNodes() {
		return nodes;
	}

	public int getSum() {
		return sum;
	}
}

class ComposedNode {

	private Node node;
	private List<NodesSum> nodesSums;

	public ComposedNode(Node node, List<NodesSum> nodesSums) {
		this.node = node;
		this.nodesSums = nodesSums;
	}

	public Node getNode() {
		return node;
	}

	public List<NodesSum> getNodesSums() {
		return nodesSums;
	}
}

public class NodesSumFinder {

	public List<List<Node>> findSums(Node root, int sum) {
		List<List<Node>> result = new ArrayList<>();
		Queue<ComposedNode> queue = new LinkedList<>();
		ComposedNode currentNode;

		queue.add(composeNode(root, new ArrayList<NodesSum>()));

		while (!queue.isEmpty()) {
			currentNode = queue.remove();

			for (NodesSum nodesSum : currentNode.getNodesSums()) {
				if (nodesSum.getSum() == sum) {
					result.add(nodesSum.getNodes());
				}
			}

			if (currentNode.getNode().getLeft() != null) {
				queue.add(composeNode(currentNode.getNode().getLeft(),
						currentNode.getNodesSums()));
			}

			if (currentNode.getNode().getRight() != null) {
				queue.add(composeNode(currentNode.getNode().getRight(),
						currentNode.getNodesSums()));
			}
		}

		return result;
	}

	private ComposedNode composeNode(Node node, List<NodesSum> nodesSums) {
		List<NodesSum> newNodesSums;
		List<Node> nodes;

		newNodesSums = new ArrayList<>();
		nodes = new ArrayList<>();

		nodes.add(node);

		newNodesSums.add(new NodesSum(nodes, node.getValue()));

		for (NodesSum nodesSum : nodesSums) {
			nodes = new ArrayList<>();
			for (Node tempNode : nodesSum.getNodes()) {
				nodes.add(tempNode);
			}
			nodes.add(node);
			newNodesSums.add(new NodesSum(nodes, nodesSum.getSum()
					+ node.getValue()));
		}

		return new ComposedNode(node, newNodesSums);
	}

	public static void main(String[] args) {
		NodesSumFinder nodesSumFinder = new NodesSumFinder();

		Node node1 = new Node(1);
		Node node2 = new Node(2);
		Node node3 = new Node(3);
		Node node4 = new Node(4);

		node3.setLeft(node2);
		node3.setRight(node1);
		node1.setRight(node4);

		nodesSumFinder.findSums(node3, 5);
	}
}
