package my.spring.mini;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.GroupDAO;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	GroupDAO dao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("popularGroup", dao.popularGroup());
		mav.setViewName("home");
		return mav;
	}
}
