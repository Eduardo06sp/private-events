class EventsController < ApplicationController
  after_action :create_timewithzones, only: :create

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :location,
      :start_date,
      :start_time,
      :end_date,
      :end_time
    )
  end

  def create_timewithzones
    Time.zone = current_user.time_zone
    start_time_string = "#{@event.start_date} #{@event.start_time}"
    start_time_converted = Time.zone.parse(start_time_string)

    end_time_string = "#{@event.end_date} #{@event.end_time}"
    end_time_converted = Time.zone.parse(end_time_string)

    @event.start_timewithzone = start_time_converted
    @event.end_timewithzone = end_time_converted

    @event.save
  end
end
