class EventsController < ApplicationController
  after_action :create_timewithzones, only: [:create, :update]

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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other
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
      :end_time,
      :private
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

  def update_invited_users
    old_invites = @event.invited_users
    updated_invites = if params[:updated_invited_users]
                        params[:updated_invited_users].values
                      else
                        []
                      end

    new_invites = updated_invites - old_invites

    new_invites.each do |user_id|
      invited_user = User.find(user_id)
      invited_user.invitations.build(invited_event_id: @event.id)

      invited_user.save || flash[:notice] = 'INVITATION UNSUCCESSFUL'
    end

    @event.invited_users_will_change!
    @event.invited_users = updated_invites
  end
end
