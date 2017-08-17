<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>單一商品頁面</title>
    
    <link rel="stylesheet" href="styles/main.css"/>
<link rel="stylesheet" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css">
<link rel="stylesheet" href="webjars/jquery-ui/1.12.1/themes/base/jquery-ui.min.css">
<link rel="stylesheet" href="webjars/sweetalert/1.1.3/dist/sweetalert.css">
<script src="webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>
<script src="webjars/jquery-ui/1.12.1/jquery-ui.min.js"></script>
<script src="webjars/sweetalert/1.1.3/dist/sweetalert.min.js"></script>

     <link rel="stylesheet" href="styles/singleItem.css"/>
<style>
.ThisWeek {  /*關於本週頭條  以下三個class貼在main裡不能跑會衝突*/
  color:white;
  font-size:16px;
  /*line-height:45px;*/
  margin-right:10px;
  float:left;
  margin-top:10px;
}
.ThisWeek:hover {
   color:lightgray;
   text-decoration:none;
  
}
.icon-success {  /*改變bootstrap icon的顏色*/
 color: #FFB90F;
   float:left;
}

/*------------------------*/
.myActive  {
    border-top:pink 5px solid;
}

</style>
<script type="text/javascript">
$(function() {
	

 	$("#eye").mouseover(function() {
 		$('#eyeCount').attr("style","position:absolute;top:60px;left:35px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:block;");
 	});

 	
 	$("#eye").mouseout(function() {
 		$('#eyeCount').attr("style","display:none;");
 	});
     /*---------------------------------------------------*/
     
      	$("#heart").mouseover(function() {
 		$('#heartCount').attr("style","position:absolute;top:60px;left:100px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:block;");
 	});

 	
 	$("#heart").mouseout(function() {
 		$('#heartCount').attr("style","display:none;");
 	});

     
    /*----------------------------------------------------*/
    
    
    $("#shoppingCart").mouseover(function() {
 		$('#shoppingCartCount').attr("style","position:absolute;top:60px;left:160px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:block;");
 	});

 	
 	$("#shoppingCart").mouseout(function() {
 		$('#shoppingCartCount').attr("style","display:none;");
 	});

 	
    /*----------------------------------------------------*/
    	
 	$("#addToCart").click(function() {
 		var i_id = $('#i_id').val();
 		var s_id = $('#s_id').val();
 		console.log("ok");
 		var ol_quantity = $('#ol_quantity').val();
 		$.post("ShoppingCart.go",{'action':"addToCart",'i_id':i_id,'s_id':s_id,'ol_quantity':ol_quantity},
 			function(data){
 			var json = JSON.parse(data);
 			var str = json.a;
 			var theType = "success";
 			var theText = "再多看看別的商品吧!"
 			if(str=="加入購物車失敗，不能新增數量0以下" || str=="加入購物車失敗，剩餘數量不足"){
				theType = "error";
				theText = "請確定數量再加入購物車"
 			}
 			if(str=="這是您自己的商品唷!"){
 				theType = "error";
				theText = "去看看其他人的賣場吧!!"
 			}
				swal({
					title: str,
 					text: theText,
 					type: theType
				});
			})
 	});
    
 	/*----------------------------------------------------*/
    
    	$("#buyAdTag").mouseover(function() {
 		$('#buyAd').attr("style","position:absolute;top:7px;left:1100px;border-radius:5px 5px;color:black;font-size:15px;width:100px;display:block");
 	});
    	

    	$("#buyAdTag").mouseout(function() {
 		$('#buyAd').attr("style","display:none");
 	});

    	$("#buyAdTag").click(function() {/*點下去跳至買廣告頁面*/
    		var i_id = $('#i_id').val();
    			window.open('Ad.go?action=prepareBuy&i_id='+i_id, '購買AllBuyBack廣告',
    					'height=350,width=650,scrollbars=0,resizable=0,location=0');
    	});
    	
    	var offset=$('#point').offset();
    	console.log(offset.top+","+offset.left)	;
    	if(offset.top<100){   		
    		$('#hidden').attr("style","margin-top:70px;display:block");
    	}
    	


})
</script>

</head>
<body style="background-color:rgb(234,234,234)">

<jsp:include page="includeTop.jsp"></jsp:include>

<nav id="hidden" class="navbar navbar-inverse  navbar-fixed-top " style="margin-top:70px;display:none"  >
<div  class="container-fluid"  style="background-color: yellow;height:90px; "></div>
</nav>

<div class="container"><!--商品上半部-->
    <div class="row">
        <div class="col-sm-12">
            <div class="productArea1"  >
               <div class="productTitle" >限定預購！日本郵局「哆啦A夢餐具組」 單人9件超值華組</div>

               
                <span id="buyAdTag" class="glyphicon glyphicon-tag " style="position:absolute;top:30px;left:1090px;font-size:20px;;color:gray"></span>
                <div id="buyAd" style="position:absolute;top:10px;left:1100px;border-radius:5px 5px;color:black;font-size:10px;display:none;">買廣告請點我</div>
                

                <div id="eyeCount" style="position:absolute;top:60px;left:35px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:none;">瀏覽數</div>
                <div id="eye"><span class="glyphicon glyphicon-eye-open " style="font-size:20px;color:gray"></span></div>
                <div style="position:absolute;top:80px;left:65px;color:gray">120</div>
                
                
                <div id="heartCount" style="position:absolute;top:60px;left:105px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:none;">收藏數</div>
                <div id="heart"><span class="glyphicon glyphicon-heart " style="font-size:20px;;color:gray"></span></div>
                <div style="position:absolute;top:80px;left:130px;color:gray">5</div>
                
                
                <div id="shoppingCartCount" style="position:absolute;top:60px;left:105px;border-radius:5px 5px;background-color:black;color:white;font-size:10px;padding:2px 5px;display:none;">代購數</div>
                <div id="shoppingCart"><span  class="glyphicon glyphicon-shopping-cart " style="font-size:20px;;color:gray"></span></div> 
                <div style="position:absolute;top:80px;left:195px;color:gray">3</div>

                   <div class="mainPhoto">
                     <img src="images/product.jpg" width="480" height="400" />
                   </div> 
                   <div class="smallPhoto1" >
                     <img src="images/product.jpg" width="90" />
                   </div>
                  <div class="smallPhoto2" >
                     <img src="images/product2.jpg" width="90" />
                   </div>
                  <div class="smallPhoto3" >
                     <img src="" width="90" />
                   </div>

                <div class="price">售價:</div>  
                <div class="brand">商品品牌:</div>  
                <div class="country">代購國家:</div>  
                <div class="waitDay">等待天數:</div> 
                
                <div class="count">數量:
                 
                   <input type="number" id="ol_quantity" value="1" min="1" max="99"  style="width:60px;height:40px;padding-left: 10px;margin-left: 12px;">
                
                </div>
                <input type="hidden" id="i_id" name="i_id" value="${itemVO.i_id}" />
				<input type="hidden" id="s_id" name="s_id" value="${itemVO.s_id}" />
                <button class="shoppingCart" id="addToCart">加入購物車</button> 
                <button class="wantBuy">聯絡賣家</button> 
                <div class="pay">付款方式:</div>  
                <div class="deliver">寄送方式:</div>  

            </div><!--productArea1區域-->
        </div>
    </div>
</div>


<div class="container"><!--商品下半部-->
    <div class="row">
        <div class="col-sm-8">
            <div class="productArea2">
           
  <ul class="nav nav-tabs">
    <li class="active myActive" style="font-family:微軟正黑體;font-size:18px;letter-spacing:4px;font-weight:600"><a data-toggle="tab" href="#menu1">商品描述</a></li>
    <li  style="font-family:微軟正黑體;font-size:18px;letter-spacing:4px;font-weight:600"><a data-toggle="tab" href="#menu2">費用與寄送資訊</a></li>
    <li  style="font-family:微軟正黑體;font-size:18px;letter-spacing:4px;font-weight:600"><a data-toggle="tab" href="#menu3">問與答</a></li>

  </ul>

  <div class="tab-content">
    <div id="menu1" class="tab-pane fade in active">
      <h3 id="point">商品描述</h3>
      <p>NATIVE INSTRUMENTS 的MASCHINE系列可說是DJ必備的生財工具，不管是做EDM歌曲、派對放歌、混音編曲都可以用 MASCHINE 來完成，最大的特色是它包含Pattern編曲機、音色取樣機、多種效果器，可載入其他插件，流暢的編曲環境和控制面板讓歌曲製作更方便。</p>
    </div>
    <div id="menu2" class="tab-pane fade">
      <h3>費用與寄送資訊</h3>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
    <div id="menu3" class="tab-pane fade">
      <h3>問與答</h3>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
    </div>
  </div>

</div><!--productArea2-->


<div style="height:250px;background-color:#B0C4DE;margin-top:20px;padding-top:50px;margin-bottom:50px;
border-radius:5px 5px;text-align:center;font-size:20px;font-family:微軟正黑體;letter-spacing:3px;">
    
    <span class="glyphicon glyphicon-plane" style="color:white;font-size:25px;"></span>
    欲購買或發問點請選<br /><br /><br />
<button style="border-radius:5px 5px;border:rgb(42,186,171);background-color:rgb(42,186,171);color:white;padding:10px 30px;font-size:20px;margin-top:10px;font-weight:500;">聯絡賣家</button>

</div>



 </div><!--8格-->

        <div class="col-sm-offset-1 col-sm-3">
            <div class="seller" >
                <div style="margin-top:20px;text-align:center;">ABOUT SELLER</div>
                <div style=" width:120px;height:120px; border-radius:99em;  /*border:2px lightgray solid*/margin-left:70px;margin-top:10px;"><img src="images/myPicture.jpg" style="border-radius:99em;width:120px;height:120px;"/></div>
                <div><h4 style="font-family:微軟正黑體;text-align:center;padding-top:10px;">韓國代購天堂</h4></div>
                
                <div style="text-align:center;margin-top:20px;">
                <span class="glyphicon glyphicon-plane" style="color:#EEB4B4;font-size:25px;"></span><span class="glyphicon glyphicon-plane" style="color:#EEB4B4;font-size:25px;"></span><span class="glyphicon glyphicon-plane" style="color:#EEB4B4;font-size:25px;"></span><span class="glyphicon glyphicon-plane" style="color:#EEB4B4;font-size:25px;"></span><span class="glyphicon glyphicon-plane" style="color:#EEB4B4;font-size:25px;"></span>
                </div>
                    
                <div style="color:gray;font-family:微軟正黑體;font-size:12px;text-align:center;margin-top:20px;">評價 | 關於我 | 代購商品</div>

                 <div style="text-align:center;margin-top:20px;"><button style="border-radius:5px 5px;border:black;background-color:black;color:white;width:250px;padding:7px 10px;"> <span class="glyphicon glyphicon-eye-open"><span style="margin-left:10px;font-size:20px;font-family:微軟正黑體;">&nbsp訂閱我</span></button></div>
                 <div style="color:gray;font-family:微軟正黑體;font-size:12px;text-align:center;margin-top:20px;">目前共有100人訂閱</div>
                  
                <div style="padding:2px 20px;color:#8B7B8B;font-family:微軟正黑體;font-size:15px;text-align:center;margin-top:20px;">喜歡賣家代購的好物？<br />訂閱即可在第一時間收到代購分享的最新代購文章、商品資訊和專欄喔！</div>

                 <div style="position:relative;margin-top:20px;color:white;font-family:微軟正黑體;font-size:15px;">
                     <div style="position:absolute;left:0px;background-color:gray;width:80px;height:80px;padding:15px 10px;text-align:center;">前5小時<br />最後上站</div>
                     <div style="position:absolute;left:90px;background-color:gray;width:80px;height:80px;padding:15px 10px;text-align:center;">90%<br />回應率</div>
                     <div style="position:absolute;left:180px;background-color:gray;width:80px;height:80px;padding:15px 10px;text-align:center;">3天內<br />平均回應</div>
                 </div>


            </div><!--seller區塊-->
        </div>


    </div><!--row-->
</div><!--container-->

<!----------footer開始-------------->
<footer>
 <div class="container-fluid" style="background-color:rgb(185,152,103);height:160px;padding-left:30px;padding-top:30px" >
 
    	<div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12"><!--複製go1buy1-->
            	<ul class="footer_menu">
                	<li><a href="">新手上路</a></li>
                	<li><a href="">常見問題</a></li>  
                	<li><a class="">客服中心</a></li>                          
                </ul>
            </div>
        	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
            	<ul class="footer_menu">
                	<li><a href="">許願池</a></li>
                	<li><a href="">最新代購消息</a></li>
                	<li><a href="">代購賣家進駐申請</a></li>					            		                            
                </ul>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
            	<ul class="footer_menu">
            		<li><a href="">FB粉絲團</a></li>
                    <li><a href="">聯絡ALLBUYBACK</a></li>
                    <li><a href="">服務條款與隱私權政策</a></li>
                 </ul>
            </div>                    
        </div>
    </div>
</footer>


<div class="container-fluid" style="background-color:rgb(41,64,87);height:45px;color:white;text-align:center;padding-top:15px;" >
    Copyright ©2017 - ALLBUYBACK 股份有限公司
</div>
<!----------footer結束-------------->





</body>
</html>