class Api::V1::CompaniesController < ApplicationController
	before_action :authenticate_user!, only: [:show]

	def index
		if params[:name]
			@companies = Company.where('name LIKE ?','%#{params[:name]}')
		else 
			@companies = Company.all
		end
	end 

	def show
		@company = Company.find(params[:id])
	end
end
