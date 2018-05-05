/* Theme Name: Adminto - Admin dashboard (One page)
   Author: Coderthemes
   Author e-mail: coderthemes@gmail.com
   Version: 1.0.0
   Created: May 2016
   File Description:Main JS file of the template
*/


!function($) {
    "use strict";


    var ContactForm = function() {
        this.$contactForm = $("#contact-form"),
        this.$errorMessages = $("#err-form"),
        this.$confirmMessage = $("#success-form")
    };
    //contact form submit handler
    ContactForm.prototype.submitForm = function(e) {
        var $this = this;
        $this.$errorMessages.fadeOut('slow'); // reset the error messages (hides them)

        var data_string = $this.$contactForm.serialize(); // Collect data from form
        $.ajax({
            type: "POST",
            url: $this.$contactForm.attr('action'),
            data: data_string,
            timeout: 6000,
            cache: false,
            crossDomain: false,
            error: function (request, error) {
                $this.$errorMessages.html('An error occurred: ' + error + '');
            },
            success: function () {
                $this.$confirmMessage.show(500).delay(4000).animate({
                    height: 'toggle'
                    }, 500, function () {
                    }
                );
            }
        });
        return false;
    },

    ContactForm.prototype.init = function () {
        var $this = this;
        //initializing the contact form
        this.$contactForm.parsley().on('form:submit', function() {
            $this.submitForm();
            return false;
        });
    },
    $.ContactForm = new ContactForm, $.ContactForm.Constructor = ContactForm

}(window.jQuery)
