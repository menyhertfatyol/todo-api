class TodosController < ApplicationController

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo
  end

  def create
    @todo = Todo.create!(todo_params)
    render json: @todo, status: :created
  end

  private

  def todo_params
    params.permit(:name, :description, :status, :due_at)
  end
end
