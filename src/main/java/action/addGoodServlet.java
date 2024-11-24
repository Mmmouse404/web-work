package action;

import dao.Goodlist;
import dao.Goodlist_Use;

import java.io.File;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ishop")
@MultipartConfig // 启用文件上传支持
public class addGoodServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=utf-8");    //防止切换后中文变成问号
        req.setCharacterEncoding("utf-8");
        String id=req.getParameter("id");    //商品编号
        String goodname= req.getParameter("goodname");    //商品名字
        //String image= req.getParameter("image");           //图片
        String kind=req.getParameter("kind"); //类别
        String price=req.getParameter("price");  //价格
        String stock= req.getParameter("stock");     //库存
        // 获取上传的文件
        Part filePart = req.getPart("image"); // "image" 是表单中文件选择框的 name
        String fileName = filePart.getSubmittedFileName(); // 获取文件名
        // 指定文件保存的路径
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // 创建目录（如果不存在）
        }

        // 将文件保存到指定路径
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath); // 保存上传的文件

        Goodlist gl=new Goodlist();
        gl.setId(id);
        gl.setGoodName(goodname);
        gl.setImage("uploads/" + fileName); // 在数据库中存储相对路径
        gl.setKind(kind);
        gl.setPrice(price);
        gl.setStock(stock);

        try {
            Goodlist_Use.insertGood(gl);   //商品插入
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // 可以选择在这里重定向或返回成功消息
        res.getWriter().write("<h1>商品上架成功！</h1>"); // 返回结果
    }
}
