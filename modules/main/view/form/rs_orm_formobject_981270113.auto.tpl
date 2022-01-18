
<div class="formbox" >
                
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="crud-form">
            <input type="submit" value="" style="display:none">
            <div class="notabs">
                                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                    
                
                
                                    <table class="otable">
                                                                                                                    
                                <tr>
                                    <td class="otitle">{$elem.__grid_system->getTitle()}&nbsp;&nbsp;{if $elem.__grid_system->getHint() != ''}<a class="help-icon" title="{$elem.__grid_system->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__grid_system->getRenderTemplate() field=$elem.__grid_system}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_one_click_cart->getTitle()}&nbsp;&nbsp;{if $elem.__enable_one_click_cart->getHint() != ''}<a class="help-icon" title="{$elem.__enable_one_click_cart->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_one_click_cart->getRenderTemplate() field=$elem.__enable_one_click_cart}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_favorite->getTitle()}&nbsp;&nbsp;{if $elem.__enable_favorite->getHint() != ''}<a class="help-icon" title="{$elem.__enable_favorite->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_favorite->getRenderTemplate() field=$elem.__enable_favorite}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_compare->getTitle()}&nbsp;&nbsp;{if $elem.__enable_compare->getHint() != ''}<a class="help-icon" title="{$elem.__enable_compare->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_compare->getRenderTemplate() field=$elem.__enable_compare}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_comments->getTitle()}&nbsp;&nbsp;{if $elem.__enable_comments->getHint() != ''}<a class="help-icon" title="{$elem.__enable_comments->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_comments->getRenderTemplate() field=$elem.__enable_comments}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_amount_in_product_card->getTitle()}&nbsp;&nbsp;{if $elem.__enable_amount_in_product_card->getHint() != ''}<a class="help-icon" title="{$elem.__enable_amount_in_product_card->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_amount_in_product_card->getRenderTemplate() field=$elem.__enable_amount_in_product_card}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_number1->getTitle()}&nbsp;&nbsp;{if $elem.__phone_number1->getHint() != ''}<a class="help-icon" title="{$elem.__phone_number1->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_number1->getRenderTemplate() field=$elem.__phone_number1}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_description1->getTitle()}&nbsp;&nbsp;{if $elem.__phone_description1->getHint() != ''}<a class="help-icon" title="{$elem.__phone_description1->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_description1->getRenderTemplate() field=$elem.__phone_description1}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_number2->getTitle()}&nbsp;&nbsp;{if $elem.__phone_number2->getHint() != ''}<a class="help-icon" title="{$elem.__phone_number2->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_number2->getRenderTemplate() field=$elem.__phone_number2}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_description2->getTitle()}&nbsp;&nbsp;{if $elem.__phone_description2->getHint() != ''}<a class="help-icon" title="{$elem.__phone_description2->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_description2->getRenderTemplate() field=$elem.__phone_description2}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__enable_page_fade->getTitle()}&nbsp;&nbsp;{if $elem.__enable_page_fade->getHint() != ''}<a class="help-icon" title="{$elem.__enable_page_fade->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__enable_page_fade->getRenderTemplate() field=$elem.__enable_page_fade}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__cat_description_bottom->getTitle()}&nbsp;&nbsp;{if $elem.__cat_description_bottom->getHint() != ''}<a class="help-icon" title="{$elem.__cat_description_bottom->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__cat_description_bottom->getRenderTemplate() field=$elem.__cat_description_bottom}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>