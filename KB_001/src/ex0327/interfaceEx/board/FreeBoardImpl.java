package ex0327.interfaceEx.board;

import java.util.ArrayList;
import java.util.List;

public class FreeBoardImpl implements BoardService {

	@Override
	public int insert(Board board) {
		System.out.println("FreeBoard의 insert call ");
		return 1;
	}

	@Override
	public boolean update(Board board) {
		System.out.println("FreeBoard의 update call ");
		return false;
	}

	@Override
	public Board selectByBno(int bno) {
		System.out.println("FreeBoard의 selectByBno call ");
		return new FreeBoard(bno, "fount_title", "fount_writer", "fount_content");
	}

	@Override
	public List<Board> selectAll() {
		List<Board> list = new ArrayList<>();
		list.add(new FreeBoard(1, "title1", "writer1", "content1"));
		return list;
	}
	
	@Override
	public int replyInsert() {
		System.out.println("FreeBoard replyInsert call ");
		return 1;
	}
}
