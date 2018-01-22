package com.internousdev.sample.DTO;

public class MyPageDTO {

	public boolean deleteFlg = false;
	private String itemName;
	private String itemPrice;
	private String itemStock;
	private String itemPay;
	private String itemId;
	private boolean myPageFlg;

	public String getItemId(){
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Object getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
	}

	public Object getItemStock() {
		return itemStock;
	}

	public void setItemStock(String itemStock) {
		this.itemStock = itemStock;
	}

	public Object getItemPay() {
		return itemPay;
	}

	public void setItemPay(String itemPay) {
		this.itemPay = itemPay;
	}

	public boolean getMyPageFlg() {
		return myPageFlg;
	}

	public void setMyPageFlg(boolean myPageFlg) {
		this.myPageFlg = myPageFlg;
	}

}
