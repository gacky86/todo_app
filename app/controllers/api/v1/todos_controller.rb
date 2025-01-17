module Api
  module V1
    class TodosController < ApplicationController
      def index
        render json: Todo.order(updated_at: :desc)
      end

      def show
        render json: Todo.find(params[:id])
      end

      def create
        todo = Todo.new(todo_params)
        if todo.save
          render json: todo
        else
          render json: { errors: todo.errors }, status: :unprocessable_entity
        end
      end

      def update
        todo = Todo.find(params[:id])
        if todo.update(todo_params)
          render json: todo
        else
          render json: { errors: todo.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        todo = Todo.find(params[:id])
        todo.destroy
        render json: { message: 'Todo deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Todo not found' }, status: :not_found
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def destroy_all
        Todo.destroy_all
        head :no_content
      end

      private

      def todo_params
        params.require(:todo).permit(:name, :is_completed)
      end
    end
  end
end
