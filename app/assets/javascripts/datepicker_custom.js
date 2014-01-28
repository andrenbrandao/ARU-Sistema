 $(function() {
 	$('.add_nested_fields').on('click', function() {
 		delay(function() { 
 			$('.datepicker').datetimepicker({
 				pickTime: false
 			});
 		}, 200);
 	});
 });