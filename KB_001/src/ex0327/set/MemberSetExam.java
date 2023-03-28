package ex0327.set;

import java.util.HashSet;
import java.util.Set;

public class MemberSetExam {
	private Set<Member> set = new HashSet<>();
	
	public MemberSetExam() {
		//3 saved
		/**
		 * set의 중복 체크 :
		 * 	먼저 hashCode() 메소드 호출해서 다르면 다른 객체로 인식
		 * 	hashCode() 같으면 equals() 메소드 호출해서 true > 같은 객체, false > 다른 객체
		 */
		set.add(new Member("park", 10, "seoul"));
		System.out.println("\n =====================");
		
		set.add(new Member("park", 20, "busan"));
		System.out.println("\n =====================");
		
		set.add(new Member("lee", 30, "jeju"));
		
		System.out.println("saved : " + set.size());
	}
	
	public static void main(String[] args) {

		new MemberSetExam();

	}

}
