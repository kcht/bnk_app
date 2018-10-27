class StaticPageController < ApplicationController
  def home
    @programs = Program.recent
  end

  def help
  end

  def about
  end

  def contact
  end
end
