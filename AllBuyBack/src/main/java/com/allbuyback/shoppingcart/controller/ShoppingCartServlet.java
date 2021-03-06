package com.allbuyback.shoppingcart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;

import com.allbuyback.ItemSearch.model.ItemService;
import com.allbuyback.ItemSearch.model.ItemVO;
import com.allbuyback.login.model.MemberDAO;
import com.allbuyback.login.model.MemberVO;
import com.allbuyback.shoppingcart.model.ShoppingCart;
import com.allbuyback.shoppingcart.model.ShoppingCartVO;


@WebServlet("/ShoppingCart.go")
public class ShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ShoppingCartServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//取得輸入值
		String action = request.getParameter("action");
		System.out.println(action);
		// 準備存放錯誤訊息的Map物件
		List<String> errorMsgs = new LinkedList<String>();
		// 將errorMsgs放入request物件內
		request.setAttribute("errorMsgs", errorMsgs);
		// 取得session及登錄資料
		HttpSession session = request.getSession(false);
		if (session == null) {      // 使用逾時
			errorMsgs.add("請先登入");
			RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
			return;
		}
		MemberVO loginOK = (MemberVO)session.getAttribute("LoginOK");
		if (loginOK == null) {      // 使用逾時
			request.setAttribute("errorMsgs", "請先登入");
			RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
			return;
		}
		Integer login = loginOK.getM_id();

		//加入購物車功能			
		if("addToCart".equals(action)){
			int id = login;
			//取得輸入值
			String st_i_id = request.getParameter("i_id");
			String st_ol_quantity = request.getParameter("ol_quantity");
			String ol_memo = request.getParameter("ol_memo");
			String st_s_id = request.getParameter("s_id");

			// 取出存放在session物件內的ShoppingCart物件
			ShoppingCart cart = (ShoppingCart)session.getAttribute("ShoppingCart");
			// 如果找不到ShoppingCart物件
			if (cart == null) {
				// 就新建ShoppingCart物件
				cart = new ShoppingCart();
				// 將此新建ShoppingCart的物件放到session物件內
				session.setAttribute("ShoppingCart", cart);   // ${ShoppingCart.zzz}
				System.out.println("new cart");
			}
			//JQ模式字串宣告
			PrintWriter out = response.getWriter();
			Map map = new HashMap();
			
			
			//型別轉換
			int i_id=0;
			int s_id=0;
			int ol_quantity=0;
			try {
				i_id = Integer.parseInt(st_i_id);
				s_id = Integer.parseInt(st_s_id);
				ol_quantity = Integer.parseInt(st_ol_quantity);
				System.out.println("change ok");
			} catch (Exception e) {
				errorMsgs.add("發生錯誤");
				System.out.println("error");
			}
			//驗證：不能購買自己的商品(JQ模式)
			if(s_id==id){
				String msg = "這是您自己的商品唷!";
				map.put("a", msg);
				msg = JSONValue.toJSONString(map);
				out.println(msg);
				return;
			}

			//如果有錯誤則中斷--JQ模式失效
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request
						.getRequestDispatcher("/index.jsp");
				failureView.forward(request, response);
				return;
			}
			//取得商品資訊
			ItemService itemService = new ItemService();
			ItemVO itemVO = itemService.select(i_id);
			Timestamp arrivedDate = itemVO.getI_arrivedDate();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String i_arrivedDate = sdf.format(arrivedDate);
			String i_name = itemVO.getI_name();
			int i_price =itemVO.getI_price();
			
			// 將購物車資料封裝到ShoppingCartVO內
			ShoppingCartVO shoppingCartVO = new ShoppingCartVO();
			shoppingCartVO.setI_id(i_id);
			shoppingCartVO.setOl_quantity(ol_quantity);
			shoppingCartVO.setOl_memo(ol_memo);
			shoppingCartVO.setS_id(s_id);
			shoppingCartVO.setI_name(i_name);
			shoppingCartVO.setI_price(i_price);
			shoppingCartVO.setI_arrivedDate(i_arrivedDate);
			// 將ShoppingCartVO加入ShoppingCart的物件內
			String Msg = cart.addToCart(i_id, shoppingCartVO);
			//submit模式
//			request.setAttribute("Msg", Msg);
//			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
//			rd.forward(request, response);
			//JQ模式
			
			map.put("a", Msg);
			Msg = JSONValue.toJSONString(map);
			out.println(Msg);
			System.out.println(Msg);
			//結束
			System.out.println("finish");
		}
		
		//查看購物車功能
		if("select".equals(action)){
			// 取出存放在session物件內的ShoppingCart物件
			ShoppingCart cart = (ShoppingCart)session.getAttribute("ShoppingCart");
			// 如果找不到ShoppingCart物件
			if (cart == null) {
//				errorMsgs.add("購物車內還是空的唷!快來購物吧!");
				System.out.println("沒資料");
				RequestDispatcher rd = request.getRequestDispatcher("/shoppingCart.jsp");
				rd.forward(request, response);
				return;
			}
			//以s_id排序取出
			List<ShoppingCartVO> cartlist = cart.listCart();
			for(int i=0;i<cartlist.size();i++){
				String i_name = cartlist.get(i).getI_name();
				if(i_name.length()>10){
					i_name = i_name.substring(0, 9);
				}
			}
			request.setAttribute("cartlist", cartlist);		
//附加功能開始
			//查詢賣家資訊--未測試--DAO

			Map nameMap = new LinkedHashMap();
			for(int i=0;i<cartlist.size();i++){
				int s_id = cartlist.get(i).getS_id();
				MemberDAO memberDAO = new MemberDAO();
				MemberVO memberVO = memberDAO.selectById(s_id);
				String m_name = memberVO.getM_name();
				nameMap.put(s_id, m_name);
			}
			request.setAttribute("s_name", nameMap);
//附加功能結束
			//導向頁面
			RequestDispatcher rd = request.getRequestDispatcher("/shoppingCart.jsp");
			rd.forward(request, response);
		}
		
		//修改購物車功能
		if("update".equals(action)){
			//取得輸入值
			String st_i_id = request.getParameter("i_id");
			String st_ol_quantity = request.getParameter("ol_quantity");
			String ol_memo = request.getParameter("ol_memo");
			// 取出存放在session物件內的ShoppingCart物件
			ShoppingCart cart = (ShoppingCart)session.getAttribute("ShoppingCart");
			//型別轉換
			int i_id=0;
			int ol_quantity=0;
			try {
				i_id = Integer.parseInt(st_i_id);
				ol_quantity = Integer.parseInt(st_ol_quantity);
			} catch (Exception e) {
				errorMsgs.add("發生錯誤");
				request.setAttribute("errorMsg", "發生錯誤");
				request.getRequestDispatcher("/ShoppingCart.go?action=select")
				.forward(request, response);
				return;
			}
			if(ol_quantity <= 0){
				errorMsgs.add("數量不能小於1唷!如不想購買此商品請使用刪除按鈕");
				request.setAttribute("errorMsg", "數量不能小於1唷!如不想購買此商品請使用刪除按鈕");
				request.getRequestDispatcher("/ShoppingCart.go?action=select")
				.forward(request, response);
				return;
			}

			String result = cart.modifyQty(i_id, ol_quantity, ol_memo);
			request.setAttribute("Msg", result);
			RequestDispatcher rd = request.getRequestDispatcher("/ShoppingCart.go?action=select");
			rd.forward(request, response);
		}
		//刪除購物車功能
		if("delete".equals(action)){
			//取得輸入值
			String st_i_id = request.getParameter("i_id");

			// 取出存放在session物件內的ShoppingCart物件
			ShoppingCart cart = (ShoppingCart)session.getAttribute("ShoppingCart");
			//型別轉換
			int i_id=0;
			try {
				i_id = Integer.parseInt(st_i_id);
				System.out.println("change ok");
			} catch (Exception e) {
				errorMsgs.add("發生錯誤");
				System.out.println("error");
			}

			//如果有錯誤則中斷
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request
						.getRequestDispatcher("/ShoppingCart.go?action=select");
				failureView.forward(request, response);
				return;
			}
			cart.delete(i_id);
			RequestDispatcher rd = request.getRequestDispatcher("/ShoppingCart.go?action=select");
			rd.forward(request, response);
		}


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
