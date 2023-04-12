class AddRecommendationToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :recommendation, :text
  end
end
