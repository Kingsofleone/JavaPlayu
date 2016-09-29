<%--

  $Id: setup.jsp,v 1.5 2004/10/05 22:24:45 csaltos Exp $
  
  Copyright 2001 PUCE [http://www.puce.edu.ec]
 
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
 
      http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  
--%>

<%@page import="java.net.URL" %>

<%@page import="org.oxyus.admin.Manager" %>
<%@page import="org.oxyus.util.Constants" %>

<%
        String website = request.getParameter("website");
        String update = request.getParameter("update");
        
        Manager.setDefaultInitialPage(new URL(website));
        if ("dayly".equals(update)) {
                Manager.scheduleCrawling(24);
        } else {
                Manager.scheduleCrawling(24 * 7);
        }
%>

<html>
  <head>
    <title>Oxyus Admin</title>
  </head>
  <body>
    <h3>Oxyus <%= Constants.OXYUS_RELEASE %> is running now !</h3>
    <p>Depending on the website content size, the index time may take
       a few minutes or couple of hours.</p>
    <p>You can do some queries as oxyus is indexing web pages at the
       <a href="<%= request.getContextPath() %>/">search page</a>.</p>
    <p>You can change the look&feel based on the search templates located
       <a href="<%= request.getContextPath() %>/templates">here</a>.</p>
  </body>
</html>
