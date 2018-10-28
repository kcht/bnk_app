class ProgramsController < ApplicationController
  before_action :superuser, only: [:edit, :update, :destroy, :index_all]

  # POST /programs
  # POST /programs.json
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
    @programs = Program.after_premiere.paginated(params[:page])
  end

  def index_all
    @programs = Program.paginated(params[:page])
    render 'index'
  end

  def recent
    @programs = Program.recent
  end

  def index_tags
    tagged_program_ids = ProgramTag.where(tag: params[:tag]).pluck(:program_id)
    @programs = Program.where(id: tagged_program_ids).paginated(params[:page])
    render 'index'
  end

  private

  def superuser
    redirect_to programs_path unless superuser?
  end

  def program_params
    params.require(:program_info).permit(:number, :name, :date, :description)
  end
end
