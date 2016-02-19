$('#js-authorization').replaceWith('<%= j render partial: "full_authorization", locals: { authorization: @authorization, supplier: @supplier } %>');
if (!$("body").hasClass('sidebar-collapse')) {
  $('.sidebar-toggle').trigger('click');
};
$('#js-authorization').addClass('col-md-6').removeClass('col-md-4');
$('#js-sale').addClass('col-md-6').removeClass('col-md-10');