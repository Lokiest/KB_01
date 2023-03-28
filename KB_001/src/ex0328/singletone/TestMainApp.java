package ex0328.singletone;

class Test {
	static Test instance = new Test();
	
	private Test() {
		
	}
	
	//현재 객체내에서 자신을 생성해서 리턴해주는 메소드를 제공
	public static Test getInstance() {
//		Test instance = new Test();
		return instance;
	}
	
}

public class TestMainApp {

	public static void main(String[] args) {

//		new Test();
		Test t1 = Test.getInstance();
		Test t2 = Test.getInstance();
		Test t3 = Test.getInstance();
		
		System.out.println("t1 = " + t1);
		System.out.println("t2 = " + t2);
		System.out.println("t3 = " + t3);

	}

}
