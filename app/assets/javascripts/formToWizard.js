// /*/*/* Created by jankoatwarpspeed.com */

// (function($) {
// 	$.fn.formToWizard = function(options) {
// 		options = $.extend({  
// 			submitButton: "" 
// 		}, options); 

// 		var element = this;

// 		var steps = $(element).find("fieldset");
// 		var count = steps.size();
// 		var submmitButtonName = "#" + options.submitButton;
// 		$(submmitButtonName).hide();

//         // 2
//         $(element).before("<ul id='steps'></ul>");

//         steps.each(function(i) {
//         	$(this).wrap("<div id='step" + i + "'></div>");
//         	$(this).append("<p id='step" + i + "commands'></p>");

//             // 2
//             var name = $(this).find("legend").html();
//             $("#steps").append("<li id='stepDesc" + i + "'>Passo " + (i + 1) + "<span>" + name + "</span></li>");

//             if (i == 0) {
//             	createNextButton(i);
//             	selectStep(i);
//             }
//             else if (i == count - 1) {
//             	$("#step" + i).hide();
//             	createPrevButton(i);
//             }
//             else {
//             	$("#step" + i).hide();
//             	createPrevButton(i);
//             	createNextButton(i);
//             }
//         });

//         function createPrevButton(i) {
//         	var stepName = "step" + i;
//         	$("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Prev' class='btn prev_btn'><i class='icon-arrow-left'></i> <b>Anterior</b></a>");

//         	$("#" + stepName + "Prev").bind("click", function(e) {
//         		$("#" + stepName).hide();
//         		$("#step" + (i - 1)).show();
//         		$(submmitButtonName).hide();
//         		selectStep(i - 1);
//         	});
//         }

//         function createNextButton(i) {
//         	var stepName = "step" + i;
//         	$("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Next' class='btn next_btn'><b>Próximo</b> <i class='icon-arrow-right'></i></a>");

//         	$("#" + stepName + "Next").bind("click", function(e) {


//             //If the form is valid then go to next else don't
//             var valid = true;
//               // this will cycle through all visible inputs and attempt to validate all of them.
//               // if validations fail 'valid' is set to false
//               $('[data-validate]:input:visible').each(function() {
//               	var settings = window.ClientSideValidations.forms[this.form.id]
//               	if (!$(this).isValid(settings.validators)) {
//               		valid = false
//               	}
//               });

//              // Consertar essa parte para fazer validação ao clicar no botão NEXT
//              if($(this).attr('id') == 'step1Next') {
//              	alert('hey');
//              	$('.modal').each(function() {
//           		$(this).validate();
//           		$(this).enableClientSideValidations();
// 	              	$(this).find('[data-validate]:input').each( function() { 

// 	              	var settings = window.ClientSideValidations.forms[this.form.id]
// 	              	if (!$(this).isValid(settings.validators)) {
// 	              		valid = false;
// 	              	}
//               });
//               });

//           }

//               if(!valid){
//                 // if any of the inputs are invalid we want to disrupt the click event
//                 return valid;
//             }


//             $("#" + stepName).hide();
//             $("#step" + (i + 1)).show();
//             if (i + 2 == count)
//             	$(submmitButtonName).show();
//             selectStep(i + 1);
//         });
// }

// function selectStep(i) {
// 	$("#steps li").removeClass("current");
// 	$("#stepDesc" + i).addClass("current");
// }

// }
// })(jQuery); */*/