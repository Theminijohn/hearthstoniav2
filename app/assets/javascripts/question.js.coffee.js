 $ ->
  # enable chosen js
  $('#question_tag_list').attr("data-placeholder", "Select at least one and up to 5 Tags").chosen
    allow_single_deselect: true
    no_results_text: 'No results matched...'
    width: '100%'
    max_selected_options: 5