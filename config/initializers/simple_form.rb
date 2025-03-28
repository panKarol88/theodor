# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers :default, class: 'form__group' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: 'visually-hidden'
    b.use :input, class: 'form__input', error_class: 'form__input--invalid'
  end

  config.generate_additional_classes_for = []
  config.default_wrapper = :default
  config.button_class = 'btn'
  config.label_text = ->(label, _, _) { label }
  config.error_notification_tag = :div
  config.error_notification_class = 'error_notification'
  config.browser_validations = false
  config.boolean_style = :nested
  config.boolean_label_class = 'form__checkbox-label'
end
