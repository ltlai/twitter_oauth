$(document).ready(function() {
  $('#tweet_form').submit(function(e) {
    e.preventDefault();
    $('.input-field').prop('readonly', true);
    $('.message').html('Processing tweet...');

    var tweetText = $(this).serialize();

    $.ajax({
      type: this.method,
      url: this.action,
      data: tweetText
    }).done(function(response) {
    $('.message').html(response);
  });
});
