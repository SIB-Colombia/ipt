[#ftl]
<script type="text/javascript">
	$(document).ready(function(){
  		langs("${localeLanguage}","${baseURL}");
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		
        $( ".user-access" ).click(function() {
          $( "#sub-login" ).toggleClass( "visible" );
          if($( "#languages" ).hasClass( "visible" )) {
            $( "#languages" ).toggleClass( "visible" );
          }
        });
        
        $( ".user-lang" ).click(function() {
          $( "#languages" ).toggleClass( "visible" );
          if($( "#sub-login" ).hasClass( "visible" )) {
            $( "#sub-login" ).toggleClass( "visible" );
          }
        });
				   
	});
</script>
<script type="text/javascript">
    $(document).ready(function(){        
        $( "select" ).wrap( "<span class='select-box'></span>" );
    });
</script>
</head>
 	<body>
    <div class="prld"></div>
		<div class="page clearfix" id="page">
			<header class="main-header clearfix">
[#if !cfg.devMode() && cfg.getRegistryType()=='PRODUCTION']
                  [#else]
                    <div class="test-mode"><img src="${baseURL}/styles/testmode.png" /></div>
                  [/#if]
  <div class="logo"><a href="${baseURL}" rel="home" title="GBIF Logo"><img src="${baseURL}/images/logo-sib.svg" alt="SIB"></a></div>
  <div class="nav-wrapper clearfix">
    <div class="main-nav">
      <nav>
        <ul class="navi-list">
          <li><a href="${baseURL}/" class="ico-home[#if currentMenu=='home'] current[/#if]">[@s.text name="menu.home"/]</a></li>
          [#if managerRights]
          <li><a href="${baseURL}/manage/" class="ico-reso[#if currentMenu=='manage'] current[/#if]">[@s.text name="menu.manage"/]</a></li>
          [/#if]
          [#if adminRights]
          <li><a href="${baseURL}/admin/" class="ico-admin[#if currentMenu=='admin'] current[/#if]">[@s.text name="menu.admin"/]</a></li>
          [/#if]
          [#if (Session.curr_user)??]
          <li><a href="${baseURL}/account.do" class="user-access ico-login[#if currentMenu=="account"] current[/#if]">[@s.text name="menu.account"/]</a>
          </li>
          <li><a href="${baseURL}/logout.do" class="user-access ico-logout[#if currentMenu=='logout'] current[/#if]">[@s.text name="menu.logout"/]</a>
          </li>
          [#else]
          <li><a class="user-access ico-login">
            [#if localeLanguage=='en']Login[/#if]
            [#if localeLanguage=='fr']S'identifier[/#if]
            [#if localeLanguage=='es']Ingresar[/#if]
            [#if localeLanguage=='zh']&#30331;&#24405;[/#if]
            [#if localeLanguage=='pt']Conecte-se[/#if]
            [#if localeLanguage=='ja']&#12525;&#12464;&#12452;&#12531;[/#if]
          </a>
            <ul id="sub-login" class="sub-menu">
              <li><form id="login-form" action="${baseURL}/login.do" class="login-form" method="post">
                          <input type="text" size="25" name="email" value="email" class="form-reset" />
                          <input type="password" size="20" name="password" value="password" class="form-reset" />
                          [@s.submit key="portal.login" name="login-submit"/]
                        </form></li>
            </ul>
          </li>
          [/#if]
          <li><a class="user-lang ico-lang">
          [#if localeLanguage=='en']English[/#if]
          [#if localeLanguage=='fr']Française[/#if]
          [#if localeLanguage=='es']Español[/#if]
          [#if localeLanguage=='zh']&#28450;&#35486;&#20013;&#25991;[/#if]
          [#if localeLanguage=='pt']Português[/#if]
          [#if localeLanguage=='ja']&#26085;&#26412;&#35486;[/#if]
          </a>
            <ul id="languages" class="sub-menu">
              <!-- add more languages as translations become available. -->
                        <!-- To see more information go to langs method in global.js -->
            </ul>
          </li>
        </ul>
      </nav>
    </div>
  </div>
  [#if (Session.curr_user)??]
  <div class="username-disp">[@s.text name="menu.loggedin"][@s.param]${Session.curr_user.email}[/@s.param][/@s.text]</div>
  [/#if]
</header>
		  <section id="section-content" class="section section-content">
        <div id="zone-content-wrapper" class="zone-wrapper zone-content-wrapper clearfix">
          <div id="zone-content" class="zone zone-content clearfix container_24">

[#if sideMenuEml!false]

			<aside class="side">
			<div class="clearfix" id="sidebar">
				<h2>[@s.text name='manage.metadata.section' /]</h2>
				<ul class="sidebar">
				[#list ["basic", "geocoverage", "taxcoverage","tempcoverage", "keywords", "parties", "project", "methods", "citations", "collections", "physical", "additional"] as it]
				 <li[#if currentSideMenu?? && currentSideMenu==it] class="current"[#else] class="sidebar"[/#if]><a href="metadata-${it}.do?r=${resource.shortname!r!}">[@s.text name="submenu.${it}"/]</a></li>
				[/#list]
				</ul>
			</div>
			</aside>

			<div class="main-content" id="region-content">

[#else]

			<div class="grid_24 region region-content" id="region-content">
[/#if]


			[@s.actionmessage/]
			[#if warnings?size>0]
			 <ul class="warnMessage">
			 [#list warnings as w]
	          <li><span>${w!}</span></li>
			 [/#list]
             </ul>
            [/#if]
			[@s.actionerror/]

            <div id="dialog-confirm" title="[@s.text name="basic.confirm"/]" style="display: none;"></div>