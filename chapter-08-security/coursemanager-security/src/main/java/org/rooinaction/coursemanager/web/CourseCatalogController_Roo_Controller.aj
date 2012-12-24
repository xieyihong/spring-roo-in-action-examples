// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.coursemanager.web;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.rooinaction.coursemanager.domain.CourseCatalog;
import org.rooinaction.coursemanager.web.CourseCatalogController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect CourseCatalogController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String CourseCatalogController.create(@Valid CourseCatalog courseCatalog, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, courseCatalog);
            return "coursecatalogs/create";
        }
        uiModel.asMap().clear();
        courseCatalog.persist();
        return "redirect:/coursecatalogs/" + encodeUrlPathSegment(courseCatalog.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String CourseCatalogController.createForm(Model uiModel) {
        populateEditForm(uiModel, new CourseCatalog());
        return "coursecatalogs/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String CourseCatalogController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("coursecatalog", CourseCatalog.findCourseCatalog(id));
        uiModel.addAttribute("itemId", id);
        return "coursecatalogs/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String CourseCatalogController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("coursecatalogs", CourseCatalog.findCourseCatalogEntries(firstResult, sizeNo));
            float nrOfPages = (float) CourseCatalog.countCourseCatalogs() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("coursecatalogs", CourseCatalog.findAllCourseCatalogs());
        }
        return "coursecatalogs/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String CourseCatalogController.update(@Valid CourseCatalog courseCatalog, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, courseCatalog);
            return "coursecatalogs/update";
        }
        uiModel.asMap().clear();
        courseCatalog.merge();
        return "redirect:/coursecatalogs/" + encodeUrlPathSegment(courseCatalog.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String CourseCatalogController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, CourseCatalog.findCourseCatalog(id));
        return "coursecatalogs/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String CourseCatalogController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        CourseCatalog courseCatalog = CourseCatalog.findCourseCatalog(id);
        courseCatalog.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/coursecatalogs";
    }
    
    void CourseCatalogController.populateEditForm(Model uiModel, CourseCatalog courseCatalog) {
        uiModel.addAttribute("courseCatalog", courseCatalog);
    }
    
    String CourseCatalogController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
