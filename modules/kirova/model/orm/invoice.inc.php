<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Invoice extends OrmObject
{
    protected static $table = 'invoice';

    function _init()
    {
        parent::_init()->append([
            'number' => new Type\Integer([
                'description' => t('Номер')
            ]),
            'date' => new Type\Date([
                'description' => t('Дата'),
            ]),
            'renter_string' => new Type\Varchar([
                'description' => t('Арендатор')
            ]),
            'renter_id' => new Type\Integer([
                'description' => t('Арендатор (id)')
            ]),
            'contract_id' => new Type\Integer([
                'description' => t('Договор (id)')
            ]),
            'period_month' => new Type\Varchar([
                'description' => t('Период (месяц)')
            ]),
            'period_year' => new Type\Varchar([
                'description' => t('Период (год)')
            ]),
            'sum' => new Type\Double([
                'description' => t('Сумма')
            ]),
            'discount_sum' => new Type\Double([
                'description' => t('Сумма со скидкой')
            ]),
            'is_discount' => new Type\Integer([
                'description' => t('Со скидкой?')
            ]),
            'forced_discount' => new Type\Integer([
                'description' => t('Принудительно со скидкой'),
                'default' => 0
            ]),
            'is_modified' => new Type\Integer([
                'description' => t('Модифицирован?')
            ]),
            'amount' => new Type\Double([
                'description' => t('Количество'),
                'visible' => false
            ]),
            'finish_discount' => new Type\Date([
                'description' => t('Окончание периода для оплты со скидкой (timestamp)'),
                'visible' => false
            ])
        ]);
    }
}
