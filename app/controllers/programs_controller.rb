require 'pry'
class ProgramsController < ApplicationController
  RESULTS_PER_PAGE = 5

  def create
    @program = Program.new(program_params)
    if @program.save
      redirect_to @program
    else
      render 'new'
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def index
    @programs = Program.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)
  end

  private

  def program_params
    params.require(:program).permit(:number, :name, :date, :description)
  end
end
