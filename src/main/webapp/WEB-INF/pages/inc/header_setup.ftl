[#ftl]
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
	    <meta name="copyright" lang="en" content="GBIF" />
		<title>[@s.text name="admin.config.setup.title"/]</title>
	  <link rel="stylesheet" type="text/css" media="all" href="${baseURL}/styles/reset.css" />
		<link rel="stylesheet" type="text/css" media="all" href="${baseURL}/styles/text.css" />
		<link rel="stylesheet" type="text/css" media="all" href="${baseURL}/styles/960_24_col.css" />
 		<link rel="stylesheet" type="text/css" href="${baseURL}/styles/main.css"/>
 		<link rel="shortcut icon" href="${baseURL}/images/icons/favicon.png" type="image/x-icon" />
    <!-- for css overrides needed for customizations -->
    <link rel="stylesheet" type="text/css" href="${baseURL}/styles/custom.css" />
    <!-- for support of old browsers, like IE8. See http://modernizr.com/docs/#html5inie -->
    <script type="text/javascript" src="${baseURL}/js/modernizr.js"></script>
    <script type="text/javascript" src="${baseURL}/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${baseURL}/js/global.js"></script>
		<style>
      h1 {
      	color: #077A2D;
      	font-size: 30px;
      }
		</style>
    <script type="text/javascript">
      $(document).ready(function(){
        initHelp();
      	[#-- see global.js for function defs --]
      	initMenu();
      	langs("${localeLanguage}","${baseURL}");  
      });
    </script>

 	</head>
 	<body>
		<div class="page clearfix" id="page">
			<header id="section-header" class="section section-header">
        <div id="zone-user-wrapper" class="zone-wrapper zone-user-wrapper clearfix">
          <div id="zone-user" class="zone zone-user clearfix container_24">
            <div class="region-inner region-branding-inner">
              <div class="branding-data clearfix">
                <div class="logo-img">
                  <a href="${baseURL}" rel="home" title="GBIF Logo" class="active">
                    <img src="${baseURL}/images/sib-logo-full.svg" width="350" alt="SIB">
                  </a>
                </div>
                <div id="region-user-second" class="region-inner region-user-second-inner">
                  <ul id="language-menu" class="navi-list">

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
                </div>
              </div>
            </div>
          </div>
        </div>
    </header>
    <section id="section-content" class="section section-content menu-pull">
      <div id="zone-content-wrapper" class="zone-wrapper zone-content-wrapper clearfix">  
        <div id="zone-content" class="zone zone-content clearfix container_24"> 
          <div class="region region-content" id="region-content">
      		