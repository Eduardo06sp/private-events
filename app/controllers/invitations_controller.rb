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

  def destroy
    current_event = Event.find(params[:event_id])
    @invitation = current_user.invitations.find_by(
      'attended_event_id = ?',
      current_event.id
    )

    @invitation.destroy
    redirect_back fallback_location: "/events/#{current_event.id}"
  end
end
