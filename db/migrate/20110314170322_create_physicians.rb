class CreatePhysicians < ActiveRecord::Migration
  def self.up
    create_table :physicians do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :physicians
  end
end
