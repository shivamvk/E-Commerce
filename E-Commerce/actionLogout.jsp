<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%
		session.setAttribute("sessionEmail", null);
		session.setAttribute("sessionName", null);
		response.getWriter().write("ok");
%>
