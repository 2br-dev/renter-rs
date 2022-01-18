<?php

namespace kirova\Controller\Admin;

use kirova\Model\RenterApi;
use RS\Controller\Admin\Crud;
use RS\Html\Filter;
use RS\Html\Table;
use RS\Html\Table\Type as TableType;

/**
 * Контроллер Управление списком магазинов сети
 */
class RentersCtrl extends Crud
{
    function __construct()
    {
        //Устанавливаем, с каким API будет работать CRUD контроллер
        parent::__construct(new RenterApi());
    }

    function helperIndex()
    {
        $helper = parent::helperIndex(); //Получим helper по-умолчанию
        $helper->setTopTitle('Арендаторы'); //Установим заголовок раздела

        //Отобразим таблицу со списком объектов
        $helper->setTable(new Table\Element([
            'Columns' => [
                new TableType\Checkbox('id', ['ThAttr' => ['width' => 20]]),
                new TableType\Text('short_title', 'Название', [
                    'Sortable' => SORTABLE_BOTH,
                    'href' => $this->router->getAdminPattern('edit', [':id' => '@id']),
                    'LinkAttr' => ['class' => 'crud-edit'],
                ]),
                new TableType\Text('balance', 'Баланс'),
                new TableType\Actions('id', [
                    new TableType\Action\Edit($this->router->getAdminPattern('edit', [':id' => '~field~'])),
                ], ['SettingsUrl' => $this->router->getAdminUrl('tableOptions')]),
            ],
        ]));

        //Добавим фильтр значений в таблице по названию
        $helper->setFilter(new Filter\Control([
            'Container' => new Filter\Container([
                'Lines' => [
                    new Filter\Line(['items' => [
                        new Filter\Type\Text('short_title', 'Кр. название', ['SearchType' => '%like%']),
                    ]]),
                ],
            ]),
        ]));

        return $helper;
    }
}
