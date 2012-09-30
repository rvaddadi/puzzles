import java.util.Stack;


public class MyQueue<T> {

	private Stack<T> enqueueStack = new Stack<>();
	private Stack<T> dequeueStack = new Stack<>();
	
	public void enqueue(T item) {
		swap(dequeueStack, enqueueStack);
		
		enqueueStack.push(item);
	}
	
	public T dequeue() {
		swap(enqueueStack, dequeueStack);
		
		return dequeueStack.pop();
	}

	private void swap(Stack<T> fromStack, Stack<T> toStack) {
		while ( ! fromStack.empty()) {
			toStack.push(fromStack.pop());
		}
	}
	
	public static void main(String[] args) {
		MyQueue<Integer> myQueue = new MyQueue<Integer>();
		
		myQueue.enqueue(1);
		myQueue.enqueue(2);
		myQueue.enqueue(3);
		myQueue.enqueue(4);
		myQueue.enqueue(5);

		myQueue.dequeue();
		myQueue.dequeue();
		myQueue.dequeue();
		myQueue.dequeue();
	}
}
