class AddConfirmableToDevise < ActiveRecord::Migration
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :students, :confirmation_token, :string
    add_column :students, :unconfirmed_email, :string
    add_column :students, :confirmed_at, :datetime
    add_column :students, :confirmation_sent_at, :datetime
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :students, :confirmation_token, unique: true
    add_index :students, :unconfirmed_email, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Student.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
    add_column :admins, :confirmation_token, :string
        add_column :admins, :unconfirmed_email, :string
        add_column :admins, :confirmed_at, :datetime
        add_column :admins, :confirmation_sent_at, :datetime
        # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
        add_index :admins, :confirmation_token, unique: true
        add_index :admins, :unconfirmed_email, unique: true
        # User.reset_column_information # Need for some types of updates, but not for update_all.
        # To avoid a short time window between running the migration and updating all existing
        # users as confirmed, do the following
        Admin.update_all confirmed_at: DateTime.now
  end

  def down
    remove_columns :students, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :admins, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :users, :unconfirmed_email # Only if using reconfirmable
  end
end
