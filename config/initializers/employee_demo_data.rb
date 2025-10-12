# config/initializers/employee_demo_data.rb
begin
  EmployeeStore.create(name: "Ada Lovelace", position: "Engineer", email: "ada@example.com", contact: "+1-202-555-0101")
  EmployeeStore.create(name: "Grace Hopper", position: "Rear Admiral", email: "grace@example.com", contact: "+1-202-555-0199")
rescue => _e
  # ignore if reloaded
end
# frozen_string_literal: true

