module ApplicationHelper
  def render_flash_message
    return if flash.blank?

    content_tag(:div, class: 'highlight') do
      flash.each do |_type, message|
        concat content_tag(:pre, message)
      end
    end
  end

  def format_event_start_date(event)
    datetime = event.start_at.strftime("%m/%d/%Y")
    datetime = "#{datetime} #{event.start_at.strftime('at %I:%M%p')}" if event.event_start['dateTime'].present?
    datetime
  end
end
