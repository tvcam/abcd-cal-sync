module ApplicationHelper
  def render_flash_message
    return if flash.blank?

    content_tag(:div, class: 'highlight') do
      flash.each do |_type, message|
        concat content_tag(:pre, message)
      end
    end
  end
end
