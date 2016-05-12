$(document).ready(function() {
  $( "input:radio" ).on( "click", function() {
    $('#weight').prop("disabled", false);
    $('#volume').prop("disabled", false);
    var selected_item_id =  $( "input:checked" ).closest('tr').children('input:hidden').val();

    $('#input_item_code').children('tr').remove();

    $("#selected_item_id").val(selected_item_id);
    $('span.break').text($( "input:checked" ).closest('tr').children('td.item_name').children('span').attr('title'));
    $('#weight').val($( "input:checked" ).closest('tr').children('td.item_weight').text());
    $('#volume').val($( "input:checked" ).closest('tr').children('td.item_volume').text());

    $.each(gon.items_suppliers, function(key,val) { 
      if(selected_item_id == val.item_id){
          var selected_supplier_id = val.supplier_id;
          var supplier_item_code = val.supplier_item_code == null ? "" : val.supplier_item_code;
          console.log(selected_supplier_id + ' mqbemb '+supplier_item_code)
          $.each(gon.account_object, function(key,val) {
            if (selected_supplier_id == val.AccountObjectID){
              var selected_supplier_code = val.AccountObjectCode;
              $('#input_item_code').append("<tr><td><input type='hidden' name='supplier_list[][supplier_id]' value='"+selected_supplier_id+"'/>"+selected_supplier_code+"</td><td><input type='text' name='supplier_list[][itemid]' class='form-control' value='"+supplier_item_code+"'></td></tr>");
            }
          });
      }
    }); 
  });
});