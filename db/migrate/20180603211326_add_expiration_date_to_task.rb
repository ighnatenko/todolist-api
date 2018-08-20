# frozen_string_literal: true

class AddExpirationDateToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expiration_date, :date
  end
end
