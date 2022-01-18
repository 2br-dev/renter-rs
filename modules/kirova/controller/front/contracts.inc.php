<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use kirova\Model\Orm\Renter;
use kirova\Model\RenterApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Contracts extends Front
{
    function actionIndex()
    {
        return $this->result->setTemplate('%kirova%/reestr.tpl');
    }

    /**
     * Обновить баланс договора с учетом всех выставленных счетов и полученных оплат
     * @return \RS\Controller\Result\Standard
     */
    public function actionRefreshBalance()
    {
        $contract_id = $this->request('id', TYPE_INTEGER);

        $contract = new \Kirova\Model\Orm\Contract($contract_id);
        $renter = new \Kirova\Model\Orm\Renter($contract['renter']);

        $invoices = $contract->getAllInvoices();
        $payments = $contract->getAllPayments(true);

        $credit = 0;
        $debit = 0;
        $saldo = 0;
        $start_balance = $renter['start_balance']; //Старотовый бланс арендатора
        $trigger = false; // Выполненно ли условие предоставления скидки
        $info = [];
        $start_balance_inc = false; // Прибавлен ли к оплатам стартовый баланс

        foreach($invoices as $key_invoice => $invoice){
            $last_day = date('t', strtotime($invoice['period_year'].'-'.$invoice['period_month'].'-01'));
            if(!empty($payments)){
                foreach($payments as $key_payment => $payment){
//                    $log['payment'][] = print_r($payment['date'], true);
//                    $log['invoice'][] = print_r($invoice['date'], true);
//                    file_put_contents(\Setup::$PATH . '/log.txt', print_r($log, true) . PHP_EOL, FILE_APPEND);
                    if((strtotime($invoice['period_year'].'-'.$invoice['period_month'].'-'.$last_day) <= strtotime($payment['date']))
                        )
                    {
                        break;
                    }
                    // Увеличиваем $credit с учетом стартого баланса арендатора
                    if(!$start_balance_inc){
                        $credit = $payment['sum'] + $credit + $start_balance;
                        $start_balance_inc = true;
                    }else{
                        $credit += $payment['sum'];
                    }
                    $info['payment_date'][] = $payment['date'];
                    // 1. Условие - дата оплаты соответствует льготному периоду оплаты
                    if (strtotime($payment['date']) < strtotime($invoice['finish_discount'])) {

                        // 2.Условие - нет задолженности по оплатам т.е. $saldo > 0
                        if ($saldo >= 0) {
                            // 2.a.Условие - сумма платежа больше чем сумма счета со скидкой
                            if ($invoice['discount_sum'] <= $payment['sum']) {
                                $trigger = true;
                            };
                            if($credit - $debit >= $invoice['discount_sum']){
                                $trigger = true;
                            }
                        } // 2.1 Условие - $saldo < 0
                        else {
                            //2.1a Условие - сумма плтаежа больше чем $saldo + сумма счета со скидкой
                            if ($payment['sum'] >= abs($saldo) + $invoice['discount_sum']) {
                                $trigger = true;
                            }
                            if($credit - $debit >= $invoice['discount_sum']){
                                $trigger = true;
                            }
                        }
                    }
                    unset($payments[$key_payment]);
                    if($payment['sum'] >= $invoice['sum'] && !$trigger ){
                        break;
                    }
                    if($trigger && $payment['sum'] >= $invoice['discount_sum']){
                        break;
                    }
//                    break;
                }
            }
            if($trigger){
                $debit += $invoice['discount_sum'];
//                $info[$invoice['period_month']] = $invoice['discount_sum'];
                $invoice['is_discount'] = 1;
            }
            else {
                if($saldo >= $invoice['discount_sum']){
                    $debit += $invoice['discount_sum'];
                    $invoice['is_discount'] = 1;
                }else {
                    $debit += $invoice['sum'];
                    $invoice['is_discount'] = 0;
                }
            }
            // есил итерация по счетам последняя и оплат больше по количеству чем счетов - плюсуем credit
            if ($key_invoice === (count($invoices) - 1) && !empty($payments)){
                foreach ($payments as $key => $value){
                    $credit += $value['sum'];
                }
            }
            $info['saldo'][] = $saldo.' - '.$credit. ' - ' .$debit;
            $info['trigger'][] = $trigger;
            $info['finish'][] = $invoice['period_month'] .' - '. $invoice['finish_discount'];
            $saldo = $credit - $debit;
            $trigger = false;
            $invoice->update();

        }
//        echo '<pre>';
//        var_dump($info);
//        exit();
        $contract['balance'] = $saldo;
        $contract->update();
        $this->result->addSection('balance', $saldo);
        $this->result->addSection('id', $contract['id']);
        return $this->result;
    }

    /**
     * Проверяем выставлен ли счет по договора за текущий месяц
     * @return \RS\Controller\Result\Standard
     */
    public function actionCheckLastInvoice()
    {
        $contract_id = $this->request('id', TYPE_INTEGER);
        $contract_api = new \Kirova\Model\ContractApi();
        $invoice = $contract_api->checkLastInvoice($contract_id);
        if($invoice){
            $this->result->setSuccess(true);
        }else{
            $this->result->setSuccess(false);
        }
        return $this->result;
    }

    public function actionGenereateLastInvoice()
    {
        $id = $this->request('id', TYPE_INTEGER);
        $data =
        $contract_api = new \Kirova\Model\ContractApi();
    }
}
