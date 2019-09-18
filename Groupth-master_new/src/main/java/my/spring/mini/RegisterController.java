package my.spring.mini;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.UsersDAO;
import vo.UsersVO;

@Controller
public class RegisterController {
	@Autowired
	UsersDAO dao;
	
	@RequestMapping(value="/register", method= RequestMethod.GET)
	public String register() {
		System.out.println("register");
		return "auth/register";
	}
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public ModelAndView doRegister(UsersVO vo) {
		ModelAndView mav = new ModelAndView();
		boolean result= dao.insert(vo);
		if(result)
			System.out.println("성공적으로 가입되었습니다.");
		else
			System.out.println(" 가입 실패하었습니다.");
		
		mav.setViewName("redirect:/");
		return mav;
	}
	@RequestMapping(value = "/idDuplChk" , method = RequestMethod.GET)
	public @ResponseBody int idDuplChk(String users_id , Model model) throws Exception{
	   System.out.println(users_id);
	   int result = dao.idDuplChk(users_id);
	   System.out.println(result);
	   return result; 
	    
	}
}
