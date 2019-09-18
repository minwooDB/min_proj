package my.spring.mini;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.BoardDAO;
import dao.CommentDAO;
import vo.BoardVO;
import vo.CommentVO;
import vo.Login_InfoVO;

@Controller
public class BoardController {
	@Autowired
	BoardDAO dao;
	@Autowired
	CommentDAO commentDAO;

	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public ModelAndView doGet(String action, String newsid, String writer, String key, String searchType) {
		ModelAndView mav = new ModelAndView();

		if (action != null) {
			if (action.equals("search")) {
				mav.addObject("list", dao.search(key, searchType));
				mav.setViewName("board/board");
				return mav;
			} else if (action.equals("listwriter")) {
				mav.addObject("list", dao.listWriter(writer));
				mav.setViewName("board/board");
				return mav;
			}
		}
		mav.addObject("list", dao.listAll());
		mav.setViewName("board/board");
		return mav;
	}


	@RequestMapping(value = "/board/content", method = RequestMethod.GET)
	public ModelAndView goContent(String action,String bid) {
		ModelAndView mav = new ModelAndView();

		if (action.equals("read")) {
			mav.addObject("listone", dao.listOne(Integer.valueOf(bid)));
			mav.addObject("listComments", commentDAO.listComments(bid));
		}else if (action.equals("delete")) {
			dao.delete(Integer.valueOf(bid));
			mav.addObject("msg", "게시물을 삭제하였습니다.");
			mav.addObject("list", dao.listAll());
			mav.setViewName("redirect:/board");
			return mav;
		}
		mav.setViewName("board/boardContent");
		return mav;
	}
	@RequestMapping(value = "/board/content", method = RequestMethod.POST)
	public ModelAndView doReply(HttpSession session, CommentVO vo,String bid,String writer, String action ) {
		ModelAndView mav = new ModelAndView();
		Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
		vo.setWriter(user.getUser());
		commentDAO.insertReply(vo);
		mav.setViewName("redirect:/board/content?bid="+bid+"&writer="+writer+"&action="+action);
		return mav;
	}
	
	
	@RequestMapping(value="/board/content/edit", method=RequestMethod.GET)
	public ModelAndView doGetEdit(BoardVO vo, String action) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("board/edit");
		return mav;
	}
	@RequestMapping(value="/board/content/edit", method=RequestMethod.POST)
	public ModelAndView doPostEdit(BoardVO vo, String action) {
		ModelAndView mav = new ModelAndView();
		
		if (action.equals("insert")) {
			dao.insert(vo);
		}
		else if(action.equals("update")) {
			dao.update(vo);
		}
		mav.addObject("list", dao.listAll());
		mav.setViewName("redirect:/board");
		return mav;
	}
}
