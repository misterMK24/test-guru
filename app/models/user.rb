class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :confirmable,
         :trackable
  
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :gists
  has_many :user_badges, dependent: :nullify
  has_many :badges, through: :user_badges
  
  validates :username, presence: true, 
                       uniqueness: true
  validates :email, presence: true, uniqueness: true,
                    length: { maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  def tests_by_level(level)
    self.tests.where(level: level.to_i)
  end

  def test_passage(test)
    self.test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
