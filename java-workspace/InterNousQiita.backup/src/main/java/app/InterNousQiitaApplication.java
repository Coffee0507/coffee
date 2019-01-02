package app;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//@EnableAutoConfiguration
//@ComponentScan
@MapperScan("app.web.mapper")
public class InterNousQiitaApplication {

	public static void main(String[] args) {
		SpringApplication.run(InterNousQiitaApplication.class, args);
	}

}

