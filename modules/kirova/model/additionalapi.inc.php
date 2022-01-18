<?php

namespace kirova\Model;

use kirova\Model\Orm\Additional;
use RS\Module\AbstractModel\EntityList;

/**
 * Класс для организации выборок ORM объекта.
 * В этом классе рекомендуется также реализовывать любые дополнительные методы, связанные с заявленной в конструкторе моделью
 */
class AdditionalApi extends EntityList
{
    function __construct()
    {
        parent::__construct(new Additional());
    }
}
