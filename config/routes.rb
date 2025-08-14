Rails.application.routes.draw do
  get "/hello", to: proc {
    [200, { "Content-Type" => "application/json" }, ['{"message":"Hello World"}']]
  }
end
