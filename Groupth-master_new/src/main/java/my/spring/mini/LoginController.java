package my.spring.mini;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.UsersDAO;
import vo.Login_InfoVO;
import vo.UsersVO;

@Controller
public class LoginController {

	@Autowired
	UsersDAO dao;
	
	@RequestMapping(value="/login", method= RequestMethod.GET)
	public String login(HttpSession session) {
		System.out.println("login");
		return "auth/login";
	}
	@RequestMapping(value="/loginProcess", method= RequestMethod.POST)
	public ModelAndView doLogin(String idVal, String pwdVal,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UsersVO user = dao.loginUser(idVal, pwdVal);
		String url;
		if(user!=null) {
			System.out.println("로그인 성공");
			Login_InfoVO loginInfo = new Login_InfoVO();
			loginInfo.setUser(user.getUsers_id());
			loginInfo.setUser_name(user.getName());
			session.setAttribute("loginUser", loginInfo);
			url = "redirect:/";
		}
		else {
			System.out.println("로그인 실패");
			url="redirect:/login";
		}
		mav.setViewName(url);
		return mav;
	}
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String doLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
