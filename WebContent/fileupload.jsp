<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%


        //to get the content type information from JSP Request Header
        String contentType = request.getContentType();
        //here we are checking the content type is not equal to Null and
 //as well as the passed data from mulitpart/form-data is greater than or
 //equal to 0
 out.print(request.getParameter("productId"));
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {

            
                DataInputStream in = new DataInputStream(request.
getInputStream());
                //we are taking the length of Content type data
                int formDataLength = request.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                //this loop converting the uploaded file into byte code
                while (totalBytesRead < formDataLength) {
                        byteRead = in.read(dataBytes, totalBytesRead,
formDataLength);
                        totalBytesRead += byteRead;
                        }

                                        String file = new String(dataBytes);

                String saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1,contentType.length());
                int pos;
                //extracting the index of file
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation))
.getBytes()).length;
                // creating a new file with the same name and writing the
//content in new file
                String str="C:\\Users\\hp\\eclipse-workspace\\E-Commerce\\WebContent\\images\\" + request.getParameter("productId");
                out.println(str);
                File f=new File(str);
                
                if(!f.exists())
                	f.mkdir();
                String path=str+"\\productImage.jpg";
				
                try{

                    FileOutputStream fileOut = new FileOutputStream(path);
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();	
                } catch(Exception e){
                	response.getWriter().write(e.getMessage());
                }
                                %><Br><table border="2"><tr><td><b>You have successfully
 upload the file by the name of:</b>
                                           </td></tr></table> <%
                }

        response.sendRedirect("adminindex.jsp");
%>