package ex0328.Exception;

public class ShoppingMall {
	
	public int AgeCut(int age) throws Exception1 {
		if(age > 18) {
			System.out.println("입장하신걸 환영합니다");
		} else {
			throw new Exception1("애들은 가라");
		}
		return age;
	}
	
}
