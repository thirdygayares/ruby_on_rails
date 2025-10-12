Rails.application.routes.draw do
  get "/hello", to: proc {
    [200, { "Content-Type" => "application/json" }, ['{"message":"Hello World"}']]
  }

  # Employees CRUD (JSON by default)
  resources :employees, defaults: { format: :json }
end
