# app/controllers/employees_controller.rb
class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    render json: EmployeeStore.all
  end

  def show
    return render_not_found unless @employee
    render json: @employee
  end

  def create
    emp = EmployeeStore.create(employee_params)
    render json: emp, status: :created
  rescue ActiveModel::ValidationError => e
    render json: { errors: e.model.errors.full_messages }, status: :unprocessable_entity
  rescue ArgumentError => e
    render json: { errors: [e.message] }, status: :unprocessable_entity
  end

  def update
    return render_not_found unless @employee
    emp = EmployeeStore.update(params[:id], employee_params)
    render json: emp
  rescue ActiveModel::ValidationError => e
    render json: { errors: e.model.errors.full_messages }, status: :unprocessable_entity
  rescue ArgumentError => e
    render json: { errors: [e.message] }, status: :unprocessable_entity
  end

  def destroy
    return render_not_found unless EmployeeStore.destroy(params[:id])
    head :no_content
  end

  private

  def set_employee
    @employee = EmployeeStore.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :position, :email, :contact)
  end

  def render_not_found
    render json: { error: "Employee not found" }, status: :not_found
  end
end
