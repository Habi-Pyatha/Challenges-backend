module Api
  module V1
    class ChallengesController < ApplicationController
      before_action :set_challenge, only: [ :show, :update, :destroy ]
      before_action :authorize_admin, only: %i[create update destroy]
      before_action :authenticate_user!, only: [ :create, :update, :destroy ]
      def index
        @challenges=Challenge.all
        render json: @challenges
      end

      def create
        # challenge=Challenge.new(challenge_params.merge(user_id: current_user.id))
        challenge=current_user.challenges.build(challenge_params)


        if challenge.save
          render json: { message: "Challenge added sucessfully", data: challenge }, status: :created

        else
          render json: { message: "Failed to add challenge.", errors: challenge.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        if @challenge
          render json: { message: "Challenge found", data: @challenge }, status: :ok
        else
          render json: { message: "Challenge not found" }, status: :not_found
        end
      end

      def update
        if @challenge.update(challenge_params)
          render json: { message: "Challenge updated", data: @challenge }, status: :ok
        else
          render json: { message: "Challenge update failed" }, status: :unprocessable_entity
        end
      end

      def destroy
        if @challenge.destroy
          render json: { message: "Challenge deleted sucessfully" }, status: :ok
        else
          render json: { message: "Challenge destroy failed." }, status: :not_found
        end
      end

      private
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end

      def set_challenge
        @challenge=Challenge.find_by(id: params[:id])
        render json: { message: "Challenge not found" }, status: :not_found unless @challenge
      end

      def authorize_admin
        unless current_user.email== ENV["ADMIN_EMAIL"]
         render json: { message: "Forbidden action" }
        end
      end
    end
  end
end
