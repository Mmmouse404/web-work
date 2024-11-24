package action;

import dao.User_Use;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/upwin")
public class loginServlet extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("text/html;charset=utf-8");    //防止切换后中文变成问号
        req.setCharacterEncoding("utf-8");
        String upid=req.getParameter("upid");          //id变量
        String uppass=req.getParameter("uppass");      //密码变量
        String name= null;
        HttpSession session = req.getSession();
        session.setAttribute("upname",name);
        try {
            name = User_Use.returnname(upid);    //查询id对应的账号名
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        try {
            if(User_Use.selectId(upid)){//如果id存在
                if(User_Use.selectPass(uppass)){ //密码匹配
                    System.out.println("1");
                    session.setAttribute("upname",name );   //定义全局变量名
                    session.setAttribute("userType", "user");
                    res.sendRedirect("loginSuccess.jsp");  //重定向页面
                }
                else{//id与密码不匹配
                    System.out.println("2");
                    String error1="用户:"+name+" 密码输入错误";
                    session.setAttribute("upname",error1);
                    res.sendRedirect("loginFail.jsp");  //重定向页面
                }
            }

            else{
                String error2="该id未注册";
                session.setAttribute("upname",error2);
                res.sendRedirect("loginFail.jsp");  //重定向页面
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
