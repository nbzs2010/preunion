class User < ActiveRecord::Base

  has_many :created_missions, class_name: "Mission", foreign_key: "creator_id"
  has_many :assigned_missions, class_name: "Mission", foreign_key: "assigned_to_id"

  class << self
    def find_or_create_from_auth_hash auth_hash
      @user = self.where(uid: auth_hash.uid, provider: :github).
        first_or_create(email: auth_hash.info.email,
                        github_homepage: auth_hash.info.urls.GitHub,
                        nickname: auth_hash.info.nickname)
    end
  end
end