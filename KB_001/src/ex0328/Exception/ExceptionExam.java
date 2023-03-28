package ex0328.Exception;

public class ExceptionExam {
	
	public void aa(String [] args) throws Exception {
		System.out.println("aa method start");
		try {
			String str = args[0];
			System.out.println("pass value : " + str);
			
			int no = Integer.parseInt(str);
			System.out.println("replaced : " + no);
			
			this.bb(no);
			
			int result = 100 / no;
			System.out.println("result = " + result);
			
			//catch 작성할때 반드시 서브클래스부터 작성
		} catch(ArrayIndexOutOfBoundsException e) {
			//error occur
			System.out.println("e = " + e); //e,toString() : 예외 클래스 예외 메세지
		} catch(NumberFormatException e) {
			System.out.println("only Number = " + e.getMessage());
//		} catch(Exception e) {
//			//개발할때 예외가 발생하면 예외에 대한 정보를 정확하게 추적할 수 있는 정보 제공
//			//배포할때 반드시 제거해야
//			e.printStackTrace(); 
//			//예외메세지를 stack 저장하고 stack에 저장된 메세지 꺼내서 출력
//		}
		}
		
		System.out.println("aa method over");
	}

	public void bb(int i) throws Exception {
		try {
			System.out.println("bb method start");
			if(i>10) {
				//강제로 예외 발생시키기
				throw new Exception("less than 10");// > 예외처리 필요
				// > 메소드 선언부에 작성해야
//				throw new RuntimeException("less than 10");
			}
			
			int re = 100 / i;
			System.out.println(" / result in bb : " + re);
		} finally {
			System.out.println("bb method over Finally");
		}
	}
	
	public static void main(String[] args) throws Exception {
		System.out.println("Main start");
		ExceptionExam exam = new ExceptionExam();
		exam.aa(args);
		
		System.out.println("Main over");

	}

}
