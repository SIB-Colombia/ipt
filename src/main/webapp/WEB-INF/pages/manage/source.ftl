<#escape x as x?html>
<#include "/WEB-INF/pages/inc/header.ftl">
	<title><@s.text name='manage.source.title'/></title>
	<script type="text/javascript" src="${baseURL}/js/jconfirmation.jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initHelp();
	$('.confirm').jConfirmAction({question : "<@s.text name="manage.source.confirmation.message"/>", yesAnswer : "<@s.text name="basic.yes"/>", cancelAnswer : "<@s.text name="basic.no"/>"});
	$("#peekBtn").click(function(e) {
		e.preventDefault();
		$("#modalcontent").load("peek.do?r=${resource.shortname}&id=${id!}");
		$("#modalbox").show();
    });
	$("#modalbox").click(function(e) {
		e.preventDefault();
		$("#modalbox").hide();
    });
});   
</script>	
 <#assign currentMenu = "manage"/>
<#include "/WEB-INF/pages/inc/menu.ftl">
<#include "/WEB-INF/pages/macros/forms.ftl"/>
<div class="title-icon"><img src="${baseURL}/images/ico-title-doc.svg" alt="<@s.text name="title"/>"></div>
<h1 class="rtableTitle resource-title">
    <a href="resource.do?r=${resource.shortname}" title="${resource.title!resource.shortname}">${resource.title!resource.shortname}</a>
</h1>
<div class="metadata-intro">
</div>
<h2 class="subTitle"><@s.text name='manage.source.title'/></h2>
<p><@s.text name='manage.source.intro'/></p>
<div class="grid_24">
<form class="topForm" action="source.do" method="post">
<div class="source-data clearfix">
  	<input type="hidden" name="r" value="${resource.shortname}" />
  	<input type="hidden" name="id" value="${id!}" />  	

    <#if source??>
      <div class="clearfix">
        <div class="halfcolumn">
          <@input name="source.name" help="i18n" disabled=id?has_content/>
        </div>
        <#if source.fieldsTerminatedBy?has_content>
        <div class="halfcolumn">
          <div class="file-label"><@s.text name='manage.source.file'/></div><div class="file-name-wrapper" title="${(source.file.getAbsolutePath())!}">${(source.file.getAbsolutePath())!}</div>
        </div>
        </#if>
        <div class="fullcolumn">
          <div class="detailsSource">
            <table class="source-tab">
              <tr>
                <td><img src="${baseURL}/images/<#if source.readable>good.gif" /><#else>bad.gif" /> ${problem!}</#if> <@s.text name='manage.source.readable'/></td>
                <td><strong><@s.text name='manage.source.columns'/>:</strong> ${source.getColumns()}</td>
                <#if source.fieldsTerminatedBy?has_content>
                <td><strong><@s.text name='manage.source.size'/>:</strong> ${source.fileSizeFormatted!"???"}</td>
                <td><strong><@s.text name='manage.source.rows'/>:</strong> ${source.rows!"???"}</td>
                <td><strong><@s.text name='manage.source.modified'/>:</strong> ${(source.lastModified?datetime?string.medium)!}</td>
              <#else>
              </#if>
            </table>
            <div class="source-buttons clearfix">
              <#if (logExists)>
              <div class="source-btn"><@s.text name='manage.source.source.log'/>: <a href="${baseURL}/sourcelog.do?r=${resource.shortname}&s=${source.name}" class="source-btn-btn"><@s.text name='manage.source.download'/></a></div>
              </#if>
              <div class="source-btn"><@s.submit cssClass="button" name="analyze" key="button.analyze"/></div>
              <div class="source-btn"><!-- preview icon is taken from Gentleface Toolbar Icon Set available from http://gentleface.com/free_icon_set.html licensed under CC-BY -->
                              <a href="#" id="peekBtn" class="icon icon-preview peekBtn"></a></div>
            </div>
          </div>
        </div>
      </div>

      <#-- inputs used by multiple source types -->
      <#macro multivalue>
        <@input name="source.multiValueFieldsDelimitedBy" help="i18n" helpOptions={"|":"[ | ] Pipe",";":"[ ; ] Semicolon",",":"[ , ] Comma"}/>
      </#macro>
      <#macro dateFormat>
        <@input name="source.dateFormat" help="i18n" helpOptions={"YYYY-MM-DD":"ISO format: YYYY-MM-DD","MM/DD/YYYY":"US dates: MM/DD/YYYY","DD.MM.YYYY":"DD.MM.YYYY"}/>
      </#macro>
      <#macro encoding>
        <@input name="source.encoding" help="i18n" helpOptions={"UTF-8":"UTF-8","Latin1":"Latin 1","Cp1252":"Windows1252"}/>
      </#macro>
      <#macro headerLines>
        <@input name="source.ignoreHeaderLines" help="i18n" helpOptions={"0":"None","1":"Single Header row"}/>
      </#macro>


        <div class="clearfix">

          <#if source.isSqlSource()>
          <#-- only for sql sources -->
              <div class="fullcolumn">
                <@select name="rdbms" options=jdbcOptions value="${source.rdbms.name!}" i18nkey="sqlSource.rdbms" />
              </div>
              <div class="halfcolumn">
                <@input name="sqlSource.host" help="i18n"/>
              </div>
              <div class="halfcolumn">
                <@input name="sqlSource.database" help="i18n"/>
              </div>
              <div class="halfcolumn">
                <@input name="sqlSource.username" />
              </div>
              <div class="halfcolumn">
                <@input name="sqlSource.password" type="password" />
              </div>
            <div class="fullcolumn">
            <@text name="sqlSource.sql" help="i18n"/>
            <#if sqlSource.sql?has_content>
              <@label i18nkey="sqlSource.sqlLimited" >
              ${sqlSource.getSqlLimited(10)}
              </@label>
            </div>
            </#if>
              <div class="halfcolumn">
                <@encoding/>
              </div>
              <div class="halfcolumn">
                <@dateFormat/>
              </div>
              <div class="halfcolumn">
                <@multivalue/>
              </div>
              <div class="halfcolumn">
              </div>
          <#elseif source.isExcelSource()>
          <#-- excel source -->
              <div class="halfcolumn">
                <@headerLines/>
              </div>
              <div class="halfcolumn">
                <@select name="source.sheetIdx" options=source.sheets() value="${source.sheetIdx}" i18nkey="excelSource.sheets" />
              </div>
              <div class="halfcolumn">
                <@multivalue/>
              </div>
              <div class="halfcolumn">
              </div>

          <#else>
          <#-- file source -->
              <div class="halfcolumn">
                <@headerLines/>
              </div>
              <div class="halfcolumn">
              </div>
              <div class="halfcolumn">
                <@input name="fileSource.fieldsTerminatedByEscaped" help="i18n" helpOptions={"\\t":"[ \\t ] Tab",",":"[ , ] Comma",";":"[ ; ] Semicolon","|":"[ | ] Pipe"}/>
              </div>
              <div class="halfcolumn">
                <@input name="fileSource.fieldsEnclosedByEscaped" help="i18n" helpOptions={"":"None","&quot;":"Double Quote","'":"Single Quote"}/>
              </div>
              <div class="halfcolumn">
                <@multivalue/>
              </div>
              <div class="halfcolumn">
                <@encoding/>
              </div>
              <div class="halfcolumn">
                <@dateFormat/>
              </div>
              <div class="halfcolumn">
              </div>
          </#if>

        </div>
        </div>
        <div class="buttons">
          <@s.submit cssClass="button" name="save" key="button.save"/>
	        <@s.submit cssClass="button" name="cancel" key="button.cancel"/>
 	        <#if id?has_content>
            <@s.submit cssClass="confirm" name="delete" key="button.delete.source.file"/>
          </#if>
        </div>
    <#else>
        </div>
        <div class="buttons">
          <@s.submit cssClass="button" name="cancel" key="button.back"/>
        </div>
    </#if>
  
</form>
</div>

<#include "/WEB-INF/pages/inc/footer.ftl">
</#escape>