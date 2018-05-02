{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.7                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2018                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{include file="CRM/common/pager.tpl" location="top"}

{if $rows}
    <div class="crm-content-block crm-block">
    <div id="custom_group">
     {strip}
   {* handle enable/disable actions*}
   {include file="CRM/common/enableDisableApi.tpl"}
      <table id="options" class="row-highlight">
        <thead>
          <tr>
            
            {foreach from=$columnHeaders item=header}
              <th scope="col">
                {if $header.sort}
                  {assign var='key' value=$header.sort}
                  {$sort->_response.$key.link}
                {else}
                  {$header.name}
                {/if}
              </th>
            {/foreach}
      
          </tr>
        </thead>
        <tbody>
        {foreach from=$rows item=row}
        <tr id="CustomGroup-{$row.id}" data-action="setvalue" class="crm-entity {cycle values="odd-row,even-row"} {$row.class}{if NOT $row.is_active} disabled{/if}">
          <td class="crmf-title crm-editable">{$row.title} </td>
          <td><a href="#" class="crm-summary-link crm-fields-link"><div class="tooltip-icon crm-icon Fields-icon"></div>
              <div class="crm-tooltip-wrapper">
                <div class="crm-tooltip">
                  <div class="crm-fields-group">
                    <table class="crm-table-group-fields">
                      <tbody>
                        {foreach from=$row.custom_fields_name item=fields}
                        <tr><td>{$fields}</td></tr>
                        {/foreach}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </a>
          </td>
          <td id="row_{$row.id}_status">{if $row.is_active eq 1} {ts}Yes{/ts} {else} {ts}No{/ts} {/if}</td>
          <td>{if $row.extends eq 'Contact'}{ts}All Contact Types{/ts}{else}{$row.extends_display}{/if}</td>
          <td>{$row.extends_entity_column_value}</td>
          <td class="nowrap">{$row.weight}</td>
          <td>{$row.style_display}</td>
          <td>{$row.action|replace:'xx':$row.id}</td>
        </tr>
        {/foreach}
        </tbody>
      </table>

        {if NOT ($action eq 1 or $action eq 2) }
        <div class="action-link">
        {crmButton p='civicrm/admin/custom/group' q="action=add&reset=1" id="newCustomDataGroup"  icon="plus-circle"}{ts}Add Set of Custom Fields{/ts}{/crmButton}
        </div>
        {/if}

        {/strip}
    </div>
    </div>
    {else}
       {if $action ne 1} {* When we are adding an item, we should not display this message *}
       <div class="messages status no-popup">
       <img src="{$config->resourceBase}i/Inform.gif" alt="{ts}status{/ts}"/> &nbsp;
         {capture assign=crmURL}{crmURL p='civicrm/admin/custom/group' q='action=add&reset=1'}{/capture}
         {ts 1=$crmURL}No custom data groups have been created yet. You can <a id="newCustomDataGroup" href='%1'>add one</a>.{/ts}
       </div>
       {/if}
    {/if}
    
{include file="CRM/common/pager.tpl" location="bottom"}
{crmScript file='js/crm.expandRow.js'}
