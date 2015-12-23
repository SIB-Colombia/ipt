[#ftl]
[#include "/WEB-INF/pages/inc/header_setup.ftl"]
<div class="setup">
<h1 class="twenty_top rtableTitle">[@s.text name="admin.config.setup2.title"/]</h1>
<div class="metadata-intro"><p>[@s.text name="admin.config.setup2.welcome"/]</p></div>

			[@s.actionmessage/]
			[#if warnings?size>0]
			 <ul class="warnMessage">
			 [#list warnings as w]
	          <li><span>${w!}</span></li>
			 [/#list]
             </ul>
            [/#if]
			[@s.actionerror/]

[#include "/WEB-INF/pages/macros/forms.ftl"]
[@s.form cssClass="topForm half" action="setup2.do" method="post"]
	<input type="hidden" name="setup2" value="true" />

	<input type="hidden" name="ignoreUserValidation" value="${ignoreUserValidation}" />
  <h2 class="subTitle">[@s.text name="admin.config.setup2.administrator"/]</h2>
  [@s.text name="admin.config.setup2.administrator.help"/]<br/>
<div class="clearfix">
  <div class="width33">
    [@input name="user.email" disabled=(ignoreUserValidation==1) /]
    </div>
    <div class="width33">
	[@input name="user.firstname" disabled=(ignoreUserValidation==1) /]
    </div>
    <div class="width33">
	[@input name="user.lastname" disabled=(ignoreUserValidation==1) /]
    </div>
</div>
<div class="clearfix">
  <div class="width33">
	[@input name="user.password" type="password" disabled=(ignoreUserValidation==1) /]
  </div>
  <div class="width33">
	[@input name="password2" i18nkey="user.password2" type="password" disabled=(ignoreUserValidation==1) /]
    </div>
</div>
<div id="iptMode" class="clearfix">
  <div class="radio">
    <h2 class="subTitle">[@s.text name="admin.config.setup2.mode.title"/]</h2>
    [@s.text name="admin.config.setup2.mode.help"/]<br/><br/>
    [@s.text name="admin.config.setup2.mode.test"/]<br/>
    [@s.text name="admin.config.setup2.mode.production"/]<br/><br/>
    [@s.text name="admin.config.setup2.mode"/]
    [@s.fielderror]
    	[@s.param value="%{'modeSelected'}" /]
    [/@s.fielderror]
    [@s.radio name="modeSelected" list="modes" disabled=(cfg.devMode()) value="modeSelected" /]
  </div>
</div>
  <h2 class="subTitle">[@s.text name="admin.registration.baseURL"/]</h2>
	[@input name="baseURL" help="i18n" i18nkey="admin.config.baseUrl"/]
	[@input name="proxy" help="i18n" i18nkey="admin.config.proxy" /]

	  <div class="buttons">
 	[@s.submit cssClass="button" name="save" id="save" key="button.save"/]
	  </div>

[/@s.form]
</div>
</div>
[#include "/WEB-INF/pages/inc/footer.ftl"]
