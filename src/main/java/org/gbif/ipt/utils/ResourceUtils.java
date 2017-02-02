package org.gbif.ipt.utils;

import org.gbif.api.model.common.DOI;
import org.gbif.ipt.model.Organisation;
import org.gbif.ipt.model.Resource;
import org.gbif.ipt.model.VersionHistory;
import org.gbif.metadata.eml.Eml;

import java.io.File;
import java.math.BigDecimal;
import java.util.Locale;
import java.util.UUID;
import javax.annotation.Nullable;
import javax.validation.constraints.NotNull;

import com.google.common.base.Preconditions;
import org.apache.log4j.Logger;

public class ResourceUtils {

  protected static final Logger LOG = Logger.getLogger(ResourceUtils.class);

  /*
   * Empty constructor.
   */
  private ResourceUtils() {
  }

  /**
   * Reconstruct published version, using version's Eml file, version history, etc.
   *
   * @param version version to assign to reconstructed resource
   * @param shortname shortname to assign to reconstructed resource
   * @param doi DOI to assign to reconstructed resource
   * @param organisation organisation to assign to reconstructed resource
   * @param versionHistory VersionHistory corresponding to resource version being reconstructed
   * @param versionEmlFile eml file corresponding to version of resource being reconstructed
   * @param key GBIF UUID to assign to reconstructed resource
   *
   * @return published version reconstructed
   */
  public static Resource reconstructVersion(@NotNull BigDecimal version, @NotNull String shortname, @Nullable DOI doi,
    @Nullable Organisation organisation, @Nullable VersionHistory versionHistory, @Nullable File versionEmlFile,
    @Nullable UUID key) {
    Preconditions.checkNotNull(version);
    Preconditions.checkNotNull(shortname);

    if (organisation == null || versionHistory == null || versionEmlFile == null) {
      throw new IllegalArgumentException(
        "Failed to reconstruct resource version because not all of organisation, version history, or version eml file were provided");
    }

    // initiate new version, and set properties
    Resource resource = new Resource();
    resource.setShortname(shortname);
    resource.setEmlVersion(version);
    resource.setDoi(doi);
    resource.setOrganisation(organisation);
    resource.setKey(key);
    resource.setStatus(versionHistory.getPublicationStatus());
    resource.setIdentifierStatus(versionHistory.getStatus());
    resource.setRecordsPublished(versionHistory.getRecordsPublished());
    resource.setLastPublished(versionHistory.getReleased());
    resource.setRecordsByExtension(versionHistory.getRecordsByExtension());

    if (versionEmlFile.exists()) {
      Eml eml = EmlUtils.loadWithLocale(versionEmlFile, Locale.US);
      resource.setEml(eml);
    } else {
      throw new IllegalArgumentException(
        "Failed to reconstruct resource: " + versionEmlFile.getAbsolutePath() + " not found!");
    }
    return resource;
  }

  /**
   * Assert that version b is greater than version a. Comparison must take into account major_version.minor_version
   * scheme, e.g. version 2.0 is greater than version 1.100, and version 1.100 is greater than 1.99.
   *
   * @param b version
   * @param a version
   *
   * @return true if version a is greater than version b, false otherwise
   */
  public static boolean assertVersionOrder(BigDecimal b, BigDecimal a) {
    if (a != null && b != null) {
      // comparison on major_version
      if (b.intValue() > a.intValue()) {
        return true;
      }
      // comparison on minor_version, if major_version was the same
      else if (b.intValue() == a.intValue()) {
        int scaleB = b.scale(); // 0.10 has a scale of 2
        BigDecimal scaledB = b.scaleByPowerOfTen(scaleB); // 0.10 * 10(2) = 10

        int scaleA = a.scale(); // 0.9 has a scale of 1
        BigDecimal scaledA = a.scaleByPowerOfTen(scaleA); // 0.9 * 10(1) = 9

        return scaledB.compareTo(scaledA) > 0;
      }
    }
    return false;
  }
}
