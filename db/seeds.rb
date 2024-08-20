# frozen_string_literal: true

Rails.logger.debug 'Seeding the database...'

owner_user = User.find_or_initialize_by(email: ENV.fetch('OWNER_EMAIL_ADDRESS', nil))
owner_user.update!(password: ENV.fetch('OWNER_PASSWORD', nil)) if owner_user.new_record?

resource_feature = Feature.find_or_create_by!(name: 'resource_feature') do |feature|
  feature.description = 'Resource Feature'
end

resource_feature.prompt_decorators.find_or_create_by(name: 'resource_input') do |prompt_decorator|
  prompt_decorator.priority = 0
  prompt_decorator.value = 'Based on resources provided, pick one resource that is most suitable for a given input. ' \
                           '\n #### GIVEN INPUT #### \n {{text}} \n ### END OF THE GIVEN INPUT ###\n.'
end

resource_feature.prompt_decorators.find_or_create_by(name: 'resource_collection') do |prompt_decorator|
  prompt_decorator.priority = 1
  prompt_decorator.value = '### RESOURCES ### \n {{resources}} \n ### END OF RESOURCES ###'
end

resource_feature.prompt_decorators.find_or_create_by(name: 'resource_format') do |prompt_decorator|
  prompt_decorator.priority = 2
  prompt_decorator.value = 'Respond in JSON format. '
end

# ---------------------------------------
# -------------- OWNER ------------------
# ---------------------------------------

owner_warehouse = Warehouse.find_or_create_by!(name: ENV.fetch('OWNER_WAREHOUSE', nil)) do |warehouse|
  warehouse.description = 'Warehouse contains information about the owner of this application: Karol Kamiński. ' \
                          'It keeps information like personal data, preferences, and other information about the owner.' \
                          'Events from personal life, calendar info, relationships and general knowledge.'
end

owner_storing_feature = owner_warehouse.features.find_or_create_by!(name: 'owner_storing_feature') do |feature|
  feature.description = 'This feature is responsible for storing information. ' \
                        'Whenever there is some useful information being considered this is the feature to use.'
  feature.store_results = true
end

owner_storing_feature.prompt_decorators.find_or_create_by(name: 'pre_store_info_about_the_owner') do |prompt_decorator|
  prompt_decorator.priority = 0
  prompt_decorator.value = 'All the following information is about the Karol Kamiński. The owner of this system. ' \
                           'Whenever it says "I" or "me" it refers to Karol Kamiński.'
end

owner_storing_feature.prompt_decorators.find_or_create_by(name: 'compress_input') do |prompt_decorator|
  prompt_decorator.priority = 1
  prompt_decorator.value = 'Read the following text carefully. Try to understand the meaning of the following text. ' \
                           'And then summarize it all as short as possible ' \
                           'to not miss any fact from the following text. ' \
                           'Use as few words as possible but always keep all information stored in the following text.' \
                           '\n ### FOLLOWING TEXT ### \n {{text}} \n ### END OF FOLLOWING TEXT ###'
end

owner_storing_feature.prompt_decorators.find_or_create_by(name: 'post_store_info_about_the_owner') do |prompt_decorator|
  prompt_decorator.priority = 2
  prompt_decorator.value = 'Return only raw information. Do not add any additional comments or thoughts nor cheers or welcomes of any kind.'
end

owner_question_feature = owner_warehouse.features.find_or_create_by!(name: 'owner_question_feature') do |feature|
  feature.description = 'This feature is responsible for answering questions. ' \
                        'Whenever we are considering any type of question this is the feature to use.'
end

owner_question_feature.prompt_decorators.find_or_create_by(name: 'theodor_role') do |prompt_decorator|
  prompt_decorator.priority = 0
  prompt_decorator.value = 'Your name is Theodor. You are very kind, polite and helpful software system. ' \
                           'You are always ready to help and assist the user. ' \
                           'Think of you as a butler in the mansion. ' \
                           'You are always ready to help and assist the Karol Kamiński, the owner of this system. ' \
                           'You talk like TARS from the Interstellar movie.'
end

owner_question_feature.prompt_decorators.find_or_create_by(name: 'karol_question_guide') do |prompt_decorator|
  prompt_decorator.priority = 1
  prompt_decorator.value = 'Take a deep breath and calmly think about the question. ' \
                           'Take your time and read the context carefully. Line after line. ' \
                           'Please consider the given context and answer the following question as shortly as possible. ' \
                           'If you are less than a 75% sure about the answer tell that you are not sure with one short sentence.'
end

owner_question_feature.prompt_decorators.find_or_create_by(name: 'karol_question_context') do |prompt_decorator|
  prompt_decorator.priority = 2
  prompt_decorator.value = '### CONTEXT ## \n {{context}} \n ### END OF CONTEXT ###'
end

owner_question_feature.prompt_decorators.find_or_create_by(name: 'karol_question_text') do |prompt_decorator|
  prompt_decorator.priority = 3
  prompt_decorator.value = '### QUESTION ## \n {{text}} \n ######################'
end

owner_question_feature.prompt_decorators.find_or_create_by(name: 'funny_prompt') do |prompt_decorator|
  prompt_decorator.priority = 4
  prompt_decorator.value = 'Try to answer with some sense of humor.'
end

# ---------------------------------------
# ---------------- WORK -----------------
# ---------------------------------------

work_warehouse = Warehouse.find_or_create_by!(name: ENV.fetch('WORK_WAREHOUSE', nil)) do |warehouse|
  warehouse.description = 'Warehouse contains information about the work of Karol Kamiński. ' \
                          'Work is always related with IT.' \
                          'It keeps information like work-related data, projects, tasks, and other information about the work.' \
                          'Events from work life, calendar meetings with clients and coworkers and the domain knowledge about the project.'
end

work_storing_feature = work_warehouse.features.find_or_create_by!(name: 'work_storing_feature') do |feature|
  feature.description = 'This feature is responsible for storing information. ' \
                        'Whenever there is some useful information being considered this is the feature to use.'
  feature.store_results = true
end
work_storing_feature.prompt_decorators.find_or_create_by(name: 'compress_work_input') do |prompt_decorator|
  prompt_decorator.priority = 0
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

work_question_feature = work_warehouse.features.find_or_create_by!(name: 'work_question_feature') do |feature|
  feature.description = 'This feature is responsible for answering questions. ' \
                        'Whenever we are considering any type of question this is the feature to use.'
end

work_question_feature.prompt_decorators.find_or_create_by(name: 'theodor_work_role') do |prompt_decorator|
  prompt_decorator.priority = 0
  prompt_decorator.value = 'Your name is Theodor. You are very kind, polite and helpful software system. ' \
                           'You are always ready to help and assist the user. ' \
                           'Think of you as a butler in the mansion. ' \
                           'You are always ready to help and assist the Karol Kamiński, the owner of this system. ' \
                           'You talk like TARS from the Interstellar movie.'
end

work_question_feature.prompt_decorators.find_or_create_by(name: 'work_question_guide') do |prompt_decorator|
  prompt_decorator.priority = 1
  prompt_decorator.value = 'Take a deep breath and calmly think about the question. ' \
                           'Take your time and read the context carefully. Line after line. ' \
                           'Please consider the given context and answer the following question as shortly as possible. ' \
                           'If you are less than a 75% sure about the answer tell that you are not sure with one short sentence.'
end

work_question_feature.prompt_decorators.find_or_create_by(name: 'work_question_context') do |prompt_decorator|
  prompt_decorator.priority = 2
  prompt_decorator.value = '### CONTEXT ## \n {{context}} \n ### END OF CONTEXT ###'
end

work_question_feature.prompt_decorators.find_or_create_by(name: 'work_question_text') do |prompt_decorator|
  prompt_decorator.priority = 3
  prompt_decorator.value = '### QUESTION ## \n {{text}} \n ######################'
end

work_question_feature.prompt_decorators.find_or_create_by(name: 'funny_prompt') do |prompt_decorator|
  prompt_decorator.priority = 4
  prompt_decorator.value = 'Try to answer with some sense of humor.'
end

owner_user.warehouses << Warehouse.all

Rails.logger.debug 'Seeding the database...done'

# AiFeatures::Knowledge.new(input: "lubię śliwki", user: User.last)
