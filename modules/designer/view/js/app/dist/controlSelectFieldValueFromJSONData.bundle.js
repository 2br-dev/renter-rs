(window.webpackJsonp=window.webpackJsonp||[]).push([[51],{365:function(e,t,i){"use strict";var a=i(7),l=i(1);t.a={data:()=>({tinymceOptions:{height:200,theme:"modern",plugins:["link image lists anchor","searchreplace wordcount visualblocks visualchars code fullscreen media","save table contextmenu paste textcolor"],menubar:"file edit view",toolbar:"insertfile undo redo | styleselect | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons",language:"ru"},tinymceInlineOptions:{toolbar_items_size:"small",language:"ru",menubar:!1,inline:!0,plugins:"link textcolor",toolbar:"bold italic underline strikethrough",valid_elements:"*",valid_styles:{"*":"font-size,font-family,color,text-decoration,text-align"},extended_valid_elements:"*[*]",cleanup:!1,verify_html:!1,powerpaste_word_import:"clean",powerpaste_html_import:"clean",content_css:[]}}),methods:{getItemValue(e,t,i=null){let a=this.getItem();if(i){if(a.childs[i][e]&&a.childs[i][e][t])return a.childs[i][e][t].value;console.error(lang.t(`No property "${t}" in SUB CHILD item[${e}]`),a.childs[i][e])}else{if(a[e]&&a[e][t])return a[e][t].value;console.error(lang.t(`No property "${t}" in item[${e}]`),a[e])}return""},getItem(){switch(this.itemType){case l.a.atom:return this.getAtomData(this.blockId,this.itemId);case l.a.column:return this.getColumnData(this.blockId,this.itemId);case l.a.row:return this.getRowData(this.blockId,this.itemId);default:throw new Error(lang.t("Нет метода для получения данных. Тип: %0",[this.itemType]))}},getItemOptions(){return this.getItem()[this.keyName][this.item.name].data.options},setItemData(e){switch(this.itemType){case l.a.atom:this.setAtomData(e);break;case l.a.column:this.setColumnData(e);break;case l.a.row:this.setRowData(e);break;default:throw new Error(lang.t("Нет метода для получения данных. Тип: %0",[this.itemType]))}},setAtomKeyValue(e){let t=this.getItem();t[this.item.name]=e,this.setItemData(t);let i=new CustomEvent("designer.redraw-atom."+t.id,{detail:{id:t.id,value:e}});document.dispatchEvent(i),setTimeout(()=>{this.checkIfNeedSendEventAfterEdit(t)},500)},addStyleIfNeeded(e,t){"css"==this.keyName&&("background-image"==e&&t.trim().length&&(t="url('"+t+"')"),this.addStyleParameter(e,t))},checkIfNeedSendEventAfterEdit(e){if(e[this.keyName][this.item.name].debug_event){let t=new CustomEvent(e[this.keyName][this.item.name].debug_event,{detail:{id:this.itemId}});document.dispatchEvent(t)}},sendDataValueFromEvent(e){let t=e.target.value;"background-image"==this.item.name&&(t=t.replaceAll(" ","%20"));let i=this.getItem();"css"==this.keyName&&this.itemChildId?i.childs[this.itemChildId][this.keyName][this.item.name].value=t:(i[this.keyName][this.item.name].value=t,this.checkIfNeedSendEventAfterEdit(i)),this.setItemData(i)},sendDataValue(e){let t=this.getItem();"background-image"==this.item.name&&(e=e.replaceAll(" ","%20")),"css"==this.keyName&&this.itemChildId?t.childs[this.itemChildId][this.keyName][this.item.name].value=e:(t[this.keyName][this.item.name].value=e,this.checkIfNeedSendEventAfterEdit(t)),this.setItemData(t)},clear(){this.sendDataValue(""),this.isHoverable&&this.sendDataHoverValue("")},getStyleLikeObject(){let e=this.getItem();return l.b.convertInlineStyleToObject(e.attrs.style.value)},addStyleParameter(e,t){let i=this.getStyleLikeObject();"string"==typeof t?0==(t=t.trim()).length?delete i[e]:i[e]=t:"object"==typeof t&&(i[e]=t);let a=this.getItem();a.attrs.style.value=l.b.convertStyleObjectToString(i),this.setItemData(a)},...Object(a.b)("blocks",["setAtomData","setRowData","setColumnData"])},computed:{itemValue(){return this.getItemValue(this.keyName,this.item.name,this.itemChildId)},itemHoverValue(){return this.getItemHoverValue(this.keyName,this.item.name,this.itemChildId)},...Object(a.c)("blocks",["getAtomData","getColumnData","getRowData"])}}},442:function(e,t,i){"use strict";i.r(t);var a=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticClass:"d-menu-select-row"},[i("select",{on:{change:e.sendSelectValue}},[e._l(e.getOptions(),(function(t,a){return[i("option",{domProps:{value:a,selected:a==e.fieldValue}},[e._v(e._s(t))])]}))],2)])};a._withStripped=!0;var l={methods:{sendSelectValue(e){this.setAtomKeyValue(e.target.value)},getKeyValueFromData(e,t){if(!t.length)return null;let i=t.shift();return t.length?this.getKeyValueFromData(e[i],t):e[i]},getOptions(){let e=this.itemValue.toString().split("/"),t=this.getKeyValueFromData(window.global.designer,e);return null===t?(console.error(lang.t("Не правильно указан путь для аттрибута поля %field",{field:this.item.name})),[]):t}},computed:{fieldValue(){return this.getItem()[this.item.name]}}},s={name:"ControlSelectFieldValueFromJSONData",mixins:[i(365).a,l],props:{keyName:{type:String,required:!0},blockId:{type:[String,Number],required:!0},itemType:{type:String,required:!0},itemId:{type:String,required:!0},item:{type:Object,required:!0},itemChildId:{type:[String,Number]}}},n=i(98),r=Object(n.a)(s,a,[],!1,null,null,null);r.options.__file="-readyscript/modules/designer/view/js/app/src/components/leftpanel/controls/selectfieldvaluefromjsondata/selectfieldvaluefromjsondata.vue";t.default=r.exports}}]);