# frozen_string_literal: true

# app/models/employee_store.rb
class EmployeeStore
  @mutex = Mutex.new
  @employees = []
  @next_id = 1

  class << self
    def all
      @employees
    end

    def find(id)
      @employees.find { |e| e.id == id.to_i }
    end

    def create(attrs)
      @mutex.synchronize do
        # uniqueness by email (case-insensitive)
        email = attrs[:email].to_s
        raise ArgumentError, "Email already taken" if @employees.any? { |e| e.email.casecmp?(email) }

        emp = Employee.new(attrs.merge(id: @next_id))
        raise ActiveModel::ValidationError, emp unless emp.valid?

        @employees << emp
        @next_id += 1
        emp
      end
    end

    def update(id, attrs)
      @mutex.synchronize do
        emp = find(id)
        return nil unless emp

        if attrs.key?(:email)
          email = attrs[:email].to_s
          taken = @employees.any? { |e| e.id != emp.id && e.email.casecmp?(email) }
          raise ArgumentError, "Email already taken" if taken
        end

        emp.assign_attributes(attrs)
        raise ActiveModel::ValidationError, emp unless emp.valid?
        emp
      end
    end

    def destroy(id)
      @mutex.synchronize do
        emp = find(id)
        return false unless emp
        @employees.delete(emp)
        true
      end
    end
  end
end
