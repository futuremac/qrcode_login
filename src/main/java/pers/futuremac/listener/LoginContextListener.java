package pers.futuremac.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pers.futuremac.service.LoginService;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by 前程 on 2015/10/23.
 */
public class LoginContextListener implements ServletContextListener {

    private Logger logger = LoggerFactory.getLogger(LoginContextListener.class);
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        logger.info("initialize context!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        logger.info("destroy context!");
    }
}
