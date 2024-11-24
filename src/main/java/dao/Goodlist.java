package dao;

public class Goodlist {
    String id;           //商品编号
    String goodname;         //商品名字
    String image;       //商品图片
    String kind;       //商品类别
    String price;        //商品价格
    String stock;        //库存
    String merchantName;
    public String getId() {return id;}

    public void setId(String id) {
        this.id = id;
    }

    public String getGoodName() {
        return goodname;
    }

    public void setGoodName(String name) {
        this.goodname = name;
    }

    public String getImage() {return image;}

    public void setImage(String image) {
        this.image = image;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public String getMerchantName() {return merchantName;}

    public void setMerchantName(String merchantName) {this.merchantName = merchantName;}
}
