class ActivityLogObserver < ActiveRecord::Observer

  observe :page, :user, :admin

  def after_create(record)
    log_activity record, 'created', :created_by
  end

  def after_update(record)
    log_activity record, 'updated', :last_updated_by
  end

  def after_destroy(record)
    log_activity record, 'deleted', :deleted_by
  end

  private

  def infer_actor(record, actor_method)
    if record.respond_to?(actor_method)
      # actor e.g. page.created_by --> admin
      actor_obj = record.send(actor_method)
      if actor_obj
        # check if the actor has a display_name
        if actor_obj.respond_to?(:display_name)
          display_name = actor_obj.send(:display_name)
        else
          display_name = actor_obj.class.name
        end
        # create a hash for the actor
        actor = { type: actor_obj.class.name, id: actor_obj.id, display_name: display_name }
      else
        actor = {}
      end
    else
      actor = {}
    end
  end

  def log_activity(record, action, actor_method)
    actor = infer_actor(record, actor_method)
    ActivityFeed.create(item_type: record.class.name, item_id: record.id,
                       item: record_identifier(record), actor: actor[:display_name],
                       actor_type: actor[:type], actor_id: actor[:id], activity: action)
  end

  def record_identifier(record)
    if record.respond_to?(:identifier)
      record.send(:identifier)
    elsif record.respond_to?(:display_name)
      record.send(:display_name)
    else
      record.class.name << '#' << record.id
    end
  end

end

