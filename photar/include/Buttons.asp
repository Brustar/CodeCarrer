<% if mode="NewInfo" then %>
<input type="button" name="bt1" value="����" class="text3" onClick="checkform('New')">
<% Elseif mode="EditInfo" then %>
          <input type="button" name="bt2" value="�޸�" class="text3" onClick="checkform('Edit')">
          <input type="button" name="bt3" value="ɾ��" class="text3" onClick="checkform('Del')"> 
<input type="button" name="bt4" value="����ͨ��" class="text3" onClick="checkform('Pass')">
          <input type="button" name="bt5" value="������ͨ��" class="text3" onClick="checkform('NotPass')">
<% End If %>
        <input type="button" name="btBack" value="����" class="text3" onClick="javascript:history.back();">