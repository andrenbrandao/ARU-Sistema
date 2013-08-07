module ApplicationHelper


	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = (column == sort_column) ? "current #{sort_direction}" : nil
		direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction}, {:class => "#{css_class}", :remote => true }
	end


	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy, :value => false) + link_to_function(name, "remove_fields(this)")
	end
	
	def link_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}", :validate => true, :id=>'dynamic_form') do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end

	def display_base_errors resource
		return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
		messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
		html = <<-HTML
		<div class="alert alert-error alert-block">
			<button type="button" class="close" data-dismiss="alert">&#215;</button>
			#{messages}
		</div>
		HTML
		html.html_safe
	end

end
