            
function isMoradorValid() {
  $(".confirm-morador").bind("click", function(e) {


            //If the form is valid then go to next else don't
            var valid = true;
              // this will cycle through all visible inputs and attempt to validate all of them.
              // if validations fail 'valid' is set to false
              $('.in').find('[data-validate]:input').each(function() {
                var settings = window.ClientSideValidations.forms[this.form.id]
                if (!$(this).isValid(settings.validators)) {
                  valid = false;
                }
              });
              if(!valid){
                // if any of the inputs are invalid we want to disrupt the click event
                return valid;
              }
              else {
                var nome = $('.in').find('.nome').val();
                var sobrenome = $('.in').find('.sobrenome').val();
                $(this).closest('.modal.in').prev('.nomes-moradores').find('.nome-morador').text(nome + ' ' + sobrenome);
        $(this).closest('.modal.in').modal('hide'); // Esconde MODAL após clicar em OK
      }
    });
          }