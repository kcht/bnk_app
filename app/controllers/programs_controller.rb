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

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])

    if @program.update(program_params)
      redirect_to @program
    else
      render 'edit'
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def index
    @programs = Program.
        order('number desc').
        paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)
  end

  private

  def program_params
    params.require(:program).permit(:number, :name, :date, :description)
  end
end
