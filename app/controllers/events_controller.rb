class EventsController < ApplicationController
  before_action :redirect_guest, except: [:show, :index]
  before_action :authorize_access, only: [:show, :edit, :update]
  before_action :authorize_modification, only: [:edit, :update, :destroy]
  after_action :create_timewithzones, :update_invited_users, only: [:create, :update]

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
    @submission_successful = true
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
    else
      @submission_successful = false
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @submission_successful = true
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      @submission_successful = false
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
    return unless @event.private

    old_invites = @event.invited_users
    updated_invites = if params[:updated_invited_users]
                        params[:updated_invited_users].values
                      else
                        []
                      end

    new_invites = updated_invites - old_invites
    removed_invites = old_invites - updated_invites

    new_invites.each do |user_id|
      invited_user = User.find(user_id)
      invitation = invited_user.invitations.build(invited_event_id: @event.id)

      invitation.save || flash[:notice] = 'INVITATION UNSUCCESSFUL'
    end

    removed_invites.each do |user_id|
      invited_user = User.find(user_id)
      invited_event = invited_user.invitations.find_by(
        'invited_event_id = ?',
        @event.id
      )

      invited_event.destroy || flash[:notice] = 'COULD NOT DELETE INVITATION'
    end

    @event.invited_users_will_change!
    @event.invited_users = updated_invites
  end

  def redirect_guest
    redirect_to root_path unless user_signed_in?
  end

  def authorize_access
    @event = Event.find(params[:id])

    return unless user_signed_in? && @event.private
    return if @event.creator_id == current_user.id
    return if @event.private && @event.invited_users.include?(current_user.id.to_s)

    redirect_to root_path
  end

  def authorize_modification
    creator_id = Event.find(params[:id]).creator_id
    redirect_to root_path unless user_signed_in? &&
                                 creator_id == current_user.id
  end
end
