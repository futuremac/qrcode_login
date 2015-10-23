package pers.futuremac.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by 前程 on 2015/10/23.
 */
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1918606793729085336L;
    private Logger logger = LoggerFactory.getLogger(LoginService.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        PrintWriter writer = resp.getWriter();
        String reqURI = req.getRequestURI();

        logger.info("request url:{}",req.getRequestURL().toString());
        if(reqURI.endsWith("getscanlogin")){
            String uid = req.getParameter("uid");
            ServletContext sc = this.getServletContext();
            if(sc.getAttribute(uid) != null){
                writer.write(sc.getAttribute(uid).toString());
            }else{
                writer.write("null");
            }
        }
        else if(reqURI.endsWith("setscanlogin")){
            writer.write(req.getQueryString());
        }else{
            writer.write("hello world! get request!");
            logger.info("invalid request!");
        }
        writer.flush();
        writer.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        PrintWriter writer = resp.getWriter();
        String reqURI = req.getRequestURI();

        logger.info("request url:{}",req.getRequestURL().toString());
        if(reqURI.endsWith("setscanlogin")) {
            String info = req.getParameter("info");
            String uid = req.getParameter("uid");

            ServletContext sc = this.getServletContext();
            sc.setAttribute(uid,info);
            writer.write("true");
            logger.info("set login, id:{}, info:{}",uid,info);
        }else{
            writer.write("bad request!");
        }
    }
}
