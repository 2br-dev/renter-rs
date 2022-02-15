
<div class="formbox" data-dialog-options='{ "width":600, "height":360 }'>
                
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="crud-form">
            <input type="submit" value="" style="display:none">
            <div class="notabs">
                                                                                                            
                    
                
                
                                    <table class="otable">
                                                                                                                    
                                <tr>
                                    <td class="otitle">{$elem.__license->getTitle()}&nbsp;&nbsp;{if $elem.__license->getHint() != ''}<a class="help-icon" title="{$elem.__license->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__license->getRenderTemplate() field=$elem.__license}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>