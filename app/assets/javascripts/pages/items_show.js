$(document).ready(function() {

  $.each(gon.selected_items, function(key,val) { 
    var si = val.item_id;
    $("#items").find("option").each(function(){
      if(si == $(this).val()){
        var x = $(this).text();
        $(this).attr('selected','selected');
        $('.panel-body-selected').append("<p id="+si+">- "+x+"</p>");
      }
    });
  }); 
});