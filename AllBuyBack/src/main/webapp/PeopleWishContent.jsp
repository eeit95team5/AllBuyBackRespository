<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>PersonalWishContent</title>
<style>
	#thhead{
		text-align:center
	}
	
</style>

</head>
<body>
<jsp:include page="includeTop.jsp"></jsp:include>
	<form name="UpdateWishContent" id="UpdateWishContent1" action="UpdateWish?w_Id=${wVO.w_id}" method="POST" enctype="multipart/form-data">
	<fieldset>
	<table>
	<thead>
	<tr><th id="thhead" height="60" colspan="2" align="center">許願單</th></tr>
	</thead>
	<tbody>
		<tr>
		    <td width="120" height="40">許願編號:</td>
		    <td width="600" height="40" align="left" >
		    <input id='w_Id1' style="text-align:left" name="w_Id" disabled value="${wVO.w_id}" type="text" size="14">
		</tr>
		<tr>
		    <td width="120" height="40">許願人:</td>
		    <td width="600" height="40" align="left" >
		    <input id='account1' style="text-align:left" name="account" disabled value="${wVO.m_account}" type="text" size="14">
		</tr>
		<tr>
		    <td width="120" height="40">許願時間:</td>
		    <td width="600" height="40" align="left" >
		    <input id='date1' style="text-align:left" name="date" disabled value="${wVO.w_date}" type="text" size="14">
		</tr>
		<tr>
		    <td width="120" height="40">許願狀態:</td>
		    <td width="600" height="40" align="left" >
		    <input id='date1' style="text-align:left" name="date" disabled value="${wVO.w_status}" type="text" size="14">
		</tr>
		<tr>
		    <td width="120" height="40">許願人數:</td>
		    <td width="600" height="40" align="left" >
		    <input id='date1' style="text-align:left" name="date" disabled value="${wVO.w_count}" type="text" size="14">
		</tr>
		<tr>
		    <td width="120" height="40">許願標題:</td>
		    <td width="600" height="40" align="left" >
		         <input id='title1' style="text-align:left" name="title" disabled value="${wVO.w_title}" type="text" size="14">
		    </td>
		</tr>
		<tr>
		    <td width="120" height="40">許願內容:</td>
		    <td width="600" height="40" align="left" >
		         <textarea cols="40" rows="5" name="content" id="content1" disabled >${wVO.w_content}</textarea>
		    </td>
		</tr>
		<tr>
		    <td width="120" height="40">圖片:</td>
		    <td width="600" height="40" align="left" >
			    	<c:if test="${not empty p1}">
			    		<div style="float:left; margin:5px">
						<img height='100' width='100' src='${pageContext.servletContext.contextPath}/ReadPictureForWP?w_Id=${wVO.w_id}&pic_id=${p1}'>
						</div>
					</c:if>
					<c:if test="${not empty p2}">
						<div style="float:left; margin:5px">
						<img height='100' width='100' src='${pageContext.servletContext.contextPath}/ReadPictureForWP?w_Id=${wVO.w_id}&pic_id=${p2}'>
						</div>
					</c:if>
					<c:if test="${not empty p3}">
						<div style="float:left; margin:5px">
						<img height='100' width='100' src='${pageContext.servletContext.contextPath}/ReadPictureForWP?w_Id=${wVO.w_id}&pic_id=${p3}'>
						</div>
					</c:if>
					<c:if test="${not empty p4}">
						<div style="float:left; margin:5px">
						<img height='100' width='100' src='${pageContext.servletContext.contextPath}/ReadPictureForWP?w_Id=${wVO.w_id}&pic_id=${p4}'>
						</div>
					</c:if>
					<c:if test="${not empty p5}">
						<div style="float:left; margin:5px">
						<img height='100' width='100' src='${pageContext.servletContext.contextPath}/ReadPictureForWP?w_Id=${wVO.w_id}&pic_id=${p5}'>
						</div>
					</c:if>
		    </td>
		</tr>
		<tr>
		    <td width="120" height="40">參與願望名單:</td>
		    <td width="600" height="40" align="left" >
		    	<c:forEach var="list" items="${wlList}">
		    		${list.m_account}<br>
		        </c:forEach>
		    </td>
		</tr>
		<tr>
		    <td width="120" height="40">實現願望賣家:</td>
		    <td width="600" height="40" align="left" >
		    	<c:forEach var="as" items="${asVO}">
		    		${as.m_account}實現願望的內容: <a href="SingleItemContent?w_id=${wVO.w_id}&i_id=${iVO.i_id}">${iVO.i_name}</a>
		    		<c:if test="${not empty iVO.i_name}">
		    			<input type="button" value="加入購物車">
		    		</c:if>
		    	</c:forEach>
		    </td>
		</tr>
		<tr>
		    <td height="50" colspan="2" align="center">
		       <a href="AddOne?w_Id=${wVO.w_id}"><input class="btn" type="button" value="+1" ></a>
		       <a href="CheckPeopleList"><input class="btn" type="button" value="返回列表"></a>
		       <a href="HomeIndex.jsp"><input class="btn" type="button" value="回首頁"></a>
		       <a href="MakeWishComeTrue?w_Id=${wVO.w_id}"><input class="btn" type="button" value="接受願望"></a>
		       <br>
		       <font color='red' size='-1'>${errorMsg.login}</font>
		       <font color='red' size='-1'>${errorMsg.duplicateAccount}</font>
		       <font color='red' size='-1'>${errorMsg.doubleAccount}</font>
		       <font color='red' size='-1'>${errorMsg.AccountNoRight}</font>
		    </td>
		</tr>	
	</tbody>
	</table>
	</fieldset>
	</form>
	<br><br>
<jsp:include page="_Footer.jsp"></jsp:include>
</body>
</html>