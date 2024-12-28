class FixCreatedByModifiedBy < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :createdBy, :integer
    add_column :machines, :modifiedBy, :integer

    add_foreign_key :machines, :users, column: :createdBy
    add_foreign_key :machines, :users, column: :modifiedBy

    # add foreign key to createdBy and modifiedBy in the builds table
    add_foreign_key :builds, :users, column: :createdBy
    add_foreign_key :builds, :users, column: :modifiedBy

    # change the column from type string to int
    remove_column :materials, :createdBy
    remove_column :materials, :modifiedBy
    add_column :materials, :createdBy, :integer
    add_column :materials, :modifiedBy, :integer

    add_foreign_key :materials, :users, column: :createdBy
    add_foreign_key :materials, :users, column: :modifiedBy

    # add foreign key to createdBy and modifiedBy in the cads table
    add_foreign_key :cads, :users, column: :createdBy
    add_foreign_key :cads, :users, column: :modifiedBy

    # Add the same to attachemnts table
    add_column :attachments, :createdBy, :integer
    add_column :attachments, :modifiedBy, :integer
    add_foreign_key :attachments, :users, column: :createdBy
    add_foreign_key :attachments, :users, column: :modifiedBy
  end
end
