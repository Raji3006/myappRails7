$(document).ready(function() {
  // Disable the "Create Message" button initially
  $('#createButton').prop('disabled', true);

  // Listen for changes in the message field
  $('#messageField').on('input', function() {
    // Check if the message field is empty
    if ($(this).val().trim() === '') {
      // Disable the button if the message field is empty
      $('#createButton').prop('disabled', true);
    } else {
      // Enable the button if the message field has a value
      $('#createButton').prop('disabled', false);
    }
  });
});
