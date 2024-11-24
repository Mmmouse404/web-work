package action;

import dao.Merchant_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/merchantRegister")
public class merchantRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8"); // 防止切换后中文变成问号
        request.setCharacterEncoding("utf-8");
        String merchantName = request.getParameter("merchantName");
        String id = request.getParameter("merchantID"); // 根据新的注册表单改为merchantID
        String password = request.getParameter("password");
        PrintWriter out = response.getWriter(); // 可以把信息输出给客户端界面
        HttpSession session = request.getSession();

        try {
            if (!Merchant_Use.selectId(id)) {  // 如果不存在相同的id
                if (!Merchant_Use.checkMerchantByName(merchantName)) { // 如果商家名称不存在
                    Merchant_Use.register(merchantName, password);
                    session.setAttribute("merchantName", merchantName); // 定义全局变量名
                    response.sendRedirect("registersucc.jsp");
                } else { // 商家名称已存在
                    out.println("<script>alert('注册失败！已存在该商家名称');</script>");
                    response.setHeader("refresh", "3;url=register.jsp");
                }
            } else { // 存在了相同的id
                out.println("<script>alert('注册失败！已存在该商家账号');</script>");
                response.setHeader("refresh", "3;url=register.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('操作数据库发生错误');</script>");
            response.setHeader("refresh", "3;url=register.jsp");
        } finally {
            out.close(); // 关闭输出流
        }
    }
}
