{extends file="%alerts%/notice_template.tpl"}
{block name="content"}
    <style type="text/css">
        .table {
            border-collapse:collapse;
            border:1px solid #aaa;
        }

        .table td {
            padding:3px;
            border:1px solid #aaa;
        }
    </style>

    {include file="%crm%/notice/new_task_to_implementer_desktop.tpl"}
{/block}