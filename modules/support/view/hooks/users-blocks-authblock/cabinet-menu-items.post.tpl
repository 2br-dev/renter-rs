{modulegetvars name="\Support\Controller\Block\NewMessages" var="data"}
<li><a href="{$router->getUrl('support-front-support')}">{t}Сообщения{/t} <span class="supportCountMessages">({$data.new_count})</span></a></li>