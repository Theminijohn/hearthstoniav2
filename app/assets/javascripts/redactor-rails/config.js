$(document).ready(
  function(){
  var csrf_token = $('meta[name=csrf-token]').attr('content');
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var params;
  if (csrf_param !== undefined && csrf_token !== undefined) {
    params = csrf_param + "=" + encodeURIComponent(csrf_token);
  }
  $('.redactor').redactor(
    { buttons: [ 'bold', 'italic', 'deleted', '|', 'table', 'link', '|',
                 'alignment', '|', 'unorderedlist', 'orderedlist', '|',
                 'horizontalrule'], "css":"redactor-style.css.scss",
                 toolbarFixed: true }
  );
});
