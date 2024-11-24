package dao;

public class Order {
    int id;          //订单编号，自增长
    String goodname;    //商品名字
    String username;    //用户名字
    String address;     //地址
    int number;    //数量
    String price;   //价格总和
    String merchantname;
    public String getAddress() {
        return address;
    }

    public void setAddress(String add) {
        this.address = add;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGoodName() {
        return goodname;
    }

    public void setGoodName(String goodname) {
        this.goodname = goodname;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {this.price = price;}

    public String getMerchantName() {return merchantname;}

    public void setMerchantName(String merchantname) {this.merchantname = merchantname;}
}
