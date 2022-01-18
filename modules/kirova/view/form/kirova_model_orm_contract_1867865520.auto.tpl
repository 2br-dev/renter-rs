
<div class="formbox" >
                
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="crud-form">
            <input type="submit" value="" style="display:none">
            <div class="notabs">
                                                                                                            
                                                                                            
                    
                
                
                                    <table class="otable">
                                                                                                                    
                                <tr>
                                    <td class="otitle">{$elem.__number->getTitle()}&nbsp;&nbsp;{if $elem.__number->getHint() != ''}<a class="help-icon" title="{$elem.__number->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__number->getRenderTemplate() field=$elem.__number}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__renter->getTitle()}&nbsp;&nbsp;{if $elem.__renter->getHint() != ''}<a class="help-icon" title="{$elem.__renter->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__renter->getRenderTemplate() field=$elem.__renter}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>