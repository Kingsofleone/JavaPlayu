<%--

  $Id$
  
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

<%@page import="java.io.IOException" %>

<%@page import="org.apache.lucene.analysis.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="org.apache.lucene.index.*" %>
<%@page import="org.apache.lucene.search.*" %>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.oxyus.admin.Configuration" %>

<html>
  <head>
    <title>Oxyus Search Engine</title>
  </head>
  <body>
 
    <h3>Welcome to the Hello World search template !</h3>
 
 	<p>
	  The objective of this template is to show you how to make a simple
	  search with oxyus accessing directly to the Apache Lucene index.
 	</p>
 	<p>
 	  Please, feel free to review and edit the code located at:<br>
 	  <%= request.getRealPath("/templates/helloworld.jsp") %>
 	</p>
 	
    <form>
    	Search: <input type="text" name="query"> <input type="submit" value="search">
    	<br><a href="index.jsp">go back to templates</a>
    </form>
    
    <br>
    
    <%
    	String queryString = request.getParameter("query");
    	if (queryString == null || queryString.trim().equals("")) {
    		%>Input a query to search<%
    	} else {
			IndexSearcher searcher = null;
			try {
				searcher = new IndexSearcher(
					IndexReader.open(Configuration.getIndexDirectory()));
			} catch (IOException ioe) {
				%>No index exists, please setup oxyus
				<a href="<%= request.getContextPath() %>/admin">here</a>.<%
			}
			if (searcher != null) {
				Analyzer analyzer = new StopAnalyzer();
				Query query = QueryParser.parse(queryString, "contents",
						analyzer);
				Hits hits = searcher.search(query);
				if (hits.length() == 0) {
					%>No items found<%
				} else {
					int maxResults = 100;
					for (int i=0; i < hits.length() && i < maxResults; i++) {
						Document doc = hits.doc(i);
						String title = doc.get("title");
						String url = doc.get("url");
						String summary = doc.get("summary");
						%><a href="<%= url %>"><%=title%></a><br>
						<%= summary %> ... <br><br><%
					}
				}
			}
	    	}	
    %>
  </body>
</html>
