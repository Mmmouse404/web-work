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
        res.setContentType("text/html;charset=utf-8"); // 防止切换后中文变成问号
        req.setCharacterEncoding("utf-8");

        String goodname = req.getParameter("goodname"); // 商品名字
        String kind = req.getParameter("kind"); // 类别
        String price = req.getParameter("price"); // 价格
        String stock = req.getParameter("stock"); // 库存
        String merchantname = req.getParameter("merchantname"); // 商家名称
        String description = req.getParameter("description");
        // 获取上传的文件
        Part filePart = req.getPart("image"); // "image" 是表单中文件选择框的 name
        String fileName = filePart.getSubmittedFileName(); // 获取文件名

        // 保存图片的路径
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads"; // 以商家名称创建文件夹
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // 创建目录（如果不存在）
        }
        res.getWriter().write(uploadDir.exists() + "<br>");
        // 将文件保存到指定路径
        String filePath = uploadPath + File.separator + fileName;
        res.getWriter().write("<h1>商品上传路径：</h1>"+filePath); // 返回结果
        try {
            filePart.write(filePath); // 保存上传的文件

            Goodlist gl = new Goodlist();
            gl.setGoodName(goodname);
            gl.setImage("uploads/"+ fileName); // 在数据库中存储相对路径
            gl.setKind(kind);
            gl.setPrice(price);
            gl.setStock(stock);
            gl.setMerchantName(merchantname);
            gl.setDescription(description);
            Goodlist_Use.insertGood(gl); // 商品插入


        } catch (SQLException e) {
            e.printStackTrace();
            res.getWriter().write("<h1>数据库错误：商品插入失败</h1>"); // 返回数据库错误信息
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            res.getWriter().write("<h1>错误：找不到类</h1>"); // 返回找不到类错误信息
        } catch (IOException e) {
            e.printStackTrace();
            res.getWriter().write("<h1>文件上传错误：无法保存文件</h1>"); // 返回文件上传错误信息
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("<h1>未处理的错误：请稍后再试</h1>"); // 返回未处理的错误信息
        }
    }
}
