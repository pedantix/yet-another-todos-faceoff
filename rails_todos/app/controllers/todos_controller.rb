class TodosController < ApplicationController
  def index
    todos = Todo.order("\"createdAt\" DESC")
    todos = todos.limit(params[:count]) if params[:count].present?
    render json: todos
  end
end
