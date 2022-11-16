package it.prova.gestionesatelliti.web.controller;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.prova.gestionesatelliti.model.Satellite;
import it.prova.gestionesatelliti.model.StatoSatellite;
import it.prova.gestionesatelliti.service.SatelliteService;

@Controller
@RequestMapping(value = "/satellite")
public class SatelliteController {

	@Autowired
	private SatelliteService satelliteService;

	@GetMapping("/search")
	public String search() {
		return "satellite/search";

	}

	@GetMapping("/insert")
	public String create(Model model) {
		model.addAttribute("insert_satellite_attr", new Satellite());
		return "satellite/insert";
	}

	@PostMapping("/list")
	public String listByExample(Satellite example, ModelMap model) {
		List<Satellite> result = satelliteService.findByExample(example);
		model.addAttribute("satellite_list_attribute", result);
		return "satellite/list";
	}

	@PostMapping("/save")
	public String save(@Valid @ModelAttribute("insert_satellite_attr") Satellite satellite, BindingResult result,
			RedirectAttributes redirectAttrs) {

		if (result.hasErrors())
			return "satellite/insert";

		
		// validazione input
		if (satellite.getDataLancio() == null && satellite.getDataRientro() != null) {
			result.rejectValue("dataLancio", "satellite.error.dataLancio.invalid");
			return "satellite/insert";
		}
		if (satellite.getDataRientro() != null && satellite.getDataRientro() != null
				&& satellite.getDataLancio().after(satellite.getDataRientro())) {
			result.rejectValue("dataLancio", "satellite.error.dataLancioRientro.invalid");
			result.rejectValue("dataRientro", "satellite.error.dataLancioRientro.invalid");
			return "satellite/insert";
		}
		if (satellite.getDataLancio() != null && satellite.getDataLancio().after(new Date())
				&& (satellite.getStato().equals((StatoSatellite.IN_MOVIMENTO))
						|| satellite.getStato().equals(StatoSatellite.FISSO))) {
			result.rejectValue("stato", "satellite.error.stato.invalid");
			return "satellite/insert";
		}
		if (satellite.getDataLancio() != null && satellite.getDataRientro() != null
				&& satellite.getDataLancio().before(new Date()) && satellite.getDataRientro().before(new Date())
				&& !satellite.getStato().equals(null) && !(satellite.getStato().equals(StatoSatellite.DISATTIVATO))) {
			result.rejectValue("stato", "satellite.error.stato.invalid");
			return "satellite/insert";
		}

		// inserimento
		satelliteService.inserisciNuovo(satellite);
		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente!");
		return "redirect:/";
	}

	@GetMapping("/show/{idSatellite}")
	public String show(@PathVariable(required = true) Long idSatellite, Model model) {
		model.addAttribute("show_satellite_attr", satelliteService.caricaSingoloElemento(idSatellite));
		return "satellite/show";
	}

	@GetMapping("/delete/{idSatellite}")
	public String prepareDelete(@PathVariable(required = true) Long idSatellite, Model model) {
		model.addAttribute("delete_satellite_attr", satelliteService.caricaSingoloElemento(idSatellite));
		return "satellite/delete";
	}

	@PostMapping("/deleteEx")
	public String delete(@RequestParam(required = true) Long idSatellite, RedirectAttributes redirectAttrs) {

		Satellite satelliteInstance = satelliteService.caricaSingoloElemento(idSatellite);

		if (satelliteInstance.getStato().equals(StatoSatellite.FISSO)
				|| satelliteInstance.getStato().equals(StatoSatellite.IN_MOVIMENTO)) {
			redirectAttrs.addFlashAttribute("errorMessage", "Non puoi cancellare un satellite che non sia disattivato!!!");
			return "redirect:/";
		}

		satelliteService.rimuovi(idSatellite);
		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente!");
		return "redirect:/";
	}

	@GetMapping("/edit/{idSatellite}")
	public String prepareUpdate(@PathVariable(required = true) Long idSatellite, Model model) {
		model.addAttribute("update_satellite_attr", satelliteService.caricaSingoloElemento(idSatellite));
		return "satellite/update";
	}

	@PostMapping("/editEx")
	public String update(@Valid @ModelAttribute("update_satellite_attr") Satellite satellite, BindingResult result,
			RedirectAttributes redirectAttrs) {

		if (result.hasErrors())
			return "satellite/edit";

		satelliteService.aggiorna(satellite);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente!");
		return "redirect:/";
	}
	
	@GetMapping("/lanciatiDaPiuDiDueAnni")
	public ModelAndView lanciatiDaPiuDiDueAnni() {
		ModelAndView mv = new ModelAndView();
		List<Satellite> results = satelliteService.listAllLanciatiDaPiuDiDueAnni();
		mv.addObject("satellite_list_attribute", results);
		mv.setViewName("satellite/list");
		return mv;
	}
	
	@GetMapping("/disattivatiMaNonRientrati")
	public ModelAndView disattivatiMaNonRientrati() {
		ModelAndView mv = new ModelAndView();
		List<Satellite> results = satelliteService.listAllDisattivatiMaNonRientrati();
		mv.addObject("satellite_list_attribute", results);
		mv.setViewName("satellite/list");
		return mv;
	}

}
