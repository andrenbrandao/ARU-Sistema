// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require rails.validations
//= require rails.validations.simple_form
//= require rails.validations.nested_form
//= require bootstrap
//= require jquery.inputmask
//= require formToWizard
//= require chosen-jquery
//= require_tree .

$(function() {
  $(document).ready( function() {
    $("#republica_form").formToWizard({ submitButton: 'cadastro_actions' })
  });
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

// Utilizado para ATUALIZAR o CLIENT-SIDE-VALIDATIONS em NESTED FIELDS com APPLICATION HELPER
$(function () {
 $('a').on('click', function() {
  setTimeout(function() { 
    $('.fields').find(':input').enableClientSideValidations();
    $('.chzn-select').chosen();
  }, 10);
});
});


//Mostra campo de RA se for da Unicamp
$(function() {
  $(document).on('change', '#universidade', function() {
     // this == the element that fired the change event
     if( $(':selected', this).val() == 'Unicamp') {
      $(this).next('#RA').show('slow');
    }
    else {
      $(this).next('#RA').hide('slow');
    }
  });
});

// Mostra campos de REPRESENTANTE se for selecionado
$(function() {
  $(document).on('change', '.radio_but', function() {
    // esconde os campos e modifica valor a cada mudança
    $('.repres_field').hide('slow');
    $('.repres_input').val('false');

    // modificação dos campos para representante
    $(this).nextAll('.repres_field').show('slow');    
    $(this).prev('#representante').find('input').val('true');
  });
});

$(document).ready( function() {
  $('.repres_input').each(function() {
    $this = $(this);
    if ($this.val() == 't' || $this.val() == 'true') {
      $this.closest('div').next('.radio_but').find('input').prop('checked', true);
      $this.closest('div').nextAll('.repres_field').show();
    }
  });
});

$(document).ready( function() {
  $('.chzn-select').chosen();
  $('.chzn-select').enableClientSideValidations();
});

// Adiciona AJAX no Will_Paginate
$(document).ready(function () {
  $(".pagination a").attr('data-remote', true);
});

// AJAX para Search sem clicar em botao
$(document).ready(function() {
  $("#republicas_search input").keyup(function(e) {
    $.get($("#republicas_search").attr("action"), $("#republicas_search").serialize(), null, "script");
    e.preventDefault();
  });
});

$(document).ready(function() {
  $('#search_btn').on('click', function() {
    $(this).fadeOut();
    $('#search_field').show('slow');
  });
});

// Cria INPUT_MASKS para Telefones e Celulares
$(document).ready(function() {
  $('.telefone').inputmask('9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
  $('.celular').inputmask('(99) 9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
  $('.celular').keyup(function() {
    var valor = $(this).val().substr(1,2); 
    if(valor == '11') {
      $(this).inputmask('(99) 99999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
    }
    else {
      $(this).inputmask('(99) 9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
    }
  });
});

// $(document).ready( function() {
//   $('a#login-link').on('click', function() {
//     $(this).modal('show');

//   });
// });