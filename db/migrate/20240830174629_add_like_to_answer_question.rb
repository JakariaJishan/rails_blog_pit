class AddLikeToAnswerQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :question_id, :bigint
    add_column :likes, :answer_id, :bigint
  end
end
