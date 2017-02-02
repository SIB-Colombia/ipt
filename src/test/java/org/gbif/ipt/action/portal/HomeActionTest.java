package org.gbif.ipt.action.portal;


import org.gbif.ipt.config.AppConfig;
import org.gbif.ipt.config.DataDir;
import org.gbif.ipt.model.Organisation;
import org.gbif.ipt.model.Resource;
import org.gbif.ipt.model.VersionHistory;
import org.gbif.ipt.model.voc.PublicationStatus;
import org.gbif.ipt.service.admin.RegistrationManager;
import org.gbif.ipt.service.admin.VocabulariesManager;
import org.gbif.ipt.service.manage.ResourceManager;
import org.gbif.ipt.struts2.SimpleTextProvider;
import org.gbif.utils.file.FileUtils;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import com.google.common.collect.Lists;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class HomeActionTest {

  private HomeAction action;
  private static final Date MODIFIED = new Date();
  private static final Date NEXT_PUBLISHED = new Date();
  private static final Date LAST_PUBLISHED = new Date();
  private static final BigDecimal VERSION_ONE_THREE_FOUR = new BigDecimal("1.34");
  private static final int RECORDS_PUBLISHED = 1000;
  private static Organisation organisation = new Organisation();

  @Before
  public void setup() throws IOException {
    organisation.setName("NHM");

    // construct public resource having one public published version 1.34
    Resource p = new Resource();
    p.setShortname("res");
    p.setTitle("Danish Lepidoptera"); // different than version 1.34
    p.setModified(new Date()); // different than version 1.34
    p.setNextPublished(NEXT_PUBLISHED);
    p.setLastPublished(LAST_PUBLISHED);
    p.setEmlVersion(VERSION_ONE_THREE_FOUR);
    p.setStatus(PublicationStatus.PUBLIC);
    VersionHistory vh = new VersionHistory(VERSION_ONE_THREE_FOUR, LAST_PUBLISHED, PublicationStatus.PUBLIC);
    vh.setRecordsPublished(RECORDS_PUBLISHED);
    p.addVersionHistory(vh);
    p.setRecordsPublished(999999); // different than version 1.34
    p.setOrganisation(organisation);

    List<Resource> publishedPublic = Lists.newArrayList();
    publishedPublic.add(p);

    ResourceManager resourceManager = mock(ResourceManager.class);
    when(resourceManager.listPublishedPublicVersions()).thenReturn(publishedPublic);
    when(resourceManager.get(anyString())).thenReturn(p);

    AppConfig appConfig = mock(AppConfig.class);
    DataDir dataDir = mock(DataDir.class);
    // retrieve eml.xml file corresponding to version 1.34
    File emlXMLv134 = FileUtils.getClasspathFile("resources/res1/eml.xml");
    when(dataDir.resourceEmlFile(anyString(), any(BigDecimal.class))).thenReturn(emlXMLv134);
    when(appConfig.getDataDir()).thenReturn(dataDir);

    action = new HomeAction(mock(SimpleTextProvider.class), appConfig, mock(RegistrationManager.class), resourceManager,
      mock(VocabulariesManager.class));

    action.setServletRequest(mock(HttpServletRequest.class));
  }

  /**
   * Test ensures home resources table shows properties of last public published version, not current (unpublished)
   * version. For example, if user has modified resource title but not republished it, this shouldn't show in the
   * home resource table. Instead, the title of the last public published version should show instead.
   */
  @Test
  public void testPrepare() {
    action.prepare();
    assertEquals(1, action.getResources().size());
    // assert title and other properties come from 1.34 eml file, not the same as current (unpublished) resource
    Resource returned = action.getResources().get(0);
    assertEquals("TEST RESOURCE", returned.getTitle());
    assertEquals(LAST_PUBLISHED, returned.getLastPublished());
    assertEquals(VERSION_ONE_THREE_FOUR, returned.getEmlVersion());
    assertEquals(RECORDS_PUBLISHED, returned.getRecordsPublished());
    // assert modified date and other properties the same as current (unpublished) resource
    assertNotEquals(MODIFIED, returned.getModified());
    assertEquals(NEXT_PUBLISHED, returned.getNextPublished());
    assertEquals(organisation.getName(), returned.getOrganisation().getName());
  }

}
