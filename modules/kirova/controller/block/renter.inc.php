<?php
/**
 * ReadyScript (http://readyscript.ru)
 *
 * @copyright Copyright (c) ReadyScript lab. (http://readyscript.ru)
 * @license http://readyscript.ru/licenseAgreement/
 */

namespace Kirova\Controller\Block;

use Catalog\Model\Api as ProductApi;
use Catalog\Model\DirApi;
use Catalog\Model\Orm\Dir;
use kirova\Model\ContractApi;
use kirova\Model\RenterApi;
use RS\Cache\Manager as CacheManager;
use RS\Controller\StandartBlock;
use RS\Debug\Action as DebugAction;
use RS\Debug\Tool as DebugTool;
use RS\Helper\Paginator;
use RS\Helper\Tools as HelperTools;
use RS\Module\AbstractModel\TreeList\AbstractTreeListIterator;
use RS\Orm\Type;

/**
 * Контроллер - топ товаров из указанных категорий одним списком
 */
class Renter extends StandartBlock
{
    protected static $controller_title = 'Главная страница для Арендатора';
    protected static $controller_description = 'Отображает страницу для арендатора';

    protected $default_params = [
        'indexTemplate' => '%kirova%/blocks/renter.tpl', //Должен быть задан у наследника
        'pageSize' => 100,
    ];
    protected $page;

    /** @var ProductApi $api */
    public $api;

    function init()
    {
        $this->api = new RenterApi();
    }

    function actionIndex()
    {
        $current_user = \RS\Application\Auth::getCurrentUser();
        $contract_api = new \Kirova\Model\ContractApi();
        /**
         * @var \Kirova\Model\Orm\Contract $contract
         */
        $contract = $contract_api->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0, '<>')->getFirst();
        $contract->refreshBalance(); // Каждый раз при перезагрузки обновляем баланс договора
        $renter = new \Kirova\Model\Orm\Renter($current_user['renter_id']);
        $contract_rooms = $contract->getRooms();
        foreach ($contract_rooms as $room){
            $room_array = $room->getValues();
            $rooms[] = $room_array['number'];
        }
        $contract['rooms'] = $rooms;
        if($contract['has_dop']){
            $actual_sum = $contract->getActualSum();
            if($actual_sum){
                $contract['sum'] = $actual_sum['sum'];
                $contract['sum_discount'] = $actual_sum['sum_discount'];
            }

        }
        $this->view->assign([
            'renter' => $renter,
            'contract' => $contract
        ]);
        return $this->result->setTemplate($this->getParam('indexTemplate'));
    }
}
