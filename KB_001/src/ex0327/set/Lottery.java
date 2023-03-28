package ex0327.set;

import java.util.Iterator;
import java.util.Random;
import java.util.TreeSet;

public class Lottery extends TreeSet<Integer> {
	
	public Lottery() {
		// 1~45 난수 발생해서 Set에 숫자 6개 저장
		Random rd = new Random();
		
		while(super.size() < 6) {
			int no = rd.nextInt(45) + 1;
			super.add(no);
		}
		
//		this.descendingIterator(); 내림차순
		System.out.println("saved number : " + this);
		
		Iterator<Integer> it = this.descendingIterator();
		while (it.hasNext()) {
			System.out.print(it.next() + ", ");
		}
		
	}
	
	public static void main(String[] args) {

		new Lottery();

	}

}
