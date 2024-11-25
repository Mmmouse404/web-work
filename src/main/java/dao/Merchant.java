package dao;

public class Merchant {
    private int id;           // 商家ID
    private String merchantname; // 商家名称
    private String password;  // 密码

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getmerchantname() {
        return merchantname;
    }

    public void setmerchantname(String merchantname) {
        this.merchantname = merchantname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
