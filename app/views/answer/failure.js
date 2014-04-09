$('#flash').remove();

$('#new_answer').before(
  '<% flash.each do |key, value| %>\
    <div id="flash" class="alert alert-danger alert-dismissable fade in">\
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>\
      <%= value%>\
    </div>\
  <%end%>'
);