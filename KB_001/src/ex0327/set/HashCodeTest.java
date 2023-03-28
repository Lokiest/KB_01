package ex0327.set;

public class HashCodeTest {
	public static void main(String[] args) {
		String s="Z@S.ME";
		String s2="Z@RN.E";
		
//		String s = "java";
//		String s2 = "java";
		
		System.out.println(s.hashCode());
		System.out.println(s2.hashCode());
		
		if(s.equals(s2)) {
			System.out.println(" == ");
		} else {
			System.out.println(" != ");
		}

	}

}
