package com.internousdev.craftdenki.action;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.craftdenki.dao.CartDAO;
import com.internousdev.craftdenki.dto.CartDTO;
import com.opensymphony.xwork2.ActionSupport;

public class CartAction extends ActionSupport implements SessionAware{

	private Map<String,Object> session;

	private ArrayList<CartDTO> cartList = new ArrayList<CartDTO>();
	private int product_id;
	private int product_count;
	private String price;
	private int finalPrice;
	private String userId;
	private String deleteFlg;
	private String insertFlg;
	private String message;

	private Collection<String> delete;
	private String productName;
	private String productNameKana;
	private String imageFilePath;
	private String productCount;
	private String releaseCompany;
	private String releaseDate;
	private String totalPrice;

	private String isFlg;




	public String execute()throws SQLException{
		String result=ERROR;

		if(isFlg!=null){
			deleteFlg="1";
		}

		CartDAO cartDAO = new CartDAO();

		//ログイン/未ログインでカートにInsertするIDを変更
		if(session.containsKey("trueID")){
			userId = session.get("trueID").toString();
		}else{
			userId = session.get("temp_user_id").toString();
		}


		//商品の追加
		if(insertFlg != null){
			cartDAO.insertCart(userId,product_id,product_count, Integer.parseInt(price));
		}


		System.out.println("INSERTFLG : " + insertFlg);
		System.out.println("DELETEFLG : " + deleteFlg);

		if(deleteFlg == null){

			//カート情報取得
			cartList = cartDAO.getCartInfo(userId);
			session.put("cartList", cartList);

			int size = cartList.size();
			for(int i=0; i<size; i++){
				finalPrice = finalPrice + cartList.get(i).getTotalPrice();
			}


		}else if(deleteFlg.equals("1")){

			//商品の削除
			for(String deleteId:delete){
				int res = cartDAO.deleteCart(userId,Integer.parseInt(deleteId));

				if(res > 0){
					setMessage("カート情報を削除しました。");
				}else if(res == 0){
					setMessage("カート情報の削除に失敗しました。");
				}
			}
		}

		result = SUCCESS;
		return result;
	}



	public String getIsFlg() {
		return isFlg;
	}



	public void setIsFlg(String isFlg) {
		this.isFlg = isFlg;
	}



	public void setCartList(ArrayList<CartDTO> cartList) {
		this.cartList = cartList;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public ArrayList<CartDTO> getCartList(){
		return this.cartList;
	}

	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public String getPrice() {
		return price;
	}



	public void setPrice(String price) {
		this.price = price;
	}



	public String getDeleteFlg() {
		return deleteFlg;
	}
	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;

	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public String getInsertFlg() {
		return insertFlg;
	}
	public void setInsertFlg(String insertFlg) {
		this.insertFlg = insertFlg;
	}

	public Collection<String> getDelete() {
		return delete;
	}
	public void setDelete(Collection<String> delete) {
		this.delete = delete;
	}


	public int getFinalPrice() {
		return finalPrice;
	}



	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}



	public String getUserId() {
		return userId;
	}



	public void setUserId(String userId) {
		this.userId = userId;
	}



	public String getProductName() {
		return productName;
	}



	public void setProductName(String productName) {
		this.productName = productName;
	}



	public String getProductNameKana() {
		return productNameKana;
	}



	public void setProductNameKana(String productNameKana) {
		this.productNameKana = productNameKana;
	}



	public String getImageFilePath() {
		return imageFilePath;
	}



	public void setImageFilePath(String imageFilePath) {
		this.imageFilePath = imageFilePath;
	}



	public String getProductCount() {
		return productCount;
	}



	public void setProductCount(String productCount) {
		this.productCount = productCount;
	}



	public String getReleaseCompany() {
		return releaseCompany;
	}



	public void setReleaseCompany(String releaseCompany) {
		this.releaseCompany = releaseCompany;
	}



	public String getReleaseDate() {
		return releaseDate;
	}



	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}



	public String getTotalPrice() {
		return totalPrice;
	}



	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}



	public Map<String, Object> getSession() {
		return session;
	}





}
