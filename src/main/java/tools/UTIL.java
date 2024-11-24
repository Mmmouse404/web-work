package tools;

// 数据库有关的包
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class UTIL {
    public static Connection getCon() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // 更改为 MySQL 驱动类
            try {
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shop?useSSL=false&serverTimezone=UTC", // 更改为 MySQL URL
                        "root", // 替换为你的 MySQL 用户名
                        "123456" // 替换为你的 MySQL 密码
                );
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) {
        System.out.println(getCon());
    }
}
