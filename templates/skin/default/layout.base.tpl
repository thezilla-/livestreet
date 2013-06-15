<!doctype html>

{block name='layout_options'}{/block}

<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="ru"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="ru"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="ru"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="ru"> <!--<![endif]-->

<head>
	{hook run='html_head_begin'}
	{block name='layout_head_begin'}{/block}

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title>{block name='layout_title'}{$sHtmlTitle}{/block}</title>

	<meta name="description" content="{block name='layout_description'}{$sHtmlDescription}{/block}">
	<meta name="keywords" content="{block name='layout_keywords'}{$sHtmlKeywords}{/block}">

	{**
	 * Стили
	 * CSS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
	 *}
	{$aHtmlHeadFiles.css}

	<link href="{cfg name='path.static.skin'}/images/favicon.ico?v1" rel="shortcut icon" />
	<link rel="search" type="application/opensearchdescription+xml" href="{router page='search'}opensearch/" title="{cfg name='view.name'}" />

	{**
	 * RSS
	 *}
	{if $aHtmlRssAlternate}
		<link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
	{/if}

	{if $sHtmlCanonical}
		<link rel="canonical" href="{$sHtmlCanonical}" />
	{/if}

	{if $bRefreshToHome}
		<meta  HTTP-EQUIV="Refresh" CONTENT="3; URL={cfg name='path.root.web'}/">
	{/if}


	<script>
		var DIR_WEB_ROOT 			= '{cfg name="path.root.web"}',
			DIR_STATIC_SKIN 		= '{cfg name="path.static.skin"}',
			DIR_STATIC_FRAMEWORK 	= '{cfg name="path.static.framework"}',
			LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}',
			SESSION_ID				= '{$_sPhpSessionId}',
			LANGUAGE				= '{$oConfig->GetValue('lang.current')}',
			WYSIWYG					= {if $oConfig->GetValue('view.wysiwyg')}true{else}false{/if};

		var aRouter = [];
		{foreach from=$aRouter key=sPage item=sPath}
			aRouter['{$sPage}'] = '{$sPath}';
		{/foreach}
	</script>

	{**
	 * JavaScript файлы
	 * JS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
	 *}
	{$aHtmlHeadFiles.js}

	{**
	 * Тип сетки сайта
	 *}
	{if {cfg name='view.grid.type'} == 'fluid'}
		<style>
			#container {
				min-width: {cfg name='view.grid.fluid_min_width'}px;
				max-width: {cfg name='view.grid.fluid_max_width'}px;
			}
		</style>
	{else}
		<style>
			#container { width: {cfg name='view.grid.fixed_width'}px; } {* *}
		</style>
	{/if}

	{block name='layout_head_end'}{/block}
	{hook run='html_head_end'}
</head>


<body class="{$sBodyClasses} layout-{cfg name='view.grid.type'} {block name='layout_body_classes'}{/block}">
	{hook run='body_begin'}

	{block name='layout_body'}
		<div id="container" class="{hook run='container_class'} {if $bNoSidebar}no-sidebar{/if}">
			{* Шапка *}
			<div id="header">
				<h1 class="site-name"><a href="{cfg name='path.root.web'}">{cfg name='view.name'}</a></h1>
				<h2 class="site-description">{cfg name='view.description'}</h2>
			</div>


			{* Основная навигация *}
			<nav id="nav">
				<ul class="nav nav-main">
					<li {if $sMenuHeadItemSelect == 'index'}class="active"{/if}><a href="{cfg name='path.root.web'}">{$aLang.nav_main_home}</a></li>
					<li {if $sMenuHeadItemSelect == 'about'}class="active"{/if}><a href="{cfg name='path.root.web'}/about">{$aLang.nav_main_about}</a></li>

					{hook run='main_menu_item'}
				</ul>

				{hook run='main_menu'}
			</nav>


			{* Вспомогательный контейнер-обертка *}
			<div id="wrapper" class="clearfix {hook run='wrapper_class'}">
				{* Контент *}
				<div id="content-wrapper" role="main">
					<div id="content" role="main">

						{hook run='content_begin'}
						{block name='layout_content_begin'}{/block}

						{* Навигация *}
						{if $sNav or $sNavContent}
							<div class="nav-group">
								{if $sNav}
									{if in_array($sNav, $aMenuContainers)}
										{$aMenuFetch.$sNav}
									{else}
										{include file="navs/nav.$sNav.tpl"}
									{/if}
								{else}
									{include file="navs/nav.$sNavContent.content.tpl"}
								{/if}
							</div>
						{/if}

						{* Системные сообщения *}
						{include file='system_message.tpl'}

						{block name='layout_content'}{/block}

						{block name='layout_content_end'}{/block}
						{hook run='content_end'}
					</div>
				</div>


				{* Сайдбар *}
				{if ! $bNoSidebar}
					<aside id="sidebar">
						{include file='blocks.tpl' group='right'}
					</aside>
				{/if}
			</div> {* /wrapper *}


			{* Подвал *}
			<footer id="footer">
				{hook run='footer_begin'}

				{block name='layout_footer_begin'}{/block}

				{hook run='copyright'}

				© Powered by <a href="http://livestreetcms.org/">LiveStreet CMS</a>

				{block name='layout_footer_end'}{/block}

				{hook run='footer_end'}
			</footer>
		</div> {* /container *}
	{/block}


	{* Подключение модальных окон *}
	{include file='modals/modal.test.tpl'}


	{hook run='body_end'}
</body>
</html>