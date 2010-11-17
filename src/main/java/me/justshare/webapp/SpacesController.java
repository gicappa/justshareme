package me.justshare.webapp;

import me.justshare.domain.SharedItem;
import me.justshare.service.StorageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

/**
 * $Id$
 *
 * @author Gian Carlo Pace <giancarlo.pace@gmail.com>
 */
@Controller
public class SpacesController {

	private transient Logger logger = LoggerFactory.getLogger(SpacesController.class);

	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public String handleSpaces(@RequestParam("space") String space, @RequestParam("password") String password) {
		logger.debug("New space creation requested is {}", space);
		StorageService storageService = new StorageService();
		if (storageService.existSpace(space)) {
			return "failure";
		}
		storageService.createSpace(space, password);
		return "success";
	}

	@RequestMapping(value = "/login/{space}", method = RequestMethod.POST)
	public String login(@PathVariable("space") String space, @RequestParam("password") String password, HttpServletRequest request) {
		logger.info("Logging into space {}", space);
		StorageService storageService = new StorageService();

		if (!storageService.existSpace(space)) {
			return "failure";
		}

		if (!storageService.isPasswordCorrect(space, password)) {
			return "failure";
		}

		HttpSession session = request.getSession(true);
		session.setAttribute("LOGGED_IN", true);
		return "success";
	}

	@RequestMapping(value = "/{space}", method = RequestMethod.GET)
	public String handleSpaces(@PathVariable("space") String space, HttpServletRequest request) {
		logger.debug("Space requested is {0}", space);
		StorageService storageService = new StorageService();
		List<SharedItem> itemList = storageService.listSharedItems(space, 0);
		request.setAttribute("space", space);
		request.setAttribute("sharedItems", itemList);
		return "share";
	}

	@RequestMapping(value = "/upload/{space}", method = RequestMethod.POST)
	public String handleFormUpload(@PathVariable("space") String space,
								   @RequestParam("description") String description,
								   @RequestParam("Filename") String filename,
								   @RequestParam("Filedata") MultipartFile file,
								   HttpServletRequest request) {

		logger.info("Uploading a file name into {}", space);
		StorageService storageService = new StorageService();
		
		if (!isLoggedIn(request)) {
			return "failure";
		}

		try {

			if (file.isEmpty())
				return "failure";

			storageService.store(space, new ByteArrayInputStream(file.getBytes()), filename, description);

		} catch (IOException e) {
			logger.error("ERROR while uploading a file named " + filename, e);
		}
		return "success";
	}

	private boolean isLoggedIn(HttpServletRequest request) {
		return loggedIn(request) != null && ((Boolean) loggedIn(request));
	}

	private Object loggedIn(HttpServletRequest request) {
		return request.getSession().getAttribute("LOGGED_IN");
	}

	@RequestMapping(value = "/status/{space}", method = RequestMethod.POST)
	public String handleFormUpload(@PathVariable("space") String space,
								   @RequestParam("description") String description,
								   HttpServletRequest request) {

		logger.info("Uploading a file name into {}", space);

		if (!isLoggedIn(request)) {
			return "failure";
		}

		StorageService storageService = new StorageService();
		storageService.store(space, null, "status", description);
		return "success";
	}
}
