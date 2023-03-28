package ex0327.interfaceEx.board;

import java.util.List;

public interface BoardService {
	
	//등록하기 : 0 >> 실패, 1 >> 성공
	int insert(Board board);
	
	//update
	boolean update(Board board);
	
	//글번호에 해당하는 게시물 조회
	Board selectByBno(int bno);
	
	//전체게시글 조회
	List<Board> selectAll();
	
	
	///////////////////////////////////////////
	/**
	 * java 1.8version 추가 문법 : interface 안에 있는 메소드에 static or default 메소드를
	 * 							만들 수 있고 static or default가 선언되면
	 * 							body 있는 메소드가 됨
	 * 			이유 - 유지보수할 때 특정 구현 객체에만 사용해야하는 메소드가 있을 때
	 * 					인터페이스에 추가하면 필요없는 이미 구현된 모든 구현 객체들이
	 * 					재정의해야하는 번거로움이 존재 >> 이미 구현된 상태에서 특정 구현객체만
	 * 					필요한 메소드가 있다면 static or default를 만들고 필요한 구현 클래스에서만
	 * 					재정의하도록 하는 것, 모든 구현 객체들이 공통적으로 사용하는 기능이 정해져있다면
	 * 					static or default로 만들어서 재정의없이 사용
	 * 
	 * 		1) static method : 
	 * 			구현 객체 없이 바로 인터페이스이름.메소드이름 () 호출 가능
	 * 		2) default method : 
	 * 			반드시 구현 객체가 있어야 호출 가능
	 * 
	 */
	
	//답변기능 메소드 추가
	default int replyInsert() {
		System.out.println("BoardService replyinsert call ");
		return 1;
	}
	
	static Board selectBySub() {
		System.out.println("BoardService selectBySub call ");
		return null;
	}
	
}
