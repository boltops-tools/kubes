$(document).ready(function() {
  // adjust edit-page link
  var github_base = $('#edit-page').attr('href');
  var md_page = window.location.pathname.replace('/','_').replace(/\/$/,'.md');
  var href = github_base + md_page;
  $('#edit-page').attr('href', href);
});
