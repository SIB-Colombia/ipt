<#escape x as x?html>
<#include "/WEB-INF/pages/inc/header.ftl"/>
<title><@s.text name="login.title"/></title>
<#assign currentMenu = "account"/>
<#include "/WEB-INF/pages/inc/menu.ftl"/>
<#include "/WEB-INF/pages/macros/forms.ftl">

<div class="title-icon"><img src="${baseURL}/images/ico-title-user.svg" alt="<@s.text name="title"/>"></div>
  <h1 class="rtableTitle"><@s.text name="login.title"/></h1>
  <div>
  <p>
    <@s.text name="login.intro"><@s.param>${admin.email}</@s.param></@s.text>
  </p>
  
    <form id="createuser" class="topForm" action="${baseURL}/login.do" method="post">
      <div class="width50 clearfix">
  <div class="width50"><@input name="email" i18nkey="user.email" value="${email!}"/></div>
  <div class="width50"><@input name="password" i18nkey="user.password" type="password" value="${password!}"/></div>
  </div>
<#if email?has_content>
        <p class="forgotten">
          <@s.text name="login.forgottenpassword"><@s.param>${admin.email}</@s.param></@s.text>
        </p>
      </#if>
<div class="user-button clear-btn">
  <@s.submit cssClass="button" key="portal.login"/>
</div>
    </form>
    
</div>

<#include "/WEB-INF/pages/inc/footer.ftl"/>
</#escape>