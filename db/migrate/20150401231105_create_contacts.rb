class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.integer 'phone_number'
      t.integer 'user_id'
    end
  end
end
