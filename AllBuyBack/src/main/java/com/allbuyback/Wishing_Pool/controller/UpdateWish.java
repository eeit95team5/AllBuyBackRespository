package com.allbuyback.Wishing_Pool.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.allbuyback.Achieve_Shop.model.Achieve_ShopDAO;
import com.allbuyback.Achieve_Shop.model.Achieve_ShopVO;
import com.allbuyback.Pictures.model.PicturesDAO;
import com.allbuyback.Wisher_List.model.Wisher_ListDAO;
import com.allbuyback.Wisher_List.model.Wisher_ListVO;
import com.allbuyback.Wishing_Pool.model.Wishing_PoolDAO;
import com.allbuyback.Wishing_Pool.model.Wishing_PoolVO;
import com.allbuyback.login.model.MemberDAO;
import com.allbuyback.login.model.MemberVO;

@WebServlet("/UpdateWish")
@MultipartConfig(maxFileSize = 1024 * 1024 * 500)
public class UpdateWish extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int w_id = Integer.parseInt(request.getParameter("w_Id"));

		Map<String, String> errorMessage = new HashMap<String, String>();
		request.setAttribute("ErrorMsg", errorMessage);

		MemberVO mvo = (MemberVO) request.getSession().getAttribute("LoginOK");
		Wisher_ListDAO wlDAO = new Wisher_ListDAO();
		int m_id = mvo.getM_id();

		String account = mvo.getM_account();

		String title = request.getParameter("title");
		if (title == null || title.length() == 0) {
			errorMessage.put("title", "許願標題必須輸入");
		}

		String content = request.getParameter("content");
		if (content == null || content.length() == 0) {
			errorMessage.put("content", "許願內容必須輸入");
		}
		Wishing_PoolDAO wpDAO = new Wishing_PoolDAO();
		PicturesDAO pDAO = new PicturesDAO();
		
		if (!errorMessage.isEmpty()) {
			// 願望內容重新送回
			Wishing_PoolVO wVO = wpDAO.selectWish(w_id);
			MemberDAO mDAO = new MemberDAO();
			String m_account = mDAO.selectById(wVO.getM_id()).getM_account();
			wVO.setM_account(m_account);
			request.setAttribute("wVO", wVO);
			// 參與人名單重新送回
			List<Wisher_ListVO> wlList = wlDAO.selectWisher(w_id);
			for (int i = 0; i < wlList.size(); i++) {
				wlList.get(i).setM_account(mDAO.selectById(wlList.get(i).getM_id()).getM_account());
			}
			request.setAttribute("wlList", wlList);
			// 接單賣家重新送回
			Achieve_ShopDAO asDAO = new Achieve_ShopDAO();
			List<Achieve_ShopVO> asVO = asDAO.selectAchieveByWId(w_id);
			if (asVO != null) {
				for (int i = 0; i < asVO.size(); i++) {
					MemberVO mVO2 = mDAO.selectById(asVO.get(i).getS_id());
					asVO.get(i).setM_account(mVO2.getM_account());
					request.setAttribute("asVO", asVO);
				}
			}
			// 已上傳圖片數目重新送回
			if(wpDAO.selectWish(w_id).getW_picture1().length != 0){
				request.setAttribute("p1", 1);
			}
			if(wpDAO.selectWish(w_id).getW_picture2().length != 0){
				request.setAttribute("p2", 2);
			}
			if(wpDAO.selectWish(w_id).getW_picture3().length != 0){
				request.setAttribute("p3", 3);
			}
			if(wpDAO.selectWish(w_id).getW_picture4().length != 0){
				request.setAttribute("p4", 4);
			}
			if(wpDAO.selectWish(w_id).getW_picture5().length != 0){
				request.setAttribute("p5", 5);
			}

			RequestDispatcher rd = request.getRequestDispatcher("PersonalWishContent.jsp");
			rd.forward(request, response);
			return;
		}

		Wishing_PoolVO wp = new Wishing_PoolVO();
		wp.setW_id(w_id);
		wp.setM_id(m_id);
		wp.setW_title(title);
		wp.setW_content(content);
		// Part part = request.getPart("file"); //讀單張圖片
		// byte[] b = wpDAO.getByte(part);
		// wp.setW_picture1(b);
		//讀多張圖片
		if(wpDAO.selectWish(w_id).getW_picture1().length != 0){
			wp.setW_picture1(wpDAO.selectWish(w_id).getW_picture1());
		}else{
			wp.setW_picture1(wpDAO.getByte(request.getPart("file1")));			
		}
		if(wpDAO.selectWish(w_id).getW_picture2().length != 0){
			wp.setW_picture2(wpDAO.selectWish(w_id).getW_picture2());
		}else{
			wp.setW_picture2(wpDAO.getByte(request.getPart("file2")));			
		}
		if(wpDAO.selectWish(w_id).getW_picture3().length != 0){
			wp.setW_picture3(wpDAO.selectWish(w_id).getW_picture3());
		}else{
			wp.setW_picture3(wpDAO.getByte(request.getPart("file3")));			
		}
		if(wpDAO.selectWish(w_id).getW_picture4().length != 0){
			wp.setW_picture4(wpDAO.selectWish(w_id).getW_picture4());
		}else{
			wp.setW_picture4(wpDAO.getByte(request.getPart("file4")));			
		}
		if(wpDAO.selectWish(w_id).getW_picture5().length != 0){
			wp.setW_picture5(wpDAO.selectWish(w_id).getW_picture5());
		}else{
			wp.setW_picture5(wpDAO.getByte(request.getPart("file5")));			
		}
		wpDAO.updateWish(wp);

		List<Wishing_PoolVO> list = wpDAO.selectPersonAllWishes(m_id);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getW_content().length() > 20) {
				String subcontent = (list.get(i).getW_content().substring(0, 20)) + "...";
				list.get(i).setW_content(subcontent);
			}
			MemberDAO mDAO = new MemberDAO();
			int memberId = list.get(i).getM_id();
			String m_account = mDAO.selectById(memberId).getM_account();
			list.get(i).setM_account(m_account);
		}

		request.setAttribute("account", account);
		request.setAttribute("VOlist", list);

		request.getRequestDispatcher("/PersonalMakeAWishList.jsp").forward(request, response);
		return;
	}

}