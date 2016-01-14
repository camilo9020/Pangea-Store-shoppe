module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)
    sentence = 'El usuario no se pudo crear debido a los siguientes errores: '
    puts resource.errors.full_messages


    html = <<-HTML
    <div id="error_explanation">      
      <h2>#{sentence}</h2>
      <br/>
      <ul>#{messages}</ul>
      <br/>
    </div>
    HTML

    html.html_safe
  end
end