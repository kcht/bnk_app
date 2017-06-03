require 'pry'
class ProgramsController < ApplicationController

  def create
    @program = Program.new(program_params)
    @program.save!
    redirect_to @program
  end

  def show
    @program = Program.find(params[:id])
  end

  def index
    @programs = Program.paginate(:page => params[:page], :per_page => 1)
  end

  private

  def program_params
    params.require(:program).permit(:number, :name, :date, :description)
  end
end
