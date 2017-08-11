<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="webjars/bootstrap/3.3.7-1/css/bootstrap.css">
	<script src="webjars/jquery/3.2.1/dist/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>
	<style>
		#mainBody {
			width: 1200px;
			margin:10px auto;
		}
		#mainTable{
			margin: auto;
			padding:10px;
			border:2px solid #0000FF;
			border-bottom:2px solid #0000FF;
			font-size:18px;
		}
		#mainTable td{
			border:2px solid #0000FF;
		}
		#Settlement{
			width: 900px;
			text-align:right;
			font-size:26px;
		}
		#lastPrice{
			
		}
	</style>
	<script>
// 		$(function(){
// 			$('.shopName').each(function(data){
// 				var s_id = $(this).attr('id');
// 				$.post('')
// 			});
// 		})
	</script>
</head>
<body>
<h1 style='text-align:center'>我的購物車</h1>
<div id="mainBody">
	<c:if test="${!empty cartlist}">
	<table id="mainTable">
		<thead align="center">
			<tr>
				<td>賣場</td>
				<td>商品名稱</td>
				<td>單價</td>
				<td>購買數量</td>
				<td>小計</td>
				<td>可出貨時間</td>
				<td>備註</td>
				<td colspan="2">操作</td>
			</tr>
		
			<c:forEach var="list" items="${cartlist}" varStatus="vs">
			<tr align="center" valign="middle">
			<form action="ShoppingCart.go" method="post">
				<td><a href="shop.html?s_id=${list.s_id}" id="${list.s_id}" class="shopName">連結賣場</a></td>
				<td>${list.i_name}</td>
				<td>${list.i_price}</td>
				<td><input type="text" name="ol_quantity" value="${list.ol_quantity}" /></td>
				<td>${list.i_price*list.ol_quantity}</td>
				<td>${list.i_arrivedDate}</td>
				<td><textarea name="ol_memo" >${list.ol_memo}</textarea></td>
				<td><input type="submit" value="修改"/>
				    <input type="hidden" name="action" value="update"/>
				    <input type="hidden" name="i_id" value=${list.i_id} /></td>
			</form>
				<td>
				<form>
					<input type="submit" value="取消" />
					<input type="hidden" name="action" value="delete" />
					<input type="hidden" name="i_id" value=${list.i_id} />
				</form>
				</td>
			</tr>
			</c:forEach>
		</thead>
		<tbody>
			<tr></tr>
			<tr align="center" valign="middle" height="50px">
			</tr>
		</tbody>
	</table>
		<div id="Settlement">
		<label colspan="4" align="right">總計</label><p id="lastPrice">$ ${ShoppingCart.subtotal}</p>
			<form action="Order.do" method="post">
				<input type="hidden" name="o_tolPrice" value=${ShoppingCart.subtotal}/>
				<input type="submit" value="結算" />
				<input type="hidden" name="action" value="createOrder" />
			</form>
		</div>
	</c:if>
</div>
<div id="msgBoby" align="center">
	<c:if test="${empty cartlist}">
		<p>購物車還是空的喔!快開始購物吧!</p>
		<a href="index.jsp">開始購物</a><br>
	</c:if>
	<c:if test="${!empty Msg}">
		<p>${Msg}</p>
	</c:if>
	<c:if test="${!empty errorMsgs}">
		<p>${errorMsgs}</p>
	</c:if>
	<p>${errorMsg}</p>
	<a href="shop.html?s_id=1000002">我要繼續買</a><br>
</div>
</body>
</html>