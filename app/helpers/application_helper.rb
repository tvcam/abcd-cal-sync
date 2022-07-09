module ApplicationHelper
  def render_flash_message
    if flash.present?
      content_tag(:div, class: 'highlight') do
        flash.each do |type, message|
          concat content_tag(:pre, message)
        end
      end
    end
  end
end
