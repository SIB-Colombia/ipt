<#escape x as x?html>
<#include "/WEB-INF/pages/inc/header.ftl">
<title><@s.text name='manage.metadata.project.title'/></title>
<#assign sideMenuEml=true />
<#assign currentMenu="manage"/>
<script type="text/javascript">
	$(document).ready(function(){
		initHelp();
	});
</script>
<#assign sideMenuEml=false />
<#assign sideMenuAlt=true />
<#include "/WEB-INF/pages/inc/menu.ftl">
<#include "/WEB-INF/pages/macros/forms.ftl"/>
<#include "/WEB-INF/pages/macros/metadata_agent.ftl"/>
<div class="title-icon"><img src="${baseURL}/images/ico-title-doc.svg" alt="<@s.text name="title"/>"></div>

<div class="superscript no-display"><@s.text name='manage.overview.title.label'/></div>
<h1 class="rtableTitle resource-title">
    <a href="resource.do?r=${resource.shortname}" title="${resource.title!resource.shortname}">${resource.title!resource.shortname}</a>
</h1>
<div class="metadata-intro">
<h2 class="subTitle"><@s.text name='manage.metadata.project.title'/></h2>
<p><@s.text name='manage.metadata.project.intro'/></p>
</div>
<!------ SIDEBAR ------->
<#if sideMenuAlt!false??>
<aside class="side">
			<div class="clearfix sidebar" id="side">
				<h2><@s.text name='manage.metadata.section' /></h2>
				<ul class="sidebarlist">
				<#list ["basic", "geocoverage", "taxcoverage","tempcoverage", "keywords", "parties", "project", "methods", "citations", "collections", "physical", "additional"] as it>
				 <li<#if currentSideMenu?? && currentSideMenu==it> class="current"<#else> class="sideitem"</#if>><a href="metadata-${it}.do?r=${resource.shortname!r!}"><@s.text name="submenu.${it}"/></a></li>
				</#list>
				</ul>
			</div>
			</aside>
</#if>
<!------ / SIDEBAR ------->
<div class="grid_17 suffix_1 resource-wrapper">
<form class="topForm" action="metadata-${section}.do" method="post">

  <!-- retrieve some link names one time -->
  <#assign copyLink><@s.text name="eml.resourceCreator.copyLink"/></#assign>
  <#assign removeLink><@s.text name='manage.metadata.removethis'/> <@s.text name='rtf.project.personnel'/></#assign>
  <#assign addLink><@s.text name='manage.metadata.addnew'/> <@s.text name='rtf.project.personnel'/></#assign>

	<@input name="eml.project.title" requiredField=true/>
  <@input name="eml.project.identifier" help="i18n"/>
  <@text name="eml.project.description" help="i18n"/>
  <@text name="eml.project.funding" help="i18n"/>
	<@text name="eml.project.studyAreaDescription.descriptorValue" help="i18n" />
	<@text name="eml.project.designDescription" help="i18n" />
    
  <div class="listBlock"></div>
  
  <!-- List of personnel -->
  <div class="listBlock grid_17 suffix_1">
  <@textinline name="eml.project.personnel" help="i18n"/>
      <div id="personnel-items">
        <#list eml.project.personnel as item>
            <div id="personnel-item-${item_index}" class="item clearfix">
                <div class="columnLinks">
                    <div class="halfcolumn">
                        <a id="personnel-copyDetails-${item_index}" href="">${copyLink?lower_case?cap_first}</a>
                    </div>
                    <div class="halfcolumn">
                        <a id="personnel-removeLink-${item_index}" class="removePersonnelLink" href=""><img src="${baseURL}/images/remove-meta.svg" width="16" alt="Remove"> ${removeLink?lower_case?cap_first}</a>
                    </div>
                </div>
                <div class="halfcolumn">
                  <@input name="eml.project.personnel[${item_index}].firstName" i18nkey="eml.project.personnel.firstName"/>
                </div>
                <div class="halfcolumn">
                  <@input name="eml.project.personnel[${item_index}].lastName" i18nkey="eml.project.personnel.lastName" requiredField=true/>
                </div>
                <div class="halfcolumn">
                  <#if eml.project.personnel[item_index]?? && eml.project.personnel[item_index].userIds[0]??>
                    <@select name="eml.project.personnel[${item_index}].userIds[0].directory" help="i18n" options=userIdDirectories i18nkey="eml.contact.directory" value="${eml.project.personnel[item_index].userIds[0].directory!}"/>
                  <#else>
                    <@select name="eml.project.personnel[${item_index}].userIds[0].directory" help="i18n" options=userIdDirectories i18nkey="eml.contact.directory" value=""/>
                  </#if>
                </div>
                <div class="halfcolumn">
                  <@input name="eml.project.personnel[${item_index}].userIds[0].identifier" help="i18n" i18nkey="eml.contact.identifier" />
                </div>
                <div class="halfcolumn">
                  <@select name="eml.project.personnel[${item_index}].role" i18nkey="eml.associatedParties.role" help="i18n" value="${eml.project.personnel[item_index].role!}" options=roles />
                </div>
            </div>
        </#list>
      </div>
      <div class="addNew"><a id="plus-personnel" href=""><img src="${baseURL}/images/add-meta.svg" width="16" alt="Add"> ${addLink?lower_case?cap_first}</a></div>
  </div>
	<div class="buttons meta-buttons">
  		<@s.submit cssClass="button" name="save" key="button.save" />
  		<@s.submit cssClass="button" name="cancel" key="button.cancel" />
	</div>
	<!-- internal parameter -->
	<input name="r" type="hidden" value="${resource.shortname}" />
</form>
</div>

<div id="baseItem-personnel" class="item clearfix" style="display:none;">
    <div class="columnLinks">
        <div class="halfcolumn">
            <a id="personnel-copyDetails" href="">${copyLink}</a>
        </div>
        <div class="halfcolumn">
            <a id="personnel-removeLink" class="removePersonnelLink" href=""><img src="${baseURL}/images/remove-meta.svg" width="16" alt="Remove"> ${removeLink?lower_case?cap_first}</a>
        </div>
    </div>
    <div class="halfcolumn">
      <@input name="firstName" i18nkey="eml.project.personnel.firstName" />
    </div>
    <div class="halfcolumn">
      <@input name="lastName" i18nkey="eml.project.personnel.lastName" requiredField=true />
    </div>
    <div class="halfcolumn">
      <@select name="directory" options=userIdDirectories help="i18n" i18nkey="eml.contact.directory" />
    </div>
    <div class="halfcolumn">
      <@input name="identifier" help="i18n" i18nkey="eml.contact.identifier" />
    </div>
    <div class="halfcolumn">
      <@select name="role" i18nkey="eml.associatedParties.role" help="i18n" options=roles />
    </div>
</div>

<#include "/WEB-INF/pages/inc/footer.ftl">
</#escape>
