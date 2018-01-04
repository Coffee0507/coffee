package com.internousdev.sample.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UtilDate {

	public String getDate() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();

		return simpleDateFormat.format(date);
	}
}