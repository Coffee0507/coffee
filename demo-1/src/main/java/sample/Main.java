package sample;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Main{

	@RequestMapping
	public static void main(String[] args){

		ApplicationContext context = new ClassPathXmlApplicationContext("sample/applicationContext.xml");

		Person person = (Person)context.getBean("person");


		System.out.println(person.getplan());

	}
}