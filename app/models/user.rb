# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true
    validates :password,length: {minimum: 6, allow_nil: true}


    after_initialize :ensure_session_token

    def self.generate_sesssion_token
        self.session_token = SecureRandom.urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

    def password
        @password
    end
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end   

    def self.find_by_credentials(email,password)
        user = User.find_by(email: email)
        if user.nil? 
            return nil
        end

        user.is_password?(password) ? user:nil
    end
end 

