<?php
/**
 * ReadyScript (http://readyscript.ru)
 *
 * @copyright Copyright (c) ReadyScript lab. (http://readyscript.ru)
 * @license http://readyscript.ru/licenseAgreement/
 */
namespace Kirova\Controller\Front;


use kirova\Model\InvoiceApi;
use kirova\Model\Orm\Renter;
use RS\Controller\Front;

/**
 * Просмотр одного товара
 */
class PrintInvoice extends Front
{
    protected $id;

    protected $api;
    public $config;

    function init()
    {
        $this->id = $this->url->get('id', TYPE_STRING);
        $this->api = new InvoiceApi();
        $this->config = \RS\Config\Loader::byModule('kirova');
    }

    /**
     * Обычный просмотр товара
     */
    function actionIndex()
    {
        /**
         * @var \Catalog\Model\Orm\Product $item
         */
        $item = $this->api->getById($this->id)->getValues();
        $param_print = $this->url->get('print', TYPE_INTEGER);
        $param_discount = $this->url->get('discount', TYPE_INTEGER);
        $current_user = \RS\Application\Auth::getCurrentUser();
        if (!$item){
            $this->e404(t('Такого документа не существует'));
        }
        $date = explode('-', $item['date']);
        $item['month_string'] = $this->config->getMonthStringByNumber($date[1], true);
        $item['day'] = $date[2];
        $item['year'] = $date[0];
        $renter = new Renter($item['renter_id']);
        $item['renter_name'] = $renter['short_title'];
        $contract = new \Kirova\Model\Orm\Contract($item['contract_id']);
        $item['contract_number'] = $contract['number'];
        $rooms = $contract->getRooms();
        foreach ($rooms as $key => $room){
            $item['rooms_number'][] = $room['number'];
        }
        $item['sum_string'] = $this->config->num2str($item['sum']);
        $item['sum_discount_string'] = $this->config->num2str($item['discount_sum']);
        $item['discount'] = $item['sum'] - $item['discount_sum'];
        $this->view->assign('item', $item);
        $this->view->assign('print', $param_print);
        $this->view->assign('discount', $param_discount);
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate( 'printform-invoice.tpl' );
    }
}
