<main>
    <div class="global-wrapper">
        <section>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="h1-wrapper">
                            <h1>История платежей</h1>
                        </div>
                        <div class="contract">
                            <p>Договор № {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</p>
                            <p><strong>Баланс:</strong> <span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span></p>
                        </div>

                        <table class="page-table">
                            <thead>
                                <th>Дата</th>
                                <th>Номер документа</th>
                                <th>Сумма</th>
                            </thead>
                            <tbody id="payment-table">
                                {foreach $payments as $payment}
                                    <tr>
                                        <td>{$payment['date']|date_format:'%d.%m.%Y'}</td>
                                        <td>{$payment['number']}</td>
                                        <td>{$payment['sum']} ₽</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>
