class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, :last_name, :state, :city, :address, :phone, presence: true
  validates_format_of :first_name, :last_name, :state, :city, :with => /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s-]*\z/u, :on => :create, :on => :update
  validates_format_of :address, :with => /\A[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ#\-\.\s-]*\z/u, :on => :create, :on => :update
  validates_format_of :phone, :with => /\A[0-9\-\.\s-]*\z/u, :on => :create, :on => :update

end
