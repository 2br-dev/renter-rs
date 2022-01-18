<section>
    <div class="container">
        <div class="h1-wrapper">
            <h1>Личный кабинет Арендатора</h1>
        </div>
        <div class="row">
            <div class="col s12">
                <div class="renter-info">
                    <div class="renter-info-item">Арендатор: {$renter['title']} ({$renter['short_title']})</div>
                </div>
            </div>
        </div>
        <div class="row">
            <h2>Договор</h2>
            <div class="col s12">
                <div class="contract-info">
                    <div class="contract-info-item"><strong>№</strong> {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</div>
                    <div class="contract-info-item">
                        <strong>Баланс:</strong>
                        <span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span>
                    </div>
                    <div class="contract-info-item"><strong>Помещение: </strong>
                        {foreach $contract['rooms'] as $room}
                            {$room}{if !$room@last}, {/if}
                        {/foreach}
                    </div>
                    <div class="contract-info-item"><strong>Сумма аренды в мес.:</strong> {$contract['sum']} ₽</div>
                    <div class="contract-info-item"><strong>Сумма аренды в мес. со скидкой:</strong> {$contract['sum_discount']} ₽</div>
                </div>
            </div>
        </div>
    </div>
</section>

