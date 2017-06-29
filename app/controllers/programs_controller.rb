class ProgramsController < ApplicationController
  before_action :superuser, only: [:edit, :update, :destroy]

  # POST /programs
  # POST /programs.json
  def create
    require 'pry'
    binding.pry
    @program = Program.new(program_params).tap(&:save)
    redirect_to @program
  rescue => _e
    render 'new'
  end

  # # POST /users
  # # POST /users.json
  # def create
  #   # require 'pry'
  #   # binding.pry
  #   @user = User.new(user_params)
  #
  #   respond_to do |format|
  #     if @user.save
  #       format.html do
  #         log_in(@user)
  #         redirect_to @user
  #       end
  #       format.json {render :show, status: :created, location: @user}
  #     else
  #       format.html {render :new}
  #       format.json {render json: @user.errors, status: :unprocessable_entity}
  #     end
  #   end
  # end

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
    @programs = Program.paginated(params[:page])
  end

  def index_tags
    tagged_program_ids = ProgramTag.where(tag: params[:tag_id]).pluck(:program_id)
    @programs = Program.where(id: tagged_program_ids).paginated(params[:page])
    render 'index'
  end

  def superuser
    redirect_to programs_path unless superuser?
  end

  private

  def program_params
    params.require(:program).permit(:number, :name, :date, :description)
  end
end
