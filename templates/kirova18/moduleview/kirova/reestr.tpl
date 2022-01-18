<main>
    <div class="global-wrapper" id="rent">
        {if $is_auth && $user['is_admin']}
            <section>
                <div class="container">
                    <div class="row v-center">
                        <div class="col xl9 l8 m7 s12">
                            <div class="h1-wrapper">
                                <h1>Реестр Договоров</h1>

    {*                            <div class="icon-wrapper">*}
    {*                                <a class="toggle-search"></a>*}
    {*                            </div>*}
    {*                            <div class="input-wrapper">*}
    {*                                <input type="text" placeholder="Поиск">*}
    {*                            </div>*}

                            </div>
                        </div>
    {*                    <div class="col xl3 l4 m5 s12 ra m-up">*}
    {*                        <a href="#act-control" class="btn modal-trigger waves-effect waves-light">Сформировать акт сверки</a>*}
    {*                    </div>*}
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <ul class="tabs">
                                <li class="tab"><a href="#active" class="active">Текущие</a></li>
                                <li class="tab"><a href="#archive">Архивные</a></li>
                                <li class="indicator" style="left: 0px; right: 853px;"></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row flex">
                        <div class="col s12">
                            <div id="active" class="active">
                                <table class="page-table">
                                    <thead>
                                        <tr>
                                            <th>Номер договора</th>
                                            <th>Помещения</th>
                                            <th>Арендатор</th>
                                            <th>Сумма</th>
                                            <th>Баланс</th>
                                            <th>действия</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $active_contracts as $contract}
                                            <tr class="arenda-row {if $contract['status'] == 100}ending-soon{/if}" id="contract-row-{$contract['id']}">
                                                <td>{$contract['number']}</td>
                                                <td>
                                                    {foreach $contract['rooms'] as $room}
                                                        {$room}{if !$room@last}, {/if}
                                                    {/foreach}
                                                </td>
                                                <td>{$contract['renter_short_title']}</td>
                                                <td>{$contract['sum']}({$contract['sum_discount']})₽</td>
                                                <td id="contract-balance-{$contract['id']}" class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']}₽</td>
                                                <td>
                                                    <a
                                                        class="refresh-balance"
                                                        data-id="{$contract['id']}"
                                                        data-url="{$router->getUrl('kirova-front-contracts', ['Act' => 'refreshBalance'])}"
                                                        title="обновить баланс"
                                                    >
                                                        <i class="mdi mdi-restore"></i>
                                                    </a>
                                                    <a
                                                        title="выставлен ли счет за текущий месяц"
                                                        class="check-last-invoice"
                                                        data-id="{$contract['id']}"
                                                        data-url="{$router->getUrl('kirova-front-contracts', ["Act" => 'checkLastInvoice'])}"
                                                    >
                                                        <i class="mdi mdi-book-check"></i>
                                                    </a>
                                                    <a
                                                        title="Выставить счет за текущий месяц"
                                                        class="generate-last-invoic"
                                                        data-id="{$contract['id']}"
                                                        data-url="{$router->getUrl('kirova-front-contracts', ['Act' => 'generateLastInvoice'])}"
                                                    >
                                                        <i class="mdi mdi-file-outline"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            <div id="archive" style="display: none;">
                                <table class="page-table">
                                    <thead>
                                    <tr><th>Наименование организации</th>
                                        <th>Текущий баланс</th>
                                    </tr></thead>
                                    <tbody>
                                    <tr class="arenda-row">
                                        <td>ООО «ТрансРегион»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансРегион»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансРегион»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансРегион»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>Umbrella Corporation, ltd</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ТрансУралСиб»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Ман</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ООО «ЮгАвтоСтрой»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ИП Веселкова Инна Федоровна</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr><tr class="arenda-row">
                                        <td>ПАО «МРСК Северного Кавказа»</td>
                                        <td>- 1 365 340.00₽</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        {else}
            <div class="container">
                <p>У вас нет прав для просмотра данной страницы</p>
            </div>
        {/if}
    </div>
</main>
