class User < ApplicationRecord
    has_many :posts 
    # foreign_key: "updated_user_id,deleted_user_id"
    has_secure_password
    # validates :name, presence: true, uniqueness: true
    validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates :password_digest, presence:true, confirmation: true
    # validates_confirmation_of :password
    # validate :verify_old_password
    # validates :profile_photo, presence:true
    # validates :user_type, presence:true
    # validates :created_user_id, presence:true
    # validates :updated_user_id, presence:true
  def self.search(search)
      p 'SEARCH'
      if search
        User.where("name LIKE :name", {:name => "%#{search}%"})
        # find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
  end

    
  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end
 end
