{**
 * Список пользователей с элементами управления / Пользователь
 * Расширяет основной шаблон с пользователем добавляя кнопку "Повторно отправить приглашение" в блоке "Пригласить пользователей в блог"
 *}

{extends 'components/user_list_small/user_list_small_item.tpl'}

{block 'components/user_list_small/user_list_small_item_actions'}
	<li class="icon-repeat js-blog-invite-user-repeat" title="{$aLang.common.remove}" data-user-id="{$iUserId}"></li>

	{$smarty.block.parent}
{/block}