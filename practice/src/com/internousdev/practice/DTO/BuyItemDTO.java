package com.internousdev.practice.DTO;

public class BuyItemDTO {

	private String buyItemId;
	private String buyItemName;
	private String buyItemPrice;
	private String buyItemStock;

	public String getItemId() {
		return buyItemId;
	}
	public void setItemId(String buyItemId){
		this.buyItemId= buyItemId;
	}
	public String getItemName() {
		return buyItemName;
	}
	public void setItemName(String buyItemName) {
		this.buyItemName=buyItemName;
	}
	public String getItemPrice() {
		return buyItemPrice;
	}
	public void setItemPrice(String buyItemPrice) {
		this.buyItemPrice=buyItemPrice;
	}
	public String getItemStock() {
		return buyItemStock;
	}
	public void setItemStock(String buyItemStock) {
		this.buyItemStock=buyItemStock;
	}

}
