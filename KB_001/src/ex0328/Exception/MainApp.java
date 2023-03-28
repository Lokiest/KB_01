package ex0328.Exception;

public class MainApp {
	
	public static void main(String[] args) {
		
		ShoppingMall sm = new ShoppingMall();
		
		for(int i=0;i<10;i++) {
			try {
				sm.AgeCut((int)(Math.random() * 55));
			} catch (Exception1 e) {
				String message = e.getMessage();
				System.out.println(message);
//				e.printStackTrace();
			}
	}
		
		System.out.println("exception : " + Exception1.count);
	}

}
