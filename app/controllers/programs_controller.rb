class ProgramsController < ApplicationController
  RESULTS_PER_PAGE = 5

  def create
    @program = Program.new(program_params).tap(&:save)
    redirect_to @program
  rescue => _e
    render 'new'
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

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    redirect_to programs_path
  end

  def show
    @program = Program.find(params[:id])
    @playlist_items = ProgramsHelper.playlist_info(program_number: @program.number)
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
