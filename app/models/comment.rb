class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  def format_created_at()
    self.created_at.strftime('%d-%m-%Y %H:%M:%S') 
  end
end
