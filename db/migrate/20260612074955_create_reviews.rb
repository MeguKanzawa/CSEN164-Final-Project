class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    unless table_exists?(:reviews)
      create_table :reviews do |t|
        t.integer :rating
        t.text :comment
        t.belongs_to :user, null: false, foreign_key: true
        t.belongs_to :product, null: false, foreign_key: true

        t.timestamps
      end
    end
  end
end
