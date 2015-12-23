<#escape x as x?html>
  <#include "/WEB-INF/pages/inc/header.ftl">
<title><@s.text name="title"/></title>
  <#assign currentMenu = "manage"/>
  <#include "/WEB-INF/pages/inc/menu.ftl">
  <#include "/WEB-INF/pages/macros/forms.ftl"/>
  <#include "/WEB-INF/pages/macros/resourcesTable.ftl"/>
<script type="text/javascript" language="javascript" src="${baseURL}/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="${baseURL}/js/jquery/jquery.dataTables.js"></script>

  <@resourcesTable shownPublicly=false numResourcesShown=10 sEmptyTable="manage.home.resources.none" columnToSortOn=6 sortOrder="desc"/>

<div class="title-icon"><img src="${baseURL}/images/ico-title-add.svg" alt="<@s.text name="title"/>"></div>
<div id="new-resource" class="new-resource clearfix">
  <h1 class="rtableTitle"><@s.text name="manage.resource.create.title"/></h1>
  <#include "inc/create_new_resource.ftl"/>
</div>
<div class="title-icon"><img src="${baseURL}/images/ico-title-doc.svg" alt="<@s.text name="title"/>"></div>
<h1 class="rtableTitle"><@s.text name="manage.home.title"/></h1>
<div id="tableContainer"></div>

  <#include "/WEB-INF/pages/inc/footer.ftl">
</#escape>