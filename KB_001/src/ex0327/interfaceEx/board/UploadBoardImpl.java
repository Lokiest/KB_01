package ex0327.interfaceEx.board;

import java.util.ArrayList;
import java.util.List;

public class UploadBoardImpl implements BoardService {

	@Override
	public int insert(Board board) {
		System.out.println("UPloadBoardImpl의 insert call ");
		return 1;
	}

	@Override
	public boolean update(Board board) {
		System.out.println("UPloadBoardImpl의 update call ");
		return true;
	}

	@Override
	public Board selectByBno(int bno) {
		System.out.println("UPloadBoardImpl의 selectByBno call ");
		return new UploadBoard(bno, "fount_title", "fount_writer", "fount_content", "1234");
	}

	@Override
	public List<Board> selectAll() {
		List<Board> list = new ArrayList<>();
		list.add(new UploadBoard(1, "title1", "writer1", "content1", "file1"));
		list.add(new UploadBoard(2, "title2", "writer2", "content2", "file2"));
		list.add(new UploadBoard(3, "title3", "writer3", "content3", "file3"));
		return list;
	}

}
