# app/models/employee.rb
class Employee
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id,       :integer
  attribute :name,     :string
  attribute :position, :string
  attribute :email,    :string
  attribute :contact,  :string

  validates :name, :position, :email, :contact, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def as_json(_opts = {})
    {
      id: id,
      name: name,
      position: position,
      email: email,
      contact: contact
    }
  end

end
