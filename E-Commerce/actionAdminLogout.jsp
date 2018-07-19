<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.setAttribute("sessionAdminEmail", null);
session.setAttribute("sessionAdminName", null);
response.sendRedirect("adminLoginSignup.jsp");
%>