package com.internous.action;

import com.internous.service.TotalPriceService;

public class InternousMain {

	String numberD = "15";

	public static void main(String[] args) {

		String numberC = "10";

		TotalPriceService tps = new TotalPriceService();

		tps.getAddition(Untitled.numberA, Untitled.numberB);
		tps.getSubtraction(Untitled.numberA, Untitled.numberB);
		tps.getMultiplication(Untitled.numberA, Untitled.numberB);
		tps.getDivision(Untitled.numberA, Untitled.numberB);
		tps.getRemainder(Untitled.numberA, Untitled.numberB);

		System.out.println(Untitled.numberA);
		System.out.println(Untitled.numberB);
		System.out.println(numberC);

//フィールドがstaticではないため実行できない
//		System.out.println(numberD);

		Untitled u = new Untitled();
		System.out.println(Untitled.numberB);
		u.aaa();

		Untitled.bbb();
		Untitled.bbb();
		Untitled.bbb();
		Untitled.bbb();


		abc();
	}

	public static void abc(){
		System.out.println(Untitled.numberA);
//フィールドがstaticでないため実行できない
//		System.out.println(numberD);
//ローカルな変数ではないため実行できない
//		System.out.println(numberC);


		Untitled u = new Untitled();
		System.out.println(u.numberA+"bbb");
//再度uを定義しないと失敗する
	}
}
