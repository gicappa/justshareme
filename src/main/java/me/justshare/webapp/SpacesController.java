package me.justshare.webapp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * $Id$
 *
 * @author Gian Carlo Pace <giancarlo.pace@gmail.com>
 */
@Controller
@RequestMapping("/api")
public class SpacesController {

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String handleFormUpload(@RequestParam("name") String name,
								   @RequestParam("file") MultipartFile file) {
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
			} catch (IOException e) {
				e.printStackTrace();  
			}
			System.out.println("name : " + name);
			return "redirect:uploadSuccess";
		} else {
			return "redirect:uploadFailure";
		}
	}
}
