package dao;

public class User {
    int id;      //账号
    String name;  //用户名
    String password;  //密码
    double money;
    String email;  //邮箱
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public double getMoney() {return money;}

    public void setMoney(double money) {
        this.money = money;
    }

    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }

}
