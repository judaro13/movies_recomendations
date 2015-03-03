class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :edit, :update, :destroy, :vote]

  # GET /users
  # GET /users.json
  def index
    if q = params[:q]
      q = "%#{q}%"
      @users = User.where("name like ? or nick like ? or id = ?",q,q,q).paginate(:page => params[:page], :per_page => 28)
    end
    @users ||= User.all.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if q = params[:q]
      q = "%#{q}%"
      @movies = Movie.where("name like ? or genders like ?",q,q).paginate(:page => params[:page], :per_page => 28)
    elsif @user.ratings.count > 0
      similarity = params['similarity'] || "PearsonCorrelationSimilarity"
      recommender = params['recommender'] || "GenericUserBasedRecommender"
      size = params['size'] || 10
      path = Rails.root.to_s+'/db/loaded-raitings.csv'
      values = {:similarity => similarity, :recommender => recommender, :neighborhood_size => size.to_i}
      @recommender = JrubyMahout::Recommender.new(values) 
      @recommender.data_model = JrubyMahout::DataModel.new('file', { :file_path => path  }).data_model
    else
      recommender = params['recommender'] || "ItemAverageRecommender"
      path = Rails.root.to_s+'/db/loaded-raitings.csv'
      @recommender = JrubyMahout::Recommender.new({:recommender => recommender}) 
      @recommender.data_model = JrubyMahout::DataModel.new('file', { :file_path => path }).data_model
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def vote
    if rank = @user.ratings.where(movie_id: params[:movie_id]).first
      rank.value = params[:value].to_i
      rank.predict = false
      rank.save
    else
      if @user.ratings.create(value: params[:value].to_i, movie_id: params[:movie_id].to_i, predict: false)
        path = Rails.root.to_s+'/db/loaded-raitings.csv'
        open(path, 'a') do |f|
          f << "#{@user.id},#{params[:movie_id]},#{params[:value]}\n"
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: 'Well done!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :image_url, :nick)
    end
end
