{**
 * Поиск по личным сообщениям
 *}

<div class="accordion">
	<h3 class="accordion-header" onclick="jQuery('#block_talk_search_content').toggle(); return false;">
		<span class="link-dotted">{$aLang.messages.search.title}</span>
	</h3>

	<form action="{router page='talk'}" method="GET" name="talk_filter_form" id="block_talk_search_content" class="accordion-content" {if $_aRequest.submit_talk_filter}style="display:block;"{/if}>
		{* Отправитель *}
		{include 'components/field/field.text.tpl'
				 sName    = 'sender'
				 sLabel   = $aLang.messages.search.fields.sender.label
				 sNote    = $aLang.messages.search.fields.sender.note
				 sInputClasses = 'width-full autocomplete-users'}

		{* Получатель *}
		{include 'components/field/field.text.tpl'
				sName    = 'receiver'
				sLabel   = $aLang.messages.search.fields.receiver.label
				sNote    = $aLang.messages.search.fields.receiver.note
				sInputClasses = 'width-full autocomplete-users'}

		{* Искать в заголовке *}
		{include 'components/field/field.text.tpl'
				 sName    = 'keyword'
				 sLabel   = $aLang.messages.search.fields.keyword.label}

		{* Искать в тексте *}
		{include 'components/field/field.text.tpl'
				 sName    = 'keyword_text'
				 sLabel   = $aLang.messages.search.fields.keyword_text.label}

		{* Ограничения по дате *}
		{include 'components/field/field.text.tpl'
				sName         = 'start'
				sPlaceholder  = $aLang.messages.search.fields.start.placeholder
				sLabel        = $aLang.messages.search.fields.start.label
				sInputClasses = 'width-200 js-date-picker'}

		{include 'components/field/field.text.tpl'
				sName         = 'end'
				sPlaceholder  = $aLang.messages.search.fields.end.placeholder
				sInputClasses = 'width-200 js-date-picker'}

		{* Искать только в избранном *}
		{include 'components/field/field.checkbox.tpl' sName='favourite' sLabel=$aLang.messages.search.fields.favourite.label}

		{* Кнопки *}
		{include 'components/button/button.tpl'
				sName  = 'submit_talk_filter'
				sValue = '1'
				sMods  = 'primary'
				sText  = $aLang.search.find}

		{include 'components/button/button.tpl' sType='reset' sText=$aLang.common.form_reset}
	</form>
</div>