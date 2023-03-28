package ex0327.interfaceEx.board;

import java.util.ArrayList;
import java.util.List;

public class TestMainApp {
	
	BoardService service; // 필드를 이용한 다형성 
	Board board;
	
	public static void main(String[] args) {
		new TestMainApp();
	}
	
	public TestMainApp() {
		service = new QABoardServiceImpl();
		board = new QABoard(0, " ", "   ", "     ", false);
		this.test(service, board);
		
		System.out.println("----------------------------------");
		service = new FreeBoardImpl();
		board = new FreeBoard(1, "fount_title", "fount_writer", "fount_content");
		this.test(service, board);
		
		System.out.println("----------------------------------");
		service = new UploadBoardImpl();
		board = new UploadBoard(2, "title1", "writer1", "content1", "file1");
		this.test(service, board);
		
		////////////////////익명클래스 ///////////////
		service = new BoardService() {
			
			@Override
			public boolean update(Board board) {
				System.out.println("PhotoService update");
				return false;
			}
			
			@Override
			public Board selectByBno(int bno) {
				System.out.println("PhotoService selectBy");
				return null;
			}
			
			@Override
			public List<Board> selectAll() {
				System.out.println("PhotoService selectAll");
				return new ArrayList<>();
			}
			
			@Override
			public int insert(Board board) {
				System.out.println("PhotoService insert");
				return 0;
			}
		};
		
		this.test(service, board);
		
	}
	
	public void test(BoardService service, Board board) {
		
		service.insert(board);
		service.update(board);
		
		Board searchBoard = service.selectByBno(1);
		System.out.println("searchBoard = " + searchBoard);
		
		List<Board> list = service.selectAll();
		System.out.println("Records : " + list.size());
		for(Board b : list) {
			System.out.println(b);
		}
		
		System.out.println("=================== add method ============== ");
		service.replyInsert();
		BoardService.selectBySub();
		
	}

}
