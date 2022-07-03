class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user

    validates :title, presence: true, length: {minimum: 3}
    validates :body, presence: true, length: {minimum: 3}

    def format_created_at()
        self.created_at.strftime('%d-%m-%Y %H:%M:%S') 
    end

    def format_updated_at()
        self.updated_at.strftime('%d-%m-%Y %H:%M:%S') 
    end
end
