# frozen_string_literal: true

Rails.logger.debug 'Seeding the database...'

owner_user = User.find_or_initialize_by(email: ENV.fetch('OWNER_EMAIL_ADDRESS', nil))
owner_user.update!(password: ENV.fetch('OWNER_PASSWORD', nil)) if owner_user.new_record?
owner_warehouse = Warehouse.find_or_create_by!(name: ENV.fetch('OWNER_WAREHOUSE', nil))

owner_warehouse.prompt_decorators.find_or_create_by(name: 'theodor_role') do |prompt_decorator|
  prompt_decorator.decorator_type = 'role'
  prompt_decorator.value = 'Your name is Theodor. You are very kind, polite and helpful software system. ' \
                           'You are always ready to help and assist the user. ' \
                           'Think of you as a butler in the mansion. ' \
                           'You are always ready to help and assist the Karol Kamiński, the owner of this system. ' \
                           'You talk like TARS from the Interstellar movie.'
end

owner_warehouse.prompt_decorators.find_or_create_by(name: 'pre_store_info_about_the_owner') do |prompt_decorator|
  prompt_decorator.decorator_type = 'pre_request'
  prompt_decorator.value = 'All the following information is about the Karol Kamiński. The owner of this system. ' \
                           'Whenever it says "I" or "me" it refers to Karol Kamiński.'
end

owner_warehouse.prompt_decorators.find_or_create_by(name: 'compress_input') do |prompt_decorator|
  prompt_decorator.decorator_type = 'edit_instructions'
  prompt_decorator.value = 'Read the following text carefully. Try to understand the meaning of the following text. ' \
                           'And then summarize it all as short as possible ' \
                           'to not miss any fact from the following text. ' \
                           'Use as few words as possible but always keep all information stored in the following text.' \
                           '\n ### FOLLOWING TEXT ### \n {{text}} \n ### END OF FOLLOWING TEXT ###'
end

owner_warehouse.prompt_decorators.find_or_create_by(name: 'post_store_info_about_the_owner') do |prompt_decorator|
  prompt_decorator.decorator_type = 'post_request'
  prompt_decorator.value = 'Return only raw information. Do not add any additional comments or thoughts nor cheers or welcomes of any kind.'
end

work_warehouse = Warehouse.find_or_create_by!(name: ENV.fetch('WORK_WAREHOUSE', nil))
x = work_warehouse.prompt_decorators.find_or_create_by(name: 'compress_work_input') do |prompt_decorator|
  prompt_decorator.decorator_type = 'edit_instructions'
  prompt_decorator.value = 'Read the following text carefully. Try to understand the meaning of the following text. ' \
                           'And then summarize it all.' \
                           'Do not miss any fact from the following text. ' \
                           'Use possibly less words but always keep all information stored in the following text.' \
                           'The following text might be formatted like table or different data container. ' \
                           'Try to guess the formatting and take an advantage of that.' \
                           '\n ### FOLLOWING TEXT ### \n {{text}} \n ### END OF FOLLOWING TEXT ### \n Do not use word "summarize" in your answer. ' \
                           'Do not explain what you\'re about to do ' \
                           'Do not use any additional words. Just the facts.'
end

x.value = 'Read the following text carefully. Try to understand the meaning of the following text. And then summarize it all.' \
          'Do not miss any fact from the following text. Use possibly less words but always keep all information stored in the following text.' \
          'The following text might be formatted like table or different data container. Try to guess the formatting and take an advantage of that.' \
          '\n ### FOLLOWING TEXT ### \n {{text}} \n ### END OF FOLLOWING TEXT ### \n Do not use word "summarize" in your answer. ' \
          'Do not explain what you\'re about to do ' \
          'Do not use any additional words. Just the facts.'
x.save!

owner_user.warehouses << Warehouse.all

Rails.logger.debug 'Seeding the database...done'
