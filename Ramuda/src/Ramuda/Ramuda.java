package Ramuda;

public class Ramuda {


	public static void main(String[] args){

		class Local{

			public void sayHello(){

				System.out.println("hello");
			}
		}

		Local local = new Local();
		local.sayHello();
	}
}