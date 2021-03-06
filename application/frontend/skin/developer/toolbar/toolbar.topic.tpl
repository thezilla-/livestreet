{**
 * Тулбар
 * Кнопка прокручивания к следующему/предыдущему топику
 *
 * @styles css/toolbar.css
 * @scripts js/livestreet/toolbar.js
 *}

{extends 'components/toolbar/toolbar.item.tpl'}

{block 'toolbar_item_options' append}
	{$_sMods = 'topic'}
	{$_sClasses = 'js-toolbar-topics'}
	{$_bShow = $params.iCountTopic}
{/block}

{block 'toolbar_item'}
	{toolbar_item_icon sClasses='toolbar-topic-prev js-toolbar-topics-prev' sTitle="{$aLang.toolbar_topic_prev}" sIcon="icon-arrow-up"}
	{toolbar_item_icon sClasses='toolbar-topic-next js-toolbar-topics-next' sTitle="{$aLang.toolbar_topic_next}" sIcon="icon-arrow-down"}
{/block}