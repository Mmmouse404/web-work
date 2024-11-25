package action;

import dao.Merchant_Use;
import dao.User_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/merchantLogin")
public class merchantLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String merchantID = request.getParameter("merchantID"); // 读取商家 ID
        String password = request.getParameter("password");
        String merchantname= null;
        HttpSession session = request.getSession();
        session.setAttribute("merchantname",merchantname);
        try {
            merchantname = Merchant_Use.returnname(merchantID);    //查询id对应的账号名
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        try {
            if (Merchant_Use.validateLoginById(merchantID, password)) { // 新方法：通过 ID 验证登录

                session.setAttribute("merchantID", merchantID);
                session.setAttribute("userType", "merchant");
                session.setAttribute("merchantname", merchantname);
                response.sendRedirect("loginSuccess.jsp");
            } else {
                response.sendRedirect("loginFail.jsp?msg=账号或密码错误");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("loginFail.jsp?msg=登录失败，请重试");
        }
    }
}
