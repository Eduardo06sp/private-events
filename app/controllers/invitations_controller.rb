class InvitationsController < ApplicationController
  def create
    current_event = Event.find(params[:event_id])
    @invitation = current_user.invitations.build(attended_event_id: current_event.id)

    if current_user.save
      flash[:notice] = 'SUCCESS'
      redirect_back fallback_location: '/events'
    else
      flash[:notice] = 'FAILURE'
      redirect_back fallback_location: '/events'
    end
  end
end
