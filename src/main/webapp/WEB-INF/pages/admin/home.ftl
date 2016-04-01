<#include "/WEB-INF/pages/inc/header.ftl">
 <title><@s.text name="title"/></title>
<script type="text/javascript">
	$(document).ready(function(){
		initHelp();
	});
</script>

<#assign currentMenu = "admin"/>
<#include "/WEB-INF/pages/inc/menu.ftl">
<div>
<!-- -->
<div class="adm-wrapper">
<div class="adm-row clearfix">
  <!-- SETTINGS -->
  <div class="width33">
    <div class="adm-item">
      <@s.form cssClass="topForm" action="publishAll.do" method="post" namespace="" includeContext="false">
      <div class="adm-icon"><a href="${baseURL}/admin/config.do"><img src="${baseURL}/images/icons/n-settings.svg" /></a></div>
      <div class="adm-text"><@s.text name="admin.home.editConfig"/>
	  <img class="infoImg" src="${baseURL}/images/info.gif" />
	  <div class="info"><@s.text name="admin.home.publishResources.help"/></div>
	  <br><@s.submit cssClass="button" name="publishAll" key="admin.home.publishResources"/></div>
      </@s.form>
    </div>
  </div>
  <!-- USERS -->
  <div class="width33">
    <div class="adm-item">
      <div class="adm-icon"><a href="${baseURL}/admin/users.do"><img src="${baseURL}/images/icons/n-users.svg" /></a></div>
      <div class="adm-text"><@s.text name="admin.home.manageUsers"/></div>
    </div>
  </div>
  <!-- ORGANIZATIONS -->
  <div class="width33">
    <div class="adm-item">
      <div class="adm-icon"><#if registeredIpt?has_content>
				<a href="${baseURL}/admin/organisations.do"><img src="${baseURL}/images/icons/n-organisation.svg" /></a>
		  <#else>
				<img src="${baseURL}/images/icons/n-organisation-grey.svg" />
		  </#if></div>
      <div class="adm-text"><@s.text name="admin.home.editOrganisations"/>
		<#if !registeredIpt?has_content><div id="un-registered"><@s.text name="admin.home.editOrganisations.disabled"/></div></#if></div>
    </div>
  </div>
</div>

<div class="adm-row clearfix">
  <!-- LOGS -->
  <div class="width33">
    <div class="adm-item">
      <div class="adm-icon"><a href="${baseURL}/admin/logs.do"><img src="${baseURL}/images/icons/n-announcement.svg" /></a></div>
      <div class="adm-text"><@s.text name="admin.home.manageLogs"/></div>
    </div>
  </div>
  <!-- REGISTRATION -->
  <div class="width33">
    <div class="adm-item">
      <div class="adm-icon"><a href="${baseURL}/admin/registration.do"><img src="${baseURL}/images/icons/n-registry.svg" /></a></div>
      <div class="adm-text"><@s.text name="admin.home.editRegistration"/></div>
    </div>
  </div>
  <!-- EXTENSIONS -->
  <div class="width33">
    <div class="adm-item">
      <div class="adm-icon"><a href="${baseURL}/admin/extensions.do"><img src="${baseURL}/images/icons/n-extensions.svg" /></a></div>
      <div class="adm-text"><@s.text name="admin.home.manageExtensions"/></div>
    </div>
  </div>
</div>
</div>
<!-- -->
</div>
</div>
<#include "/WEB-INF/pages/inc/footer.ftl">