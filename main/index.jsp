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

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.net.URLEncoder" %>

<%@page import="org.oxyus.search.Search" %>
<%@page import="org.oxyus.search.SearchException" %>
<%@page import="org.oxyus.util.Constants" %>
<html>
  <head>
    <title>Oxyus Search Engine</title>
  </head>
  <body>
 
    <h3>Welcome to Oxyus <%= Constants.OXYUS_RELEASE %> !</h3>

	<%
    	String queryString = request.getParameter("query");
    	if (queryString == null) {
    		queryString = "";
    	}
    %>
 
    <form>
    	Search: <input type="text" name="query" value="<%= queryString %>"> <input type="submit" value="search">
    	<input type="hidden" name="maxresultsperpage" value="25">
    	&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">see more search templates <a href="templates">here</a></font>.
    	<font size="2">Go to <a href="admin">admin console</a></font>
    </form>
    
    <br>
    
    <%
    	if (queryString == null || queryString.trim().equals("")) {
    		%>Input a query to search<%
    	} else {
    		try {
	    		Search search = new Search(queryString);
				if (search.getTotalDocumentsInIndex() == 0) {    		
					%>No documents indexed, please setup oxyus
					<a href="<%= request.getContextPath() %>/admin">here</a>. <%
				}
				int totalResults = search.getTotalResults();
				if (totalResults == 0) {
					%>No documents found<%
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
						String title = search.getTitle(i);
						String url = search.getUrl(i);
						String summary = search.getSummary(i);
						String content = search.getContent(i);
						%><a href="<%= url %>"><%=title%></a><br>
						  <%= summary %><br><br><%
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
	    	} catch (SearchException se) {
	    		%>An error occurred<%
	    	}
	    }
    %>
  </body>
</html>
