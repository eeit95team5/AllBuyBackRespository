package com.allbuyback.Pictures.model;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.allbuyback.Wishing_Pool.model.Wishing_PoolVO;

public interface PicturesDAOI {
	public void readPicture(HttpServletRequest request, HttpServletResponse response, int pic_id, int w_id) throws IOException;
}