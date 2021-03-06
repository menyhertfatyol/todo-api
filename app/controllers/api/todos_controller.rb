class Api::TodosController < ApplicationController

  def index
    if params[:status]
      @todos = Todo.where(status: params[:status])
    else
      @todos = Todo.all
    end
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

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy!
  end

  private

  def todo_params
    params.permit(:name, :description, :status, :due_at)
  end
end
