package com.allbuyback.AllBuyBack.model.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.allbuyback.AllBuyBack.model.Keep_ShopBean;
import com.allbuyback.AllBuyBack.model.Keep_ShopService;

@Controller
@RequestMapping(path={"/keep_shop.SPRINGcontroller"})                          
public class Keep_ShopController {
	
	@Autowired
	private Keep_ShopService keep_ShopService;
	
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST })
	public void doGet(Keep_ShopBean keep_ShopBean, BindingResult bindingResult, Model model,
			HttpServletRequest request, HttpServletResponse response,String action) {
		
		Map<String, String> errors = new HashMap<String, String>();		
		model.addAttribute("errors", errors);
		
		if(bindingResult.hasErrors()){
			errors.put("keepshoperror", "某處發生了問題，請正常操作");
			return;
		}
				
		if("Insert".equals(action)){
			keep_ShopService.insert(keep_ShopBean);
			long i = keep_ShopService.selectKeepCount(keep_ShopBean.getS_id());
			this.getKeepShopCount(request, response, i);
			return;
		}
		
		if("Select".equals(action)){
			List<Keep_ShopBean> result = keep_ShopService.select(keep_ShopBean.getM_id());
			this.getJSON(request, response, result);
		}
		
		if("SelectByS_Id".equals(action)){
			List<Keep_ShopBean> result = keep_ShopService.selectByS_Id(keep_ShopBean.getS_id());
			this.getJSON(request, response, result);
		}
		
		if("Delete".equals(action)){
			keep_ShopService.delete(keep_ShopBean);
			return;
		}
	}
	private void getKeepShopCount(HttpServletRequest request, HttpServletResponse response,long count){
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(count);
	} 
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void getJSON(HttpServletRequest request, HttpServletResponse response,List<Keep_ShopBean> result){
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		

		
		List l1 = new LinkedList();
		for(int i=0;i < result.size();i++){
			Map m1 = new HashMap();
			m1.put("m_id", String.valueOf(result.get(i).getM_id()));
			m1.put("s_id", String.valueOf(result.get(i).getS_id()));
			l1.add(m1);
		}
		
		Map m2 = new HashMap();
		m2.put("result", l1);
		String jsonString = JSONValue.toJSONString(m2);
		System.out.println(jsonString);
		out.println(jsonString);
	}
}
