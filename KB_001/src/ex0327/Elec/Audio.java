package ex0327.Elec;

public class Audio extends Elec implements ElectFunction {
	
	private int volumn;
	
	public Audio() {}
	public Audio(int volumn) {
		this.volumn = volumn;
	}
	public Audio(String code, int cost, int volumn) {
		super(code, cost);
		this.volumn = volumn;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Audio [volumn=");
		builder.append(volumn);
		builder.append(", toString()=");
		builder.append(super.toString());
		builder.append(", getCode()=");
		builder.append(getCode());
		builder.append(", getCost()=");
		builder.append(getCost());
		builder.append("]");
		return builder.toString();
	}
	
	@Override
	public void start() {
		System.out.println(this.getCode() + "제품 Adutio를 " + this.volumn + "으로 듣는다");
		
	}
	@Override
	public void stop() {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void display() {
		// TODO Auto-generated method stub
		
	}
	
	
	
}
