// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.web;

import com.dw.roo.conference.domain.Speaker;
import com.dw.roo.conference.domain.Talk;
import com.dw.roo.conference.web.TalkController;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect TalkController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String TalkController.create(@Valid Talk talk, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, talk);
            return "talks/create";
        }
        uiModel.asMap().clear();
        talk.persist();
        return "redirect:/talks/" + encodeUrlPathSegment(talk.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String TalkController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Talk());
        List<String[]> dependencies = new ArrayList<String[]>();
        if (Speaker.countSpeakers() == 0) {
            dependencies.add(new String[] { "speaker", "speakers" });
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "talks/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String TalkController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("talk", Talk.findTalk(id));
        uiModel.addAttribute("itemId", id);
        return "talks/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String TalkController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("talks", Talk.findTalkEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Talk.countTalks() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("talks", Talk.findAllTalks(sortFieldName, sortOrder));
        }
        return "talks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String TalkController.update(@Valid Talk talk, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, talk);
            return "talks/update";
        }
        uiModel.asMap().clear();
        talk.merge();
        return "redirect:/talks/" + encodeUrlPathSegment(talk.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String TalkController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Talk.findTalk(id));
        return "talks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String TalkController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Talk talk = Talk.findTalk(id);
        talk.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/talks";
    }
    
    void TalkController.populateEditForm(Model uiModel, Talk talk) {
        uiModel.addAttribute("talk", talk);
        uiModel.addAttribute("speakers", Speaker.findAllSpeakers());
    }
    
    String TalkController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
