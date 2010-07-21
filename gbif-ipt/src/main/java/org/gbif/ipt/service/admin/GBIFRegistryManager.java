/**
 * 
 */
package org.gbif.ipt.service.admin;

import java.net.URL;
import java.util.List;

import org.gbif.ipt.model.registry.BriefOrganisation;
import org.gbif.ipt.service.admin.impl.GBIFRegistryManagerImpl;

import com.google.inject.ImplementedBy;

/**
 * This interface details ALL methods associated with the GBIF Registry.
 *  
 * @author tim
 * @author josecuadra
 */
@ImplementedBy(GBIFRegistryManagerImpl.class)
public interface GBIFRegistryManager {

	/**
	 * Calls the central registry to receive a list of the Organisations that are
	 * available
	 * 
	 * @return The list of all available organisations
	 */
	public List<BriefOrganisation> listAllOrganisations();


	/**
	 * @return URL to the json list of registered dwc extensions in GBIF
	 */
	public URL getExtensionListUrl();	  
}