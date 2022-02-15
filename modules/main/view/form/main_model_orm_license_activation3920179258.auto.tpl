
<div class="formbox" data-dialog-options='{ "width":600, "height":760 }'>
                
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="crud-form">
            <input type="submit" value="" style="display:none">
            <div class="notabs">
                                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                    
                
                
                                    <table class="otable">
                                                                                                                    
                                <tr>
                                    <td class="otitle">{$elem.__license->getTitle()}&nbsp;&nbsp;{if $elem.__license->getHint() != ''}<a class="help-icon" title="{$elem.__license->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__license->getRenderTemplate() field=$elem.__license}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__person->getTitle()}&nbsp;&nbsp;{if $elem.__person->getHint() != ''}<a class="help-icon" title="{$elem.__person->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__person->getRenderTemplate() field=$elem.__person}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__company_name->getTitle()}&nbsp;&nbsp;{if $elem.__company_name->getHint() != ''}<a class="help-icon" title="{$elem.__company_name->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__company_name->getRenderTemplate() field=$elem.__company_name}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__inn->getTitle()}&nbsp;&nbsp;{if $elem.__inn->getHint() != ''}<a class="help-icon" title="{$elem.__inn->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__inn->getRenderTemplate() field=$elem.__inn}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone->getTitle()}&nbsp;&nbsp;{if $elem.__phone->getHint() != ''}<a class="help-icon" title="{$elem.__phone->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone->getRenderTemplate() field=$elem.__phone}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__email->getTitle()}&nbsp;&nbsp;{if $elem.__email->getHint() != ''}<a class="help-icon" title="{$elem.__email->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__email->getRenderTemplate() field=$elem.__email}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__domain->getTitle()}&nbsp;&nbsp;{if $elem.__domain->getHint() != ''}<a class="help-icon" title="{$elem.__domain->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__domain->getRenderTemplate() field=$elem.__domain}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__check_domain->getTitle()}&nbsp;&nbsp;{if $elem.__check_domain->getHint() != ''}<a class="help-icon" title="{$elem.__check_domain->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__check_domain->getRenderTemplate() field=$elem.__check_domain}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>