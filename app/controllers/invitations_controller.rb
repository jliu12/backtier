class InvitationsController < ApplicationController

	def index
		@invitation = Invitation.new
	end

	def create
		parameters = invitation_params
		@invitation = Invitation.new(parameters)
		if @invitation.valid?
			user = User.find_by_id(parameters[:user_invited])
			if not user.invitations.include? @invitation
				user.invitations << @invitation
				user.save
			end
			@invitation.save
			render json: {status: 200, note: "OK"}, status: 200
		else
			render json: {status: 403, note: "Event Invitation Failed"}, status: 403
		end
	end

	def update
		parameters = invitation_params
		invitation = Invitation.find_by_id(parameters[:id])
		if parameters[:status] == "NO"
			invitation.destroy
			render json: {status: 200, note: "OK, deleted"}, status: 200
		else
			user = User.find_by_id(invitation.user_invited)
			event = Event.find_by_id(invitation.event_id)
			if not (user.events).include? event
				event.users << user
				event.save
				Invitation.destroy_all(:user_invited => user.id, :event_id => event.id)
			else
				invitation.destroy
			end
			render json: {status: 200, note: "OK, added"}, status: 200
		end
	end

	def invitation_params
		params.require(:invitation).permit(:invitation_id, :event_id, :user_sent, :user_invited, :status, :id)
	end

end    	