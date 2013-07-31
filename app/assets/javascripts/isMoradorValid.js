            
function isMoradorValid() {
  $(".confirm-morador").bind("click", function(e) {
    delay( function() {
      validateEachMorador();
    }, 100);

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
    if (!validateRA()) {
      valid = false;
    }
    if (!validateRepresentante()) {
      valid = false;
    }
    if(!validateCurso()) {
      valid = false;
    }
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



  //    // INICIO de CHECK MORADORES com BOTAO de CADASTRO
  //    $('#cadastro_actions').find('input[name="commit"]').bind("click", function(e) {

  //     //If the form is valid then go to next else don't
  //     var valid = true;
  //   // this will cycle through all visible inputs and attempt to validate all of them.
  //   // if validations fail 'valid' is set to false
  //   $('.morador-modal').each(function() {
  //     $(this).find('[data-validate]:input').each(function() {
  //       var settings = window.ClientSideValidations.forms[this.form.id]
  //       if (!$(this).isValid(settings.validators)) {
  //         valid = false;
  //       }
  //     });
  //   });

  //     if (!validateRA()) {
  //       valid = false;
  //     }
  //     if (!validateRepresentante()) {
  //       valid = false;
  //     }
  //     if(!validateCurso()) {
  //       valid = false;
  //     }



  //     delay( function() {
  //       validateEachMorador();
  //     }, 100);

  // });
  // TERMINA CHECK MORADORES com BOTAO DE CADASTRO

}

$(function() {
  $(document).on('change', '.universidade', function(){
    if( $(':selected', this).val() == 'Unicamp') {
      $(this).next('.RA').bind('focusout', function() {
        var input = $(this).find('input'),
        divRA = $(this);
        // if(input.val() == '') {
        //   divRA.find('.control-group').addClass('error');
        //   if(divRA.find('span.help-inline').length == '0') {
        //     divRA.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
        //   }

        //   else if(divRA.find('span')) {
        //    divRA.find('span').text('não pode ficar em branco')
        // }
        // }
        
        if(input.val().length != '6' && input.val().length != '0') {
          divRA.find('.control-group').addClass('error');
          if(divRA.find('span.help-inline').length == '0') {
            divRA.find('.controls').append('<span class="help-inline">RA inválido</span>');
          }
          else if(divRA.find('span')) {
            divRA.find('span').text('RA inválido')
          }
        }
        
        else if(input.val().length == '6') {
          divRA.find('.control-group').removeClass('error');
          divRA.find('span').remove();
        }

        else if(input.val().length == '0') {
          divRA.find('.control-group').removeClass('error');
          divRA.find('span').remove();
        }
      });
          }
          else {
            $(this).next('.RA').find('.control-group').removeClass('error');
            $(this).next('.RA').find('span').remove();
            $(this).next('.RA').find('input').val('');
          }
        });
          });

            function validateRA() {
              var valid = true;

              var input = $('.in').find('.RA').find('input'),
              divRA = $('.in').find('.RA');
              if($('.in .universidade :selected').val() == 'Unicamp') {
      // if(input.val() == '') {
      //   divRA.find('.control-group').addClass('error');
      //   if(divRA.find('span.help-inline').length == '0') {
      //     divRA.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
      //   }
      //   else if(divRA.find('span')) {
      //     divRA.find('span').text('não pode ficar em branco')
      //   }
      //   valid = false;
      // }
      
      if(input.val().length != '6' && input.val().length != '0') {
        divRA.find('.control-group').addClass('error');
        if(divRA.find('span.help-inline').length == '0') {
          divRA.find('.controls').append('<span class="help-inline">RA inválido</span>');
        }
        else if(divRA.find('span')) {
          divRA.find('span').text('RA inválido')
        }
        valid = false;
      }

      else if(input.val().length == '6') {
        divRA.find('.control-group').removeClass('error');
        divRA.find('span').remove();
      }

      else if(input.val().length == '0') {
        divRA.find('.control-group').removeClass('error');
        divRA.find('span').remove();
      }
    }
    return valid;
  }

  $(function() {
    var emailRegexp = new RegExp(/^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i);

    $(document).on('change', '.radio_but', function(){
     $(this).next('.repres_field').find('.email :input').bind('focusout', function() {
      var input = $('.in').find('.email :input'),
      divEmail = $('.in').find('.email').parents('.repres_field');
      if(input.val() == '') {
        divEmail.find('.control-group').addClass('error');
        if(divEmail.find('span.help-inline').length == '0') {
          divEmail.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
        }
        else if(divEmail.find('span')) {
          divEmail.find('span').text('não pode ficar em branco');
        }
      }
      else if(emailRegexp.test(input.val()) == false) {
        divEmail.find('.control-group').addClass('error');
        if(divEmail.find('span.help-inline').length == '0') {
          divEmail.find('.controls').append('<span class="help-inline">email inválido</span>');
        }
        else if(divEmail.find('span')) {
          divEmail.find('span').text('email inválido');
        }
      }

      else if(emailRegexp.test(input.val()) == true) {
        divEmail.find('.control-group').removeClass('error');
        divEmail.find('span').remove();
      }
    });


            $(this).siblings('.repres_field').eq(1).find('.celular').bind('focusout', function() {
              var input = $('.in').find('.celular'),
              divCelular = $('.in').find('.celular').parents('.repres_field');
              if(input.val() == '') {
                divCelular.find('.control-group').addClass('error');
                if(divCelular.find('span.help-inline').length == '0') {
                  divCelular.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
                }

                else if(divCelular.find('span')) {
                  divCelular.find('span').text('não pode ficar em branco');
                }

              }
              else if(input.inputmask("isComplete")) {
                divCelular.find('.controls').find('span').remove();
                divCelular.find('.control-group').removeClass('error');
              }
            });

          });
          });

            function validateRepresentante() {
              var emailRegexp = new RegExp(/^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i);
              var valid = true;

              if($('.in .radio_but').find('input').is(':checked') ) {

                var input = $('.in').find('.email :input'),
                divEmail = $('.in').find('.email').parent('.repres_field');
                if(input.val() == '') {
                  divEmail.find('.control-group').addClass('error');
                  if(divEmail.find('span.help-inline').length == '0') {
                    divEmail.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
                  }

                  else if(divEmail.find('span')) {
                    divEmail.find('span').text('não pode ficar em branco');
                  }

                  valid = false;
                }
                else if(emailRegexp.test(input.val()) == false) {
                  divEmail.find('.control-group').addClass('error');
                  if(divEmail.find('span.help-inline').length == '0') {
                    divEmail.find('.controls').append('<span class="help-inline">email inválido</span>');
                  }

                  else if(divEmail.find('span')) {
                    divEmail.find('span').text('email inválido');
                  }

                  valid = false;
                }

                var inputCel = $('.in').find('.celular'),
                divCelular = $('.in').find('.celular').parents('.repres_field');
                if(inputCel.val() == '') {
                  divCelular.find('.control-group').addClass('error');
                  if(divCelular.find('span.help-inline').length == '0') {
                    divCelular.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
                  }

                  else if(divCelular.find('span')) {
                    divCelular.find('span').text('não pode ficar em branco');
                  }

                  valid = false;
                }
                else {
                  divCelular.find('.controls').find('span').remove();
                  divCelular.find('.control-group').removeClass('error');
                }

              }
              return valid;

            }

            $(function() {
              $('a.add_nested_fields').on('click', function() {
                setTimeout( function() { 
                  validateCursoClick();
                });
              });
              validateCursoClick();
            });

            function validateCursoClick() {
              $('.chzn-select').change( function() {  
                var span = $('.in').find('.curso').siblings('div').eq(0).find('span'),
                cursoControlGroup = $('.in').find('.curso').parents('.control-group');
                if(span.text() == 'Curso') {
                  cursoControlGroup.addClass('error');
                  if(cursoControlGroup.find('span.help-inline').length == '0') {
                    cursoControlGroup.find('span').css('color', '#B94A48');
                    cursoControlGroup.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
                  }
                  else if(cursoControlGroup.find('span.help-inline')) {
                    cursoControlGroup.find('span.help-inline').text('não pode ficar em branco')
                  }
                }

                else {
                  cursoControlGroup.find('span').css('color', '#444');
                  cursoControlGroup.removeClass('error');
                  cursoControlGroup.find('span.help-inline').remove();
                }
              });
          }

          function validateCurso() {
            var valid = true;

            var span = $('.in').find('.curso').siblings('div').eq(0).find('span'),
            cursoControlGroup = $('.in').find('.curso').parents('.control-group');
            if(span.text() == 'Curso') {
              cursoControlGroup.addClass('error');
              if(cursoControlGroup.find('span.help-inline').length == '0') {
                cursoControlGroup.find('span').css('color', '#B94A48');
                cursoControlGroup.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
              }
              else if(cursoControlGroup.find('span.help-inline')) {
                cursoControlGroup.find('span.help-inline').text('não pode ficar em branco')
              }
              valid = false;
            }

            else {
              cursoControlGroup.find('span').css('color', '#444');
              cursoControlGroup.removeClass('error');
              cursoControlGroup.find('span.help-inline').remove();
            }

            return valid;
          }





  // Ativa validação em Email e Celular quando MODAL aparecer
  $(function() {
    var emailRegexp = new RegExp(/^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i);

    $('.modal').on('shown', function(){
     $('.radio_but').next('.repres_field').find('.email :input').bind('focusout', function() {
      var input = $('.in').find('.email :input'),
      divEmail = $('.in').find('.email').parents('.repres_field');
      if(input.val() == '') {
        divEmail.find('.control-group').addClass('error');
        if(divEmail.find('span.help-inline').length == '0') {
          divEmail.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
        }
        else if(divEmail.find('span')) {
          divEmail.find('span').text('não pode ficar em branco');
        }
      }
      else if(emailRegexp.test(input.val()) == false) {
        divEmail.find('.control-group').addClass('error');
        if(divEmail.find('span.help-inline').length == '0') {
          divEmail.find('.controls').append('<span class="help-inline">email inválido</span>');
        }
        else if(divEmail.find('span')) {
          divEmail.find('span').text('email inválido');
        }
      }

      else if(emailRegexp.test(input.val()) == true) {
        divEmail.find('.control-group').removeClass('error');
        divEmail.find('span').remove();
      }
    });


            $('.radio_but').siblings('.repres_field').eq(1).find('.celular').bind('focusout', function() {
              var input = $('.in').find('.celular'),
              divCelular = $('.in').find('.celular').parents('.repres_field');
              if(input.val() == '') {
                divCelular.find('.control-group').addClass('error');
                if(divCelular.find('span.help-inline').length == '0') {
                  divCelular.find('.controls').append('<span class="help-inline">não pode ficar em branco</span>');
                }

                else if(divCelular.find('span')) {
                  divCelular.find('span').text('não pode ficar em branco');
                }

              }
              else if(input.inputmask("isComplete")) {
                divCelular.find('.controls').find('span').remove();
                divCelular.find('.control-group').removeClass('error');
              }
            });

          });
          });