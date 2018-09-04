# frozen_string_literal: true

# User
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  validates :email, :encrypted_password, presence: true
  has_many :projects, dependent: :destroy
end
