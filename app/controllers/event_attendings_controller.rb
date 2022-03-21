class EventAttendingsController < ApplicationController
  def create
    current_event = Event.find(params[:event_id])
    @event_attending = current_user.event_attendings.build(attended_event_id: current_event.id)

    if @event_attending.save
      flash[:notice] = 'SUCCESS'
      redirect_back fallback_location: '/events'
    else
      flash[:notice] = 'FAILURE'
      redirect_back fallback_location: '/events'
    end
  end

  def destroy
    current_event = Event.find(params[:event_id])
    @event_attending = current_user.event_attendings.find_by(
      'attended_event_id = ?',
      current_event.id
    )

    @event_attending.destroy
    redirect_back fallback_location: "/events/#{current_event.id}"
  end
end
