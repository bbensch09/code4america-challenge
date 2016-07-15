class ViolationsController < ApplicationController
  before_action :set_violation, only: [:show, :edit, :update, :destroy]

  def import
   Violation.import(params[:file])
   @violations = Violation.all
   @categories = Violation.unique_categories
   render 'analyze', notice: "New data imported."
  end

  def reset_data
    puts "access controller action - reset data"
    Violation.delete_all
    redirect_to root_path
  end

  # GET /violations
  # GET /violations.json
  def index
    @violations = Violation.all.sort { |a,b| a.violation_date <=> b.violation_date }
  end

  # GET /violations/1
  # GET /violations/1.json

  def analyze
      @categories = Violation.unique_categories
  end

  def show
  end

  # GET /violations/new
  def new
    @violation = Violation.new
  end

  # GET /violations/1/edit
  def edit
  end

  # POST /violations
  # POST /violations.json
  def create
    @violation = Violation.new(violation_params)

    respond_to do |format|
      if @violation.save
        format.html { redirect_to @violation, notice: 'Violation was successfully created.' }
        format.json { render :show, status: :created, location: @violation }
      else
        format.html { render :new }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /violations/1
  # PATCH/PUT /violations/1.json
  def update
    respond_to do |format|
      if @violation.update(violation_params)
        format.html { redirect_to @violation, notice: 'Violation was successfully updated.' }
        format.json { render :show, status: :ok, location: @violation }
      else
        format.html { render :edit }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /violations/1
  # DELETE /violations/1.json
  def destroy
    @violation.destroy
    respond_to do |format|
      format.html { redirect_to violations_url, notice: 'Violation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_violation
      @violation = Violation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def violation_params
      params.require(:violation).permit(:violation_id, :inspection_id, :violation_category, :violation_date, :violation_date_closed, :violation_type)
    end
end
