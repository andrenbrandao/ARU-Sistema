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
//= require bootstrap-fileupload
//= require jquery.inputmask
//= require formToWizard
//= require chosen
//= require enhance.min
//= require fileinput.jquery
//= require logotipo
//= require representante
//= require jquery.scrollTo-1.4.3.1-min
//= require highcharts/highcharts                                                           
//= require highcharts/highcharts-more                                                         
//= require_tree .

// $(function() {
//   $(document).ready( function() {
//     $("#republica_form").formToWizard({ submitButton: 'cadastro_actions' })
//   });
// });

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
    $('.chzn-select').chosen({
      no_results_text: "Escolha o curso 'Outro'. Não foi encontrado"
    });
    $('.chzn-container').tooltip({title: 'Se não encontrar seu Curso, escolha a opção "Outro"', placement: 'right'});
  }, 10);
});
});


//Mostra campo de RA se for da Unicamp
$(function() {
  $(document).on('change', '.universidade', function() {
     // this == the element that fired the change event
     if( $(':selected', this).val() == 'Unicamp') {
      $(this).next('.RA').show('slow');
      // $(this).next('.RA').find('input').enableClientSideValidations();
    }
    else {
      // $(this).next('.RA').find('input').disableClientSideValidations();
      $(this).next('.RA').hide('slow');
    }
  });
});
$(document).ready( function() {
  $('.universidade').each(function() {
    $this = $(this);
    if ($this.find(':input').val() == 'Unicamp') {
      $this.next('.RA').show();
    }
  });
});



$(document).ready( function() {
  $('.chzn-select').chosen({
   no_results_text: "Escolha o curso 'Outro'. Não foi encontrado"
 });
  // $('.chzn-select').enableClientSideValidations();
});

// Adiciona AJAX no Will_Paginate
$(document).ready(function () {
  $(".pagination a").attr('data-remote', true);
});

// Delay para AJAX de SEARCH
var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

// AJAX para Search sem clicar em botao
$(document).ready(function() {
  $("#republicas_search input").keyup(function(e) {
    delay(function() {
      $.get($("#republicas_search").attr("action"), $("#republicas_search").serialize(), null, "script")
      .done(function() { tooltipAtributos(); });
      e.preventDefault();
    }, 500);
  });
});
$(document).ready(function() {
  $('#search_btn').on('click', function() {
    $(this).fadeOut();
    $('#search_field').show('slow');
  });
});

// Cria INPUT_MASKS para Telefones e Celulares
function activeMask() {
  $('.telefone').inputmask('(99) 9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
  $('.celular').inputmask('(99) 9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
  $('.RA').find('input').inputmask('999999', {placeholder: "", clearMaskOnLostFocus: true, "clearIncomplete": false, showMaskOnHover: false });
  $('.celular').keyup(function() {
    var valor = $(this).val().substr(1,2); 
    if(valor == '11') {
      $(this).inputmask('(99) 99999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
    }
    else {
      $(this).inputmask('(99) 9999-9999', {placeholder:"_", clearMaskOnLostFocus: true, "clearIncomplete": true, showMaskOnHover: false });
    }
  });
}

$(document).ready(function() {
  activeMask();
});
$(document).ready(function(){ 
  $('a.add_nested_fields').on('click', function() {
    setTimeout( function() {
      activeMask();
    },10);
  });
});


// Layout para Navbar ATIVA
$('.navbar li a').click(function(e) {
  var $this = $(this);
  if (!$this.hasClass('active')) {
    $this.addClass('active');
  }
  e.preventDefault();
});


// Codigos para mostrar Modal
$(document).ready(function() {
  $('a.add_nested_fields').on('click', function() {
    setTimeout( function() {

      // $('#nomes-moradores').append('<p>Morador Novo</p> ' + '<%= link_to "Do" %>');

      $('.modal').last().modal('show'); // mostra MODAL
      $('.modal').on('shown', function(){
        $(ClientSideValidations.selectors.forms).validate();
      });
      isMoradorValid();

      $('.edit-morador-btn').on('click', function() {
        $this = $(this);
        $this.closest('.nomes-moradores').next('.morador-modal').modal('show');
      });

      $('a.remove_nested_fields').on('click', function() {
      $(this).closest('.modal.in').modal('hide'); // Esconde MODAL após clicar em Remover
    });
    }, 10);
  });
});

function RememberMorador() {
  $('.modal').each(function() {
    var nome = $(this).find('.nome').val();
    var sobrenome = $(this).find('.sobrenome').val();
    if(nome != '' || sobrenome != '') {
      $(this).prev('.nomes-moradores').find('.nome-morador').text(nome + ' ' + sobrenome);
    }
  });
}

function EditMorador() {
  $('.edit-morador-btn').on('click', function() {
    $this = $(this);
    $this.closest('.nomes-moradores').next('.morador-modal').modal('show');
  });
}

$(document).ready(function() {
  EditMorador();
  isMoradorValid();
  RememberMorador();
});

// Muda o nome do MORADOR caso seja feita modificação no MODAL
$(function(){
  $('.morador-modal').each(function(){ 
    var current_modal = $(this);

    $(this).find('.nome').focusout(function(){
      var nome = current_modal.find('.nome').val();
      var sobrenome = current_modal.find('.sobrenome').val();
      if(nome != "" || sobrenome != "") {
        current_modal.prev('.nomes-moradores').find('.nome-morador').text(nome + ' ' + sobrenome);
      }
    });

    $(this).find('.sobrenome').focusout(function(){
      var nome = current_modal.find('.nome').val();
      var sobrenome = current_modal.find('.sobrenome').val();
      if(nome != "" || sobrenome != "") {
        current_modal.prev('.nomes-moradores').find('.nome-morador').text(nome + ' ' + sobrenome);
      }
    });

  });


});

$(document).ready(function() {
  $('.modal').on('shown', function(){
    $(ClientSideValidations.selectors.forms).validate();
  });
});

$(document).ready(function(){
  $('#troca-senha').on('click', function(){
    $(this).slideUp();
    $('#change-pass-fields').slideDown();
  });
});

// Adiciona DICAS ao lado de USUARIO e SENHA na EDIÇÃO
$(document).ready(function(){
  $('#edit-username').tooltip( {title:'Só modifique se desejar alterar o Usuário', placement: 'right'})
  $('#edit-current-pass').tooltip( {title:'Utilize sua senha atual para confirmar as mudanças', placement: 'right'})
  $('.chzn-container').tooltip({title: 'Se não encontrar seu Curso, escolha a opção "Outro"', placement: 'right'});
});

$(document).ready(function() {
  validateEachMorador();
});

function validateEachMorador() {
  $('.modal').each(function() {
    var valid = true;
    $(this).find('.control-group').each(function() {
      if($(this).hasClass('error')) {
        valid = false;
      }
    });
    if(!valid) {
      $(this).prev('.nomes-moradores').addClass('error');
      var morador = $(this).prev('.nomes-moradores').find('li');

      if(morador.find('span:contains("Morador com erro")').length == '0') {
        morador.append('<span style="color:#B94A48">Morador com erro</span>');
      }
    }
    else {
      $(this).prev('.nomes-moradores').removeClass('error');
      $(this).prev('.nomes-moradores').find('li').find('span:contains("Morador com erro")').remove();
    }
  });
}

// Tooltips
$(document).ready(function() {
  tooltipAtributos();
});

$(document).ready(function() {
  $('#approved_link').on('click', function() {
    delay(function() {
      tooltipAtributos();
    }, 100);
  });
  $('#disapproved_link').on('click', function() {
   delay(function() {
    tooltipAtributos();
  }, 100);
 });
});
$(document).on('click', '.pagination a', function() {
 delay(function() {
  tooltipAtributos();
}, 100);
});


function tooltipAtributos() {
  $('.file').find('input').tooltip( {title:'Adicione um logotipo', placement: 'top'});
  $('.interreps').tooltip( {title:'Campeã de InterReps', placement: 'top'} );
  $('.reunioes').tooltip( {title:'Presente em Reuniões', placement: 'top'} );
  $('.nova_rep').tooltip( {title:'República Nova', placement: 'top'} );
}

// Seta EXMORADOR ao clicar no Botão
$(function() {
  $('.exmorador-btn').on('click', function() {
    if(confirm("Tem certeza de que é um ex-morador?")) {
      // $(this).next('div').find('.exmorador-input').eq(0).prop('checked', true);
      $(this).next('div').find('.exmorador-input').eq(0).val('t');
      $(this).parents('div.fields').hide('slow');
    }
  });
});

$(document).ready(function() {
  $('.marked_for_destruction').hide();
});

$(function() {
  $('#republica_logotipo').customFileInput({
    button_position : 'right'
  });
});

// Dá um SCROLL para o PRIMEIRO erro que há no FORM
// facilitando o Usuário de encontrar e consertar esse erro
$(function(){
  window.ClientSideValidations.callbacks.form.fail = function(form, eventData) {
    $.scrollTo('.error', 500, {offset:{left:0,top:-50}} );
  };
})