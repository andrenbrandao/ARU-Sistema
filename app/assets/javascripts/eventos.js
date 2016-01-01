$(function() {
	$("#exmoradores input:checkbox:not(:checked)").attr("disabled", true);

	check_exmoradores_and_agregados();

	$("#exmoradores input:checkbox").on('click', function(){
	  check_exmoradores_and_agregados();
	});
	$("#evento_evento_republicas_attributes_0_opcao_1").change( function(){
	  empty_values();
	  check_exmoradores_and_agregados();

	});
	$("#evento_evento_republicas_attributes_0_opcao_2").change(function(){
	  empty_values();
	  check_exmoradores_and_agregados();
	});
});

function check_exmoradores_and_agregados() {
	$max1_ex = $("#evento_max1_ex").val();
	$max2_ex = $("#evento_max2_ex").val();
	$max1_ag = $("#evento_max1_ag").val();
	$max2_ag = $("#evento_max2_ag").val();

	if( $("#evento_evento_republicas_attributes_0_opcao_2:checked").size() == 1) {
		$max_ex = $max2_ex;
		$max_ag = $max2_ag;
	} else {
		$max_ex = $max1_ex;
		$max_ag = $max1_ag;
	}

	$length = $("#exmoradores input:checkbox:checked").size();
	  if ( $length >= $max_ex ) {
	    $("#exmoradores input:checkbox:not(:checked)").attr("disabled", true);
	  } else {
	    $("#exmoradores input:checkbox").removeAttr("disabled");
	  }

	$(".agregado").show();

	$(".agregado").slice($max_ag).hide();

	$("input.agregado").each(function() {
		if($(this).val() != "") {
			$(this).show();
		}
	});
}

function empty_values() {
	$("#exmoradores input:checkbox").prop("checked", false);
	$("input.agregado").val("");
}