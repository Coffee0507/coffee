package app.message;

import org.springframework.stereotype.Service;

@Service
public class Message {

	public final String message1(String str1, String str2) {
		return str1 + "か" + str2 + "が間違っています";
	}
}
