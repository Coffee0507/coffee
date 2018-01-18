package com.internous.action;

import com.internous.service.NoTitleService;
import com.internous.util.NoTitleStatic;

public class NoTitleAction {

	public static void main(String[] args){

		String name1 = "enna";
		String name2 = "hiroki";
		NoTitleService nts = new NoTitleService();

		nts.getInfo(NoTitleStatic.name1, NoTitleStatic.name2, NoTitleStatic.number1, NoTitleStatic.number2);
		nts.getInfo2(name1, name2, NoTitleStatic.number3, NoTitleStatic.number4);

	}

}
