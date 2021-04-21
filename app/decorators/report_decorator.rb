class ReportDecorator < ApplicationDecorator
  delegate_all

  def self.table_columns
    %i[id type member created_at processed_at form status records_count download_link]
  end

  def type
    h.content_tag :span, self.object.name, title: self.object.type
  end

  def processed_at
    return h.middot if object.processed_at.nil?
    h.content_tag :span, class: 'text-nowrap' do
      I18n.l object.processed_at
    end
  end

  def form
    return h.middot if object.form_object.nil?
    h.render 'reports/present_form', form: object.form_object
  end

  def results
    h.link_to h.report_path(object) do
      I18n.t '.results'
    end
  end

  def download_link
    h.download_link h.report_path(object, format: :xlsx)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
