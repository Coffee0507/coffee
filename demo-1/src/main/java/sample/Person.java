package sample;

public class Person{

	Car car = null;

	public void setCar(Car car){
		this.car = car;
	}

	public String getplan() {
		String msg = car.drive();
		return "明日の予定は"+msg;
	}



}