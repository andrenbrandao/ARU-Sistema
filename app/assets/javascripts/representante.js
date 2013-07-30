// Mostra campos de REPRESENTANTE se for selecionado
$(function() {
  $(document).on('change', '.radio_but', function() {
    var current_but = $(this).find('input');
    // esconde os campos e modifica valor a cada mudança
    if(!($(this).find('input').is(':checked'))) {
      $('.repres_field').hide('slow');
      $('.repres_field').each( function() {
        $(this).find('.control-group').removeClass('error')
        .find('span.help-inline').remove();
        $(this).find('input').val('');
      });
      $('.repres_input').val('false');
    }
    else {
      $('.radio_but').each(function() {
        if(!(current_but.is($(this).find('input')))) {
          $(this).find('input').prop('checked', false);
          $(this).prev('#representante').find('input').val('false');

          $(this).nextAll('.repres_field').each( function() {
            $(this).find('.control-group').removeClass('error')
            .find('span.help-inline').remove();
            $(this).find('input').val('');
            $(this).hide();
          });
        }
      });

    // modificação dos campos para representante
    $(this).nextAll('.repres_field').show('slow');
    // $(this).nextAll('.repres_field').find('input').enableClientSideValidations();    
    $(this).prev('#representante').find('input').val('true');
  }
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


$(function() {
  displayRepresentante();
});

$(function() {
  $(document).on('change', '.radio_but', function() {
    displayRepresentante();
  })
});

function displayRepresentante() {
  $('.modal').each(function() {
    var representante = false;
    var morador = $(this).prev('.nomes-moradores').find('li');

    representante = $(this).find('.radio_but').find('input').is(':checked')
    
    if(representante) {
      if(morador.find('.icon-user').length == '0') {
        morador.prepend('<i class="icon-user"></i>');
        morador.find('.icon-user').tooltip( {title:'Representante', placement: 'top'} );
      }
    }
    else {
     morador.find('.icon-user').remove();
   }
 });
}