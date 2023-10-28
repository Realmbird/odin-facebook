class Like < ApplicationRecord
    belongs_to :likable, polymorphic: true

    def find_user
        User.where(id: user_id)
    end
end
