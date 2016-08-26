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
      t.tag_name = tag
      t.save!
    end

    head :ok
  end
end
