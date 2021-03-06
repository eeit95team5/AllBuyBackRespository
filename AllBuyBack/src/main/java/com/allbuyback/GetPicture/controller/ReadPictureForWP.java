package com.allbuyback.GetPicture.controller;

import java.io.IOException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.allbuyback.GetPicture.model.PicturesDAO;

@WebServlet("/ReadPictureForWP")
public class ReadPictureForWP extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int pic_id = Integer.parseInt(request.getParameter("pic_id"));
		int w_id = Integer.parseInt(request.getParameter("w_Id"));
		
		PicturesDAO pDAO = new PicturesDAO();
		pDAO.readPictureForWishing_Pool(response, pic_id, w_id);
		
	}

}
