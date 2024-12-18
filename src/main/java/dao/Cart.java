package dao;

public class Cart {
    int id;
    String goodname;    //商品名字
    String username;    //用户名字
    String address;     //地址
    int number;    //数量
    String price;   //价格总和
    String merchantname;

    public int getId(){return id;}
    public String getIdString(){return String.valueOf(id);}
    public void setId(int id){this.id = id;}

    public String getAddress() {
        return address;
    }

    public void setAddress(String add) {
        this.address = add;
    }

    public String getGoodName() {
        return goodname;
    }

    public void setGoodName(String goodname) {this.goodname = goodname;}

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

    public String getmerchantname() {return merchantname;}

    public void setmerchantname(String merchantname) {this.merchantname = merchantname;}

}
