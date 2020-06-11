class Public::WorksController < ApplicationController
  def index
    @q = Work.where(recruitment_status: 0).ransack(params[:q])
    @works = @q.result(distinct: true).page(params[:page]).per(20).order(created_at: :desc)
  end

  def my_works
    @works = current_user.works
  end

  def my_work_entries
    @work = Work.find(params[:id])
  end

  def show
    @work = Work.find(params[:id])
    @entry = Entry.find_by(work_id: @work.id, user_id: current_user.id)
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def create
    @work = current_user.works.new(work_params)
    if @work.save
      redirect_to work_path(@work)
    else
      render :new
    end
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_path
  end

  private
    def work_params
      params.require(:work).permit(:title, :description, :condition,:started_at, :ended_at, :reward, :recruitment_status, :image)                          
    end
end
