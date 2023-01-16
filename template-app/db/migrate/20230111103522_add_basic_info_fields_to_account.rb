class AddBasicInfoFieldsToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_reference :accounts, :city, index: true
  	add_reference :accounts, :age_group, index: true
  	add_reference :accounts, :gender, index: true
  end
end
