<% if mode="NewInfo" then %>
<input type="button" name="bt1" value="新增" class="text3" onClick="checkform('New')">
<% Elseif mode="EditInfo" then %>
          <input type="button" name="bt2" value="修改" class="text3" onClick="checkform('Edit')">
          <input type="button" name="bt3" value="删除" class="text3" onClick="checkform('Del')"> 
<input type="button" name="bt4" value="审批通过" class="text3" onClick="checkform('Pass')">
          <input type="button" name="bt5" value="审批不通过" class="text3" onClick="checkform('NotPass')">
<% End If %>
        <input type="button" name="btBack" value="返回" class="text3" onClick="javascript:history.back();">