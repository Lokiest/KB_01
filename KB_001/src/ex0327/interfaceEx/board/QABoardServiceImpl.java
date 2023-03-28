package ex0327.interfaceEx.board;

import java.util.ArrayList;
import java.util.List;

public class QABoardServiceImpl implements BoardService {

	@Override
	public int insert(Board board) {
		System.out.println("QABoardServiceImpl의 insert call ");
		return 1;
	}

	@Override
	public boolean update(Board board) {
		System.out.println("QABoardServiceImpl의 update call ");
		return true;
	}

	@Override
	public Board selectByBno(int bno) {
		System.out.println("QABoardServiceImpl의 selectByBno call ");
		return new QABoard(bno, "fount_title", "fount_writer", "fount_content", true);
	}

	@Override
	public List<Board> selectAll() {
		System.out.println("QABoardServiceImpl의 selectAll call ");
		List<Board> list = new ArrayList<>();
		list.add(new QABoard(1, "title1", "writer1", "content1", true));
		list.add(new QABoard(2, "title2", "writer2", "content2", false));
		return list;
	}

}
