package action;

import dao.Order_Use;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/orderBatchDelete")
public class orderBatchDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids"); // 获取商品编号数组

        response.setContentType("text/plain;charset=UTF-8"); // 设置响应内容类型为纯文本
        PrintWriter out = response.getWriter(); // 获取输出流

        if (ids != null) {
            try {
                for (String id : ids) {
                    Order_Use.deleteOrder(Integer.parseInt(id)); // 调用删除方法并转换为整数
                }
                response.setStatus(HttpServletResponse.SC_OK); // 设置成功状态
                out.write("删除成功"); // 发送成功信息
            } catch (NumberFormatException e) {
                e.printStackTrace(); // 打印异常信息
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 请求参数错误
                out.write("无效的订单ID格式"); // 返回错误信息
            } catch (SQLException e) {
                e.printStackTrace(); // 打印异常信息
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 设置错误状态
                out.write("数据库错误: " + e.getMessage()); // 返回数据库错误信息
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 请求错误
            out.write("请求参数为空"); // 返回错误信息
        }

        out.close(); // 关闭输出流
    }
}
