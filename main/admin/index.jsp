<%--

  $Id: index.jsp,v 1.4 2004/10/05 22:24:45 csaltos Exp $
  
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

<%@page import="org.oxyus.util.Constants" %>

<%
        String defaultWebSite;
        defaultWebSite = "http://";
        defaultWebSite += request.getServerName();
        if (request.getServerPort() != 80) {
            defaultWebSite += ":" + request.getServerPort();
        }
        defaultWebSite += "/";
%>
<html>
  <head>
    <title>Oxyus Admin</title>
  </head>
  <body>
    <h3>Welcome to Oxyus <%= Constants.OXYUS_RELEASE %> !</h3>
    <p>Set the website you want index with oxyus</p>
    <form action="setup.jsp">
      Web site to index: <input type="text" name="website" value="<%= defaultWebSite %>"><br>
      Update index every <input type="radio" name="update" value="daily" checked>day
      &nbsp;&nbsp;&nbsp; <input type="radio" name="update" value="weekly"> week<br><br>
      &nbsp;&nbsp;<input type="submit" value="start oxyus">
      <br><br>Go back to <a href="<%= request.getContextPath() %>/">home</a>
    </form>
  </body>
</html>
