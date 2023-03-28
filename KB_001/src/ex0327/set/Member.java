package ex0327.set;

public class Member {
	private String name;
	private int age;
	private String addr;
	
	public Member() {}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Member [name=");
		builder.append(name);
		builder.append(", age=");
		builder.append(age);
		builder.append(", addr=");
		builder.append(addr);
		builder.append("]");
		return builder.toString();
	}

	public Member(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		System.out.println("member's hascode() call - age " + age);
//		return super.hashCode();
		return name.hashCode() + age;
	}
	
	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		System.out.println("member's equals() call - age " + age);
//		return super.equals(obj);
		if (obj instanceof Member) {
			Member m = (Member)obj;
			
			if(name.equals(m.getName()) && age == m.getAge()) {
				return true;
			}
		}
		
		return false;
	}
	
}
