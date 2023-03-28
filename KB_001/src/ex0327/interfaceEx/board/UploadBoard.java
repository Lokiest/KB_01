package ex0327.interfaceEx.board;

public class UploadBoard extends Board {
	
	private String filename;

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public UploadBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UploadBoard(int bno, String subject, String writer, String content, String filename) {
		super(bno, subject, writer, content);
		// TODO Auto-generated constructor stub
		this.filename = filename;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("UploadBoard [filename=");
		builder.append(filename);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
