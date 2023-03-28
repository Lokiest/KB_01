package ex0327.set;

import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

public class SetExam {
	
//	Set<Integer> set = new HashSet<>();
	Set<Integer> set = new TreeSet<>();
	public SetExam(String [] args) {
		// set 숫자를 추가
		for(String s : args) {
			boolean result = set.add(Integer.parseInt(s));
			System.out.println(s + " additional reuslt : " + result);
		}	
		
		System.out.println("saved : " + set.size());
		
		//iterator interface는 모든 자료구조 안에 저장된 데이터를 추출할 때 사용하는 표준화된 인터페이스
		Iterator<Integer> it = set.iterator();
		while(it.hasNext()) { //요소 존재할 경우
			int no = it.next(); //요소 꺼내기
			System.out.println(no);
		}
		
		System.out.println("=====개선된 for ===== ");
		for(int no : set) {
			System.out.println(no);
		}
		
		//remove
		set.remove(30);
		System.out.println(" after delete=================" + set);
		
	}
	
	public static void main(String[] args) {
		System.out.println(" args = " + args);
		System.out.println(" args.lenth = " + args.length);
		new SetExam(args);

	}

}
