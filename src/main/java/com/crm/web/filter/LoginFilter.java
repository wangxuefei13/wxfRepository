package com.crm.web.filter;

import com.crm.entity.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(true);

        String url = request.getRequestURI();
        User user = (User) session.getAttribute("user");
        if("/login".equals(url)){
            chain.doFilter(request, response);
        }else if (user == null && url.indexOf("login.jsp") == -1) {
            String location = "/login.jsp";
            request.getRequestDispatcher(location).forward(request, response);
        } else{
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}