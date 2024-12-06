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

@WebServlet("/updateGood")
@MultipartConfig // 启用文件上传支持
public class updateGoodServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=utf-8"); // 防止切换后中文变成问号
        req.setCharacterEncoding("utf-8");

        String id = req.getParameter("id"); // 商品ID
        String goodname = req.getParameter("goodname"); // 商品名字
        String kind = req.getParameter("kind"); // 类别
        String price = req.getParameter("price"); // 价格
        String stock = req.getParameter("stock"); // 库存
        String merchantname = req.getParameter("merchantname"); // 商家名称
        String description = req.getParameter("description");
        // 获取上传的文件
        Part filePart = req.getPart("image"); // "image" 是表单中文件选择框的 name
        String fileName = filePart.getSubmittedFileName(); // 获取文件名

        String filePath; // 文件路径
        if (fileName != null && !fileName.isEmpty()) {
            // 保存图片的路径
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads"; // 文件上传路径
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // 创建目录（如果不存在）
            }
            filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // 保存上传的文件
            filePath = "uploads/" + fileName; // 在数据库中存储相对路径
        } else {
            // 如果没有上传新图片，保持原来的图片路径
            Goodlist existingGood;
            try {
                existingGood = Goodlist_Use.searchGoodById(id);
                filePath = existingGood.getImage(); // 保持原来的图片路径
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        try {
            // 创建 Goodlist 对象
            Goodlist gl = new Goodlist();
            gl.setId(id); // 设置商品ID
            gl.setGoodName(goodname);
            gl.setImage(filePath); // 更新图片路径
            gl.setKind(kind);
            gl.setPrice(price);
            gl.setStock(stock);
            gl.setMerchantName(merchantname);
            gl.setDescription(description);
            // 执行更新操作
            Goodlist_Use.updateGood(gl); // 调用 Goodlist_Use.UpdateGood 方法

            res.getWriter().write("<h1>商品修改成功！</h1>"); // 返回成功消息
        } catch (SQLException e) {
            e.printStackTrace();
            res.getWriter().write("<h1>数据库错误：商品修改失败</h1>"); // 返回数据库错误信息
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
