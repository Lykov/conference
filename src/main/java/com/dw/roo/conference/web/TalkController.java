package com.dw.roo.conference.web;
import com.dw.roo.conference.domain.Talk;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/talks")
@Controller
@RooWebScaffold(path = "talks", formBackingObject = Talk.class)
public class TalkController {
}
