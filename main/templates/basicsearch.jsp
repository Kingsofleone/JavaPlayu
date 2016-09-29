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
<%@page import="java.net.URLEncoder" %>

<%@page import="org.apache.lucene.analysis.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="org.apache.lucene.index.*" %>
<%@page import="org.apache.lucene.search.*" %>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.oxyus.admin.Configuration" %>
<%@page import="org.oxyus.util.Constants" %>

<html>
  <head>
    <title>Oxyus Search Engine</title>
  </head>
  <body>
 
    <h3>Welcome to the basic search template !</h3>
 
 	<p>
	  This template upgrades the <a href="helloworld.jsp">hello world template</a>
	  adding a max limit for the results displayed per page.
 	</p>
 	<p>
 	  Please, feel free to review and edit the code located at:<br>
 	  <%= request.getRealPath("/templates/basicsearch.jsp") %>
 	</p>
 
    <form>
    	Search: <input type="text" name="query"> <input type="submit" value="search">
    	<input type="hidden" name="maxresultsperpage" value="25">
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
				int totalResults = hits.length();
				if (totalResults == 0) {
					%>No items found<%
				} else {
				    // Reads the start index or begin at 0 by default
					int startIndex = 0;
					String startIndexString = request.getParameter("start");
					if (startIndexString != null) {
						startIndex = Integer.parseInt(startIndexString);
					}
					if (startIndex > totalResults) {
						startIndex = 0;
					}
				    // Reads the max results per page, defaults to 25
					int maxResultsPerPage= 25;
					String maxResultsPerPageString = 
							request.getParameter("maxresultsperpage");
					if (maxResultsPerPageString != null) {
						maxResultsPerPage = Integer.parseInt(
								maxResultsPerPageString);
					}
					// Calculate the endIndex
					int endIndex = startIndex + maxResultsPerPage;
					if (endIndex > totalResults) {
						endIndex = totalResults;
					}
					// Display the results
					for (int i=startIndex; i < endIndex; i++) {
						Document doc = hits.doc(i);
						String title = doc.get("title");
						String url = doc.get("url");
						String summary = doc.get("summary");
						%><a href="<%= url %>"><%=title%></a><br>
						  <%= summary %> ... <br><br><%
					}
					// Display a basic navigation bar
					String previousURL = null;
					String nextURL = null;
					String queryStringEncoded = URLEncoder.encode(queryString);
					String baseURL = request.getRequestURI() + "?query=" +
							queryStringEncoded + "&maxresultsperpage=" +
							maxResultsPerPage;
					if (startIndex > 0) {
						int previousIndex = startIndex - maxResultsPerPage;
						if (previousIndex < 0) {
							previousIndex = 0;
						}
						previousURL = baseURL + "&start=" + previousIndex;
					}
					int nextIndex = startIndex + maxResultsPerPage;
					if (nextIndex < totalResults) {
						nextURL = baseURL + "&start=" + nextIndex;
					}
					if (previousURL != null) {
						%><a href="<%= previousURL %>">
						  Previous <%= maxResultsPerPage %> results </a><%
					}
					if (previousURL != null && nextURL != null) {
						%>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<%
					}
					if (nextURL != null) {
						%><a href="<%= nextURL %>">
						  Next <%= maxResultsPerPage %> results</a> <%
					}
				}
			}
	    	}	
    %>
  </body>
</html>
