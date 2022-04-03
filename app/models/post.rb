class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, presence: true, uniqueness: {message: "already subscribed"}
  belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
  # , class_name: 'User', foreign_key: 'updated_user_id,deleted_user_id'
  # validates :user, presence: true
  def self.search(search)
    p 'SEARCH'
    if search
      Post.where("title LIKE :title", {:title => "%#{search}%"})
     # find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  require 'open-uri'
  require 'csv'
  def self.import_CSV(file, id)
    p "IMPORT CSV USERID #{id}"
    # post_file =[file]
    # post_file.each do |post|
    CSV.foreach(file.path, :headers => true) do |row|
      post = Post.new
      post.title = row[0]
      post.description = row[1]
      post.status = 1
      post.user_id = id
      post.created_user_id = id
      post.updated_user_id = id
      post.save
    end
    # end
  end
end
