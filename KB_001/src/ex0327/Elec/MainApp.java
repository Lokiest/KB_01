package ex0327.Elec;

import java.util.ArrayList;
import java.util.List;

public class MainApp {

	public static void main(String[] args) {
		// Tv 2대 , Audio 2대 저장하고 그 정보를 출력한다.
		List<ElectFunction> elec = new ArrayList<ElectFunction>();

		elec.add(new Tv("A01", 500000, 12));
		elec.add(new Tv("A02", 2500, 20));
		elec.add(new Tv("A03", 3000, 30));

		elec.add(new Audio("A04", 8500, 200));
		elec.add(new Audio("A05", 700, 100));

		for (ElectFunction e : elec) {
			 e.start();
			//System.out.println(e);
		}

	}
}
