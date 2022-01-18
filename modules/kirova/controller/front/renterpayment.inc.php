<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class RenterPayment extends Front
{
    function actionIndex()
    {
        $current_user = \RS\Application\Auth::getCurrentUser();
        $contract_api = new \Kirova\Model\ContractApi();
        /**
         * @var \Kirova\Model\Orm\Contract $contract
         */
        $contract = $contract_api->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0, '<>')->getFirst();
        $payments = $contract->getAllPayments();

        $this->view->assign('user', $current_user);
        $this->view->assign('payments', $payments);
        $this->view->assign('contract', $contract);
        return $this->result->setTemplate('%kirova%/renter-payment.tpl');
    }
}
