<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Contract extends OrmObject
{
    protected static $table = 'contract';

    function _init()
    {
        parent::_init()->append([
            t('Основные'),
                'number' => new Type\Varchar([
                    'description' => t('Номер договора'),
                ]),
                'date' => new Type\Date([
                    'description' => t('Дата договора')
                ]),
                'renter' => new Type\Integer([
                    'description' => t('Арендатор'),
                    'list' => [['\Kirova\Model\RenterApi', 'staticSelectList'], [0 => 'Не выбран']]
                ]),
                'room' => new Type\ArrayList([
                    'description' => t('Помещение'),
                    'list' => [['\Kirova\Model\RoomsApi', 'staticSelectList'], [0 => 'Не выбрано']],
                    'Attr' => [['multiple' => 'multiple', 'class' => 'multiselect']],
                ]),
                '_room' => new Type\Varchar([
                    'description' => t('Помещение (сериализованное)'),
                    'visible' => false
                ]),
                'date_start' => new Type\Date([
                    'description' => t('Дата начала аренды')
                ]),
                'date_finish' => new Type\Date([
                    'description' => t('Дата окончания аренды')
                ]),
                'sum' => new Type\Double([
                    'description' => t('Сумма арнеды в месяц')
                ]),
                'sum_discount' => new Type\Double([
                    'description' => t('Сумма со скидкой')
                ]),
                'peni' => new Type\Double([
                    'description' => t('Размер пени')
                ]),
                'start_payment' => new Type\Date([
                    'description' => t('Дата начала оплаты')
                ]),
                'start_peni' => new Type\Integer([
                    'description' => t('С какого дня начислять пени')
                ]),
                'has_dop' => new Type\Integer([
                    'description' => t('Есть доп. соглашение?'),
                    'visible' => false,
//                    'default' => 0
                ]),
            t('Состояние'),
                'balance' => new Type\Double([
                    'description' => t('Баланс')
                ]),
                'start_balance' => new Type\Double([
                    'description' => t('Стартовый баланс договора')
                ]),
                'status' => new Type\Integer([
                    'description' => t('Статус'),
                    'listFromArray' => [[
                        0 => 'Не действующий',
                        1 => 'Действующий',
                        100 => 'Скоро заканчивается'
                    ]],
                    'default' => 1
                ])
        ]);
    }

    function beforeWrite($flag)
    {
        if($this->isModified('room')){
            $this['_room'] = serialize($this['room']);
        }
    }

    function afterObjectLoad()
    {
        $this['room'] = @unserialize($this['_room']);
    }

    /**
     * Получает арендатора по договору
     * @return Renter
     */
    public function getRenter()
    {
        return new \Kirova\Model\Orm\Renter($this['renter']);
    }

    /**
     * Возвращает объект помещения по договору (с учетом доп. соглашений в котором менялись помещения)
     * @return array
     */
    public function getRooms()
    {
        $rooms = [];
        $dop = [];
        if($this['has_dop']){
            $dop = \RS\Orm\Request::make()
                ->from(new \Kirova\Model\Orm\Additional())
                ->where([
                    'contract_id' => $this['id']
                ])
                ->where('_room <> "a:0:{}"')
                ->orderby('number DESC')
                ->limit(1)
                ->exec()->fetchRow();
        }
        if(!empty($dop) && !empty($dop['room'])){
            $contract_rooms = unserialize($dop['_room']);
        }else{
            $contract_rooms = $this['room'];
        }
        foreach ($contract_rooms as $room_id){
            $rooms[] = new \Kirova\Model\Orm\Room($room_id);
        }
        return $rooms;
    }

    /**
     * Вовзращает все выставленные счета по договору
     * @return \RS\Orm\AbstractObject[]
     */
    public function getAllInvoices()
    {
        $invoices = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Invoice())
            ->where([
                'contract_id' => $this['id']
            ])
            ->orderby('finish_discount ASC')
            ->objects();
        return $invoices;
    }

    /**
     * Вовзращает все оплаты по договору
     * @param $join - соединить платежи с одинаковой датой
     * @return \RS\Orm\AbstractObject[]
     */
    public function getAllPayments($join = false)
    {
        $payments = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Payment())
            ->where([
                'contract_id' => $this['id']
            ])
            ->orderby('date ASC')
            ->objects();
        // проверяем все платежи на собпадение дат и плюсуем суммы у платежей с одинаковой датой. Записываем итоговую сумму первому платежу с одинаковой датой. Остальные удаляем.
        // Сделано для refreshBalance
        if($join && !empty($payments)){
            $payments_joined = [];
            $date = '';
            $same_date = '';
            $sum = 0;
            foreach ($payments as $key => $value){
                if($key > 0){
                   if($date == $value['date']){
                       if($sum == 0){
                           $sum = $payments[$key-1]['sum'];
                       }
                       $sum += $value['sum'];
                       $same_date = $value['date'];
                   }
                }
                $date = $value['date'];
            }
            if($same_date != '') {
                $not_del = false; // удалить платеж из массива - так как одинаковые даты и его сумма уже приплюсована к первому платежу с такой же датой
                foreach ($payments as $key => &$payment) {
                    if ($payment['date'] == $same_date) {
                        if (!$not_del) {
                            $payment['sum'] = $sum;
                        } else {
                            unset($payments[$key]);
                        }
                        $not_del = true;
                    }
                }
            }
        }
        return $payments;
    }

    /**
     * Обновляет баланс
     */
    public function refreshBalance()
    {
        $renter = new \Kirova\Model\Orm\Renter($this['renter']);

        $invoices = self::getAllInvoices();
        $payments = self::getAllPayments(true);

        $credit = 0;
        $debit = 0;
        $saldo = 0;
        $start_balance = $renter['start_balance']; //Старотовый бланс арендатора
        $trigger = false; // Выполненно ли условие предоставления скидки
        $info = [];
        $start_balance_inc = false; // Прибавлен ли к оплатам стартовый баланс

        $current_month = date('m');
        $current_year = date('Y');
        $already_exposed = false; // Выставлен ли счет за текущий месяц и год

        $config = \RS\Config\Loader::byModule('kirova');

        foreach($invoices as $key_invoice => $invoice){
            $last_day = date('t', strtotime($invoice['period_year'].'-'.$invoice['period_month'].'-01'));
            if(($invoice['period_month'] == $current_month) && ($invoice['period_year'] == $current_year)){
                $already_exposed = true;
            }
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

            // есил итерация по счетам последняя и оплат больше по количеству чем счетов - плюсуем credit
            if ($key_invoice === (count($invoices) - 1) && !empty($payments)){
                foreach ($payments as $key => $value){
                    $credit += $value['sum'];
                    $last_pament_date = intval(date('d', strtotime($value['date'])));
                }
                //Если последний счет выставлен и последняя оплата до 05 числа и сумма покрывает долг. без послднего месяца + послед. счет со скидкой
                if($already_exposed && ($debit + $invoice['sum'] >= 0) && ($last_pament_date <= $config['day_with_discount'])){
                    $trigger = true;
                }else{
                    $trigger = false;
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

           // $info['saldo'][] = $saldo.' - '.$credit. ' - ' .$debit;
           // $info['trigger'][] = $trigger;
//           $info['is_discount'][] = $is_discount;
//           $info['already_exposed'][] = $already_exposed;
           // $info['finish'][] = $invoice['period_month'] .' - '. $invoice['finish_discount'];
            $saldo = $credit - $debit;
            $trigger = false;
            $invoice->update();

        }
       // echo '<pre>';
       // var_dump($info);
       // exit();
        $this['balance'] = $saldo;
        $this->update();
    }

    /**
     * Возвращает баланс договора
     * @return mixed|Type\AbstractType
     */
    public function getBalance()
    {
        return $this['balance'];
    }

    /**
     * Возвращает сумму для выставления счета с учетом доп.соглашения в котором меняется сумма договора.
     * @param $period_month
     * @param $period_year
     * @return array|bool
     */
    public function getActualSumForInvoice($period_month, $period_year)
    {
        $dop = [];
        if($this['has_dop']){
            $dop = \RS\Orm\Request::make()
                ->from(new \Kirova\Model\Orm\Additional())
                ->where([
                    'contract_id' => $this['id']
                ])
                ->where('sum > 0')
                ->orderby('number DESC')
                ->limit(1)
                ->exec()->fetchRow();
        }
        if(!empty($dop)){

            // var_dump($period_month);
            // var_dump($period_year);
            // var_dump(date('m', strtotime($dop['date_start_additional'])));
            // var_dump(date('Y', strtotime($dop['date_start_additional'])));

            if($period_year > date('Y', strtotime($dop['date_start_additional']))){
                return $dop;
            }elseif($period_year == date('Y', strtotime($dop['date_start_additional']))){
                if($period_month >= date('m', strtotime($dop['date_start_additional']))){
                    return $dop;        
                }
            }


            // var_dump($period_month >= date('m', strtotime($dop['date_start_additional']))
            //     && $period_year >= date('Y', strtotime($dop['date_start_additional'])));
            // exit();

            // if($period_month >= date('m', strtotime($dop['date_start_additional']))
            //     && $period_year >= date('Y', strtotime($dop['date_start_additional']))){
            //     return $dop;
            // }
        }
        return false;
    }

    public function getActualSum(){
        $dop = [];
        $actual_sum = [];
        if($this['has_dop']){
            $dop = \RS\Orm\Request::make()
                ->from(new \Kirova\Model\Orm\Additional())
                ->where([
                    'contract_id' => $this['id']
                ])
                ->where('sum > 0')
                ->orderby('number DESC')
                ->limit(1)
                ->exec()->fetchRow();
        }
        if(!empty($dop)){
            return $dop;
        }
        return false;
    }

    /**
     * Получаем актуальный доп. соглашения если они есть
     * @param $param - что должно быть изменено в доп. соглашении
     * sum - изменена сумма договора, date_finish - изменена дата окончания договора, date_start - изменена дата начала договора
     * room - изменены арендованные помещения (но тогда будет изменена и сумма)
     * @return array
     */
    public function getActualDop($param)
    {
        $dop = [];
        if($this['has_dop']){
            $q = \RS\Orm\Request::make()
                ->from(new \Kirova\Model\Orm\Additional())
                ->where([
                    'contract_id' => $this['id']
                ]);
            if($param == 'sum'){
                $q->where('sum > 0');
            }
            if($param == 'date_start'){
                $q->where('date_start IS NOT NULL');
            }
            if($param == 'date_finish'){
                $q->where('`date_finish` IS NOT NULL');
            }
            if($param == 'room'){
                $q->where('room <> "a:0:{}"');
            }
            $q->orderby('number DESC')
                ->limit(1);
            $dop = $q->exec()->fetchRow();
        }
        return $dop;
    }
}
