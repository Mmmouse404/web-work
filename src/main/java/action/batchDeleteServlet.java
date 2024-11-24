package action;

import dao.Goodlist_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/batchDelete")
public class batchDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids"); // 获取商品编号数组

        if (ids != null) {
            try {
                for (String id : ids) {
                    Goodlist_Use.deleteGood(id); // 调用删除方法
                }
                response.setStatus(HttpServletResponse.SC_OK); // 设置成功状态
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 设置错误状态
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 请求错误
        }
    }
}
