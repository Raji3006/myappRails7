$(document).ready(function() {
  // Disable the signup button by default
  $('#sign-up-button').prop('disabled', true);

  // Add an event listener to each required input field
  $('.required').on('keyup change', function() {
    // Check if all required fields are filled
    var allFilled = true;
    $('.required').each(function() {
      if ($(this).val() === '') {
        allFilled = false;
        return false; // Break out of the loop
      }
    });

    // Enable/disable the signup button based on whether all required fields are filled
    $('#sign-up-button').prop('disabled', !allFilled);
  });
});
