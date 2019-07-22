class User < ApplicationRecord
    has_many :ideas
    has_many :reviews
    has_secure_password

    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea
    
    validates(
        :username, 
        presence: true,
        uniqueness: true,
        length: { minimum: 2 }
    )

    validates(
        :email, 
        presence: true, 
        uniqueness: true,
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    ) 

    validates(:password_digest, presence: true)
end