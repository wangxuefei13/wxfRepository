package com.crm.web.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class SysInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {


    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();




    }
}
