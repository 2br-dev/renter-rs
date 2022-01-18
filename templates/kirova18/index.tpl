{extends file="%THEME%/wrapper.tpl"}
{addcss file="auth.css"}
{$user = \RS\Application\Auth::getCurrentUser()}
{block name="content"}
        {if $user['is_admin']}
            {moduleinsert name="\Kirova\Controller\Block\Reestr" indexTemplate = "%kirova%/reestr.tpl"}
        {else}
            {moduleinsert name="\Kirova\Controller\Block\Renter" indexTemplate = '%kirova%/blocks/renter.tpl'}
        {/if}

{*        <main>*}
{*            <div class="global-wrapper" id="rent">*}
{*                {moduleinsert name="\Kirova\Controller\Block\Reestr"}*}
{*            </div>*}
{*        </main>*}
{*    {else}*}
{*        <main>*}
{*            <div class="global-wrapper" id="user-auth-wrapper">*}
{*                <div class="user-auth">*}
{*                    <form id="auth-renter-form">*}
{*                        <div class="auth-header">*}
{*                            <h1>Авторизация</h1>*}
{*                        </div>*}
{*                        <div class="auth-content">*}
{*                            <div class="row">*}
{*                                <div class="input-field">*}
{*                                    <input type="text" class="styled" name="login" placeholder="Имя пользователя">*}
{*                                    <label>Имя пользователя</label>*}
{*                                </div>*}
{*                            </div>*}
{*                            <div class="row">*}
{*                                <div class="input-field">*}
{*                                    <input type="text" class="styled" name="pass" placeholder="Пароль">*}
{*                                    <label>Пароль</label>*}
{*                                </div>*}
{*                            </div>*}

{*                        </div>*}
{*                        <div class="auth-footer right-align">*}
{*                            <a data-url="{$router->getUrl('kirova-front-authrenter')}"  id="auth-renter-submit" type="submit" class="btn">Войти</a>*}
{*                        </div>*}
{*                    </form>*}
{*                </div>*}
{*            </div>*}
{*        </main>*}
{*    {/if}*}
{*    <ul class="sidenav" id="details">*}
{*        <li>*}
{*            <a class="waves-effect details-trigger active">Платежная информация</a>*}
{*            <ul>*}
{*                <li><a><span class="key">ЮЛ</span><span class="value">ПАО «МРСК Северного Кавказа»</span></a></li>*}
{*                <li><a><span class="key">Банк</span><span class="value">Байкальский банк ПАО Сбербанк г. Иркутск</span></a></li>*}
{*                <li><a><span class="key">ИНН</span><span class="value">3818047830</span></a></li>*}
{*                <li><a><span class="key">КПП</span><span class="value">381001001</span></a></li>*}
{*                <li><a><span class="key">ОГРН(ИП)</span><span class="value">1173850003172</span></a></li>*}
{*                <li><a><span class="key">Р/С</span><span class="value">40702810418350016506</span></a></li>*}
{*                <li><a><span class="key">К/С</span><span class="value">3010181090000000607</span></a></li>*}
{*                <li><a><span class="key">БИК</span><span class="value">042520607</span></a></li>*}
{*            </ul>*}
{*        </li>*}
{*        <li>*}
{*            <a class="waves-effect details-trigger">Контакты</a>*}
{*            <ul>*}
{*                <li><a class="fogged-text">Телефоны</a></li>*}
{*                <li><a>+7 918 084 9370</a></li>*}
{*                <li><a>+7 918 084 9370</a></li>*}
{*                <li><a>+7 918 084 9370</a></li>*}
{*                <li><a class="fogged-text">Эл. Почта</a></li>*}
{*                <li><a>masterkadaj@gmail.com</a></li>*}
{*                <li><a>masterkadaj@gmail.com</a></li>*}
{*                <li><a>masterkadaj@gmail.com</a></li>*}
{*                <li><a class="fogged-text">Адрес</a></li>*}
{*                <li><a class="waves-effect address-trigger">666780 Иркутская обл., г. Усть-Кут, Комсомольский пер., 1, кроп. А, кв. 50</a></li>*}
{*            </ul>*}
{*        </li>*}
{*    </ul>*}
{/block}
