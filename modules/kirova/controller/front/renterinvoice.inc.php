<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class RenterInvoice extends Front
{
    function actionIndex()
    {
        $current_user = \RS\Application\Auth::getCurrentUser();
        $contract_api = new \Kirova\Model\ContractApi();
        /**
         * @var \Kirova\Model\Orm\Contract $contract
         */
        $contract = $contract_api->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0, '<>')->getFirst();
        $invoices = $contract->getAllInvoices();
        $current_date_timestamp = strtotime(date('Y-m-d'));
        $current_month = date('m');
        $current_year = date('Y');
        $already_exposed = false; // Выставлен ли счет за текущий месяц и год    
        foreach ($invoices as $key => $value){
            if(($value['period_month'] == $current_month) && ($value['period_year'] == $current_year)){
                $already_exposed = true;
            }
            switch ($value['period_month']){
                case '01':
                    $invoices[$key]['period_month_string'] = 'Январь';
                    break;
                case '02':
                    $invoices[$key]['period_month_string'] = 'Февраль';
                    break;
                case '03':
                    $invoices[$key]['period_month_string'] = 'Март';
                    break;
                case '04':
                    $invoices[$key]['period_month_string'] = 'Апрель';
                    break;
                case '05':
                    $invoices[$key]['period_month_string'] = 'Май';
                    break;
                case '06':
                    $invoices[$key]['period_month_string'] = 'Июнь';
                    break;
                case '07':
                    $invoices[$key]['period_month_string'] = 'Июль';
                    break;
                case '08':
                    $invoices[$key]['period_month_string'] = 'Август';
                    break;
                case '09':
                    $invoices[$key]['period_month_string'] = 'Сентябрь';
                    break;
                case '10':
                    $invoices[$key]['period_month_string'] = 'Октябрь';
                    break;
                case '11':
                    $invoices[$key]['period_month_string'] = 'Ноябрь';
                    break;
                case '12':
                    $invoices[$key]['period_month_string'] = 'Декабрь';
                    break;
            }
        }
        $config = \RS\Config\Loader::byModule('kirova');
        $is_discount = false;
        $invoice_api = new \Kirova\Model\InvoiceApi();
        $last_invoice = $invoice_api->setFilter('period_month', $current_month)
                        ->setFilter('period_year', $current_year)
                        ->setFilter('contract_id', $contract['id'])
                        ->getFirst();
        $fake_balance = 0;
        if($already_exposed){
            // Проверяем условие - если текущий день уже после дня для представления скидки
           
            if(intval(date('d')) > $config['day_with_discount']){
                // Проверяем условие если баланс положительный то скидка все равно будет предоставлена
                if($contract['balance'] >= 0){
                    $is_discount = true;
                }else{
                    $is_discount = false;
                }
            }else{
                // Если счет за последний месяц выставлен и баланс отрицателен на сумму счета без скидки
                if(($contract['balance'] < 0)){
                    $is_discount = true;
                    $fake_balance = $contract['balance'] + ($last_invoice['sum'] - $last_invoice['discount_sum']);
                }
                if($contract['balance'] > 0){
                    $is_discount = true;
                }
            }
        }
        // echo '<pre>';
        // var_dump($already_exposed);
        // var_dump($is_discount);
        // var_dump($invoices);
        // exit();
        $this->view->assign('user', $current_user);
        $this->view->assign('invoices', $invoices);
        $this->view->assign([
            'current_month' => $current_month,
            'current_year' => $current_year,
            'is_discount' => $is_discount,
            'already_exposed' => $already_exposed,
            'contract' => $contract,
            'fake_balance' => $fake_balance
        ]);
        return $this->result->setTemplate('%kirova%/renter-invoice.tpl');
    }
}
