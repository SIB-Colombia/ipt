<#escape x as x?html>
<#include "/WEB-INF/pages/inc/header.ftl">
 <title><@s.text name="account.title"/></title>
<#include "/WEB-INF/pages/inc/menu.ftl">
<#include "/WEB-INF/pages/macros/forms.ftl">
<div>
<div class="title-icon"><img src="${baseURL}/images/ico-title-user.svg" alt="<@s.text name="title"/>"></div>
  <h1 class="rtableTitle"><@s.text name="account.title"/></h1>
<p><@s.text name="account.intro"/></p>
<p><@s.text name="account.email.cantChange"/></p>

<@s.form cssClass="topForm half" action="account" method="post" namespace="" includeContext="false">
	<@s.hidden name="id" value="${user.email!}" required="true"/>
<div class="form-row clearfix no-img">
  <div class="width50">
    <div class="width50"><@input name="user.email" disabled=true /></div>
    <div class="width50"><@input name="user.firstname" /></div>
  </div>
  <div class="width50">
    <div class="width50"><@input name="user.lastname" /></div>
  </div>
</div>
<div class="form-row clearfix no-img">
  <div class="width50">
    <div class="width50"><@input name="user.password" i18nkey="user.password.new" type="password"/></div>
    <div class="width50"><@input name="password2" i18nkey="user.password2" type="password"/></div>
  </div>
  <div class="width50">
    <div class="width50"><#assign val><@s.text name="user.roles.${user.role?lower_case}"/></#assign>
	<@readonly name="role" i18nkey="user.role" value=val /></div>
  </div>
</div>
<div id="create-button" class="buttons clear-btn">
  <@s.submit cssClass="button" name="save" key="button.save"/>
 	  <@s.submit cssClass="button" name="cancel" key="button.cancel"/>
</div>
</@s.form>
</div>
<#include "/WEB-INF/pages/inc/footer.ftl">
</#escape>