package service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Service
public class FileUploadService {
	@Autowired
	ServletContext context;
	public FileUploadService() {
	}
	public boolean getFilePath(MultipartFile files) throws IOException {
		boolean result =false;
		String fileName =files.getOriginalFilename();
		File f = new File(context.getRealPath("/")+"resources/files/"+fileName);
		FileOutputStream fos = new FileOutputStream(f);
		fos.write(files.getBytes());
		fos.close();
		if(f.exists()) {
			result=true;
		}
		return result;
	}
}
