class Api::V1::TagsController < ApplicationController

  # POST /api/v1/tag
  def create 
    entity_id     = params[:entity_id]
    entity_type   = params[:entity_type].downcase.capitalize
    tags          = params[:tags]

    # All tags need to be replaced, so remove them first
    Tag.where(entity_type: entity_type, entity_id: entity_id).delete_all

    # Loop through each tag and create a new tag for the entity  
    tags.each do |tag|
      t = Tag.new
      t.entity_id = entity_id
      t.entity_type = entity_type
      t.name = tag
      t.save!
    end

    head :ok
  end

  # GET /api/v1/tags/:entity_type/:entity_id
  def show
    entity_id     = params[:entity_id]
    entity_type   = params[:entity_type].downcase.capitalize
    entity = entity_type.constantize.find(entity_id)

    render json: entity.as_json(include: { tags: { only: [:name] } })
  end

  # DELETE /api/v1/tags/:entity_type/:entity_id
  def destroy
    entity_id     = params[:entity_id]
    entity_type   = params[:entity_type].downcase.capitalize
    entity = entity_type.constantize.find(entity_id)

    # Delete the entity and its associated tags
    entity.destroy
    Tag.where(entity_type: entity_type, entity_id: entity_id).delete_all

    head :ok
  end

  # GET /api/v1/tags/stats
  def stats
    stats_by_entity = Tag.group(:name, :entity_type).count
    return_stats = []

    # Loop through each stat, formatting it for better output
    stats_by_entity.each do |name_and_entity_type, count|
      return_stats << { tag: name_and_entity_type[0], entity: name_and_entity_type[1], count: count }
    end

    render json: return_stats
  end

  # GET /api/v1/tags/stats/:entity_type/:entity_id
  def entity_stats
    entity_id     = params[:entity_id]
    entity_type   = params[:entity_type].downcase.capitalize
    entity = entity_type.constantize.find(entity_id)

    stats_for_entity = entity.tags.group(:name).count
    return_stats = []

    stats_for_entity.each do |name, count|
      return_stats << { tag: name, count: count }
    end

    render json: return_stats
  end
end
