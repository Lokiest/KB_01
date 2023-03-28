package ex0327.Elec;

public class Tv extends Elec implements ElectFunction {
	
	private int channel;
	
	public Tv() {}
	public Tv(int channel) {
		this.channel = channel;
	}
	public Tv(String code, int cost, int channel) {
		super(code, cost);
		this.channel = channel;
	}
	
	@Override
	public void start() {
		System.out.println(this.getCode() + "제품 TV를 " + this.channel + "을 본다");
	}
	
	@Override
	public void stop() {
		System.out.println();
	}
	
	@Override
	public void display() {
		System.out.println();
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Tv [channel=");
		builder.append(channel);
		builder.append(", toString()=");
		builder.append(super.toString());
		builder.append(", getCode()=");
		builder.append(getCode());
		builder.append(", getCost()=");
		builder.append(getCost());
		builder.append(", getClass()=");
		builder.append("]");
		return builder.toString();
	}
	
	
}
