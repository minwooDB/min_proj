package my.spring.mini;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dao.NoticeDAO;
import service.FileUploadService;
import vo.NoticeVO;

@Controller
public class NoticeController {
	@Autowired
	NoticeDAO dao;
	@Autowired
	private FileUploadService fileUploadService;
	
	@RequestMapping(value="/group/content/write", method=RequestMethod.GET)
	public ModelAndView doGetNotice() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/nedit");
		return mav;
	}
	
	@RequestMapping(value="/group/content/write", method=RequestMethod.POST)
	public ModelAndView doPostNotice(NoticeVO vo,MultipartFile file,String gid) throws IOException {
		ModelAndView mav = new ModelAndView();
		String fileName=file.getOriginalFilename();
		System.out.println(fileName);
		if(!fileName.equals("")) {
			vo.setFiles(fileName);
			fileUploadService.getFilePath(file);
		}
		if(dao.writeNotice(vo)) {
			System.out.println("notice성공");
		}
		else {
			System.out.println("실패");
		}
		mav.setViewName("redirect:/group/content?gid="+gid);
		//mav.setViewName("redirect:/group");
		return mav;
	}
}
