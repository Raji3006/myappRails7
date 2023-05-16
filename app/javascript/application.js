// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "foundation-sites"
import jquery from 'jquery'
window.$ = jquery

$(document).ready( function () {
  // $('#myTable').DataTable();
  $(document).foundation();
} );

