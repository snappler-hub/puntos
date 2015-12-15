$('#modal_one').modal('hide');
$('#stock_entries').prepend('<%= j render('stock_entry', stock_entry: @new_stock_entry) %>');
$('#real_stock_container').html('<%= @reward.real_stock.to_i %>');