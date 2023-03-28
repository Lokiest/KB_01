package ex0328.Exception;

public class Exception1 extends Exception {
	
	static int count = 0;
	public Exception1() {
		count++;
	}
	
	public Exception1(String message) {
		super(message);
		count++;
	}
	
}