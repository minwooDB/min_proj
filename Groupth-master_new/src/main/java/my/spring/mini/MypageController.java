package my.spring.mini;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dao.FieldDAO;
import dao.MypageDAO;
import dao.UsersDAO;
import dao.Users_GroupDAO;
import service.ImageUploadService;
import vo.Login_InfoVO;
import vo.UsersVO;

@Controller
public class MypageController {
	@Autowired
	UsersDAO usersDAO;
	@Autowired
	Users_GroupDAO ugDAO;
	@Autowired
	FieldDAO Fielddao;
	@Autowired
	MypageDAO mypageDAO;
	@Autowired
	private ImageUploadService imageUploadService;
	
	@RequestMapping(value="/mypage", method = RequestMethod.GET)
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
		mav.addObject("myGroup", ugDAO.myGroup(user.getUser()));
		mav.addObject("showUser", usersDAO.showUser(user.getUser()));
		mav.addObject("field", Fielddao.ListAllType());
		mav.setViewName("mypage/myInfo");
		return mav;
	}
	@RequestMapping(value="/mypage/myInfo", method=RequestMethod.POST)
	public ModelAndView doPostMyInfo(UsersVO vo,String action,HttpSession session, MultipartFile image) throws IOException {
		ModelAndView mav = new ModelAndView();
		Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
		vo.setUsers_id(user.getUser());
		if(action!=null) {
			if(action.equals("change")) {
				usersDAO.change(vo);
				mav.addObject("msg","회원정보가 수정되었습니다.");
			}
			else if(action.equals("addInfo")) {
				String fileName=image.getOriginalFilename();
				if(!fileName.equals("")) {
					vo.setImg(fileName);
					imageUploadService.getUsersImagePath(image);
				}else {
					vo.setImg("smile.png");
				}
				usersDAO.addInfo(vo);
				mav.addObject("msg","정보가 추가되었습니다.");
			}
		}
		mav.setViewName("redirect:/mypage");
		return mav;
	}
	
	@RequestMapping(value="/mypage/deleteGroup", method=RequestMethod.GET)
	public ModelAndView deleteGroup(String gid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
		boolean result =mypageDAO.deleteGroup(gid,user.getUser());
		if(!result) {
			mav.addObject("msg","그룹장은 그룹 관리에서 그룹을 삭제할 수 있습니다.");
		}else {
			mav.addObject("msg","그룹에서 탈퇴 하였습니다.");
		}
		mav.setViewName("redirect:/mypage");
		return mav;
	}
}
