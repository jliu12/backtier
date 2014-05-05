class InvitationsController < ApplicationController

	def create
		parameters = invitation_params
		@invitation = Invitation.new(parameters)
		if @invitation.valid?
			@invitation.save
			render json: {status: 200, note: "OK"}, status: 200
		else
			render json: {status: 403, note: "Event Invitation Failed"}, status: 403
		end
	end

	def update
		parameters = invitation_params
		invitation = Invitation.find_by_id(parameters[:invitation_id])
		if parameters[:status] == "NO"
			invitation.destroy
			render json: {status: 200, note: "OK, deleted"}, status: 200
		else
			user = User.find_by_id(invitation.user_id)
			event = Event.find_by_id(invitation.event_id)
			user.events <<  event
			event.users << user

			user.save
			event.save
			invitation.destroy
			render json: {status: 200, note: "OK, added"}, status: 200
		end
	end

	def invitation_params
		params.require(:invitation).permit(:invitation_id, :event_id, :user_id, :status)
	end

end    	