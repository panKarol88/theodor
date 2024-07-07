# frozen_string_literal: true

Rails.logger.debug 'Seeding the database...'

def create_user_with_default_warehouse(email)
  user = User.find_or_initialize_by(email:)
  user.update!(password: 'Password1!') if user.new_record?

  warehouse_name = "#{email.split('@').first}_warehouse"
  warehouse = Warehouse.find_or_create_by!(name: warehouse_name)
  user.warehouses << warehouse unless user.warehouses.include?(warehouse)
end

seed_user_accounts = %w[karol@karol.pl test@test.pl]
seed_user_accounts.each do |email|
  create_user_with_default_warehouse(email)
end

Rails.logger.debug 'Seeding the database...done'
