package action;

import dao.User_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/loginwin")
public class registerServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException {
        res.setContentType("text/html;charset=utf-8");    //防止切换后中文变成问号
        req.setCharacterEncoding("utf-8");
        String loginname=req.getParameter("loginname");
        String loginid=req.getParameter("loginid");
        String loginpass=req.getParameter("loginpass");
        PrintWriter p=res.getWriter();//可以把信息输出给客户端界面

        HttpSession session = req.getSession();
        try {

            if(!User_Use.selectId(loginid)){  //如果不存在相同的id
                if(!User_Use.selectName(loginname)) {   //不存在相同的账号名
                    User_Use.in(loginname,loginid,loginpass,0);
                    session.setAttribute("loginname", loginname);   //定义全局变量名
                    res.sendRedirect("registersucc.jsp");
                }
                else{   //存在相同的账号名
                    p.println("注册失败！已存在该账号名");
                    res.setHeader("refresh","3;http://localhost:8080/javaweb_mouse_war_exploded/register.jsp");
                }
            }
            else{//存在了相同的id
                p.println("注册失败！已存在该账号");
                res.setHeader("refresh","3;http://localhost:8080/javaweb_mouse_war_exploded/register.jsp");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            p.println("操作数据库发生错误");
        }

    }
}
