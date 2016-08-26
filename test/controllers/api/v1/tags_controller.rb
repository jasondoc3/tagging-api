require 'test_helper'

class Api::V1::TagsControllerTest < ActionDispatch::IntegrationTest

  # POST /api/v1/tag
  test 'Should create new tags for the entity' do
    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:scion_tc).id, tags: ['Used', 'Black'] }
    assert_response(:ok)
    assert_equal(cars(:scion_tc).tags.count, 2)
  end

  test 'Should overwrite tags for an entity that already has tags' do
    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:toyota_corolla).id, tags: ['Black'] }
    assert_response(:ok)
    assert_equal(cars(:toyota_corolla).tags.first.name, 'Black')

    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:toyota_corolla).id, tags: ['New'] }
    assert_response(:ok)
    assert_equal(cars(:toyota_corolla).tags.count, 1)
    assert_equal(cars(:toyota_corolla).tags.first.name, 'New')
  end

  # GET /api/v1/tags/:entity_type/:entity_id
  test 'Should return the entity and all of its tags' do
    get "/api/v1/tags/car/#{cars(:toyota_corolla).id}"
    assert_response(:ok)

    body = JSON.parse(response.body)
    assert_equal(body["id"], cars(:toyota_corolla).id)
    assert_equal(body["tags"], cars(:toyota_corolla).as_json(include: { tags: { only: [:name] } })["tags"])
  end

  test 'Should work for multiple entities' do
    get "/api/v1/tags/bike/#{bikes(:specialized).id}"
    assert_response(:ok)

    body = JSON.parse(response.body)
    assert_equal(body["id"], bikes(:specialized).id)
    assert_equal(body["tags"], bikes(:specialized).as_json(include: { tags: { only: [:name] } })["tags"])
  end

  # DELETE /api/v1/tags/:entity_type/:entity_id
  test 'Should destroy the entity and all of its tags' do
    car_count = Car.count
    tag_count = Tag.count
    toyota_corolla_tag_count = cars(:toyota_corolla).tags.count

    delete "/api/v1/tags/car/#{cars(:toyota_corolla).id}"
    assert_response(:ok)
    new_car_count = Car.count
    new_tag_count = Tag.count
    assert_equal(car_count, new_car_count + 1)
    assert_equal(tag_count, new_tag_count + toyota_corolla_tag_count)
  end

  # GET /api/v1/tags/stats
  test 'Should return stats grouped by entity type and tag name' do
    get '/api/v1/tags/stats'
    assert_response(:ok)
    body = JSON.parse(response.body)
    assert_includes(body, { "tag" => "Used", "entity" => "Car", "count" => 2})
  end

  # GET /api/v1/tags/stats/:entity_type/:entity_id
  test 'Should return stats for a specific tagged entity' do
    get "/api/v1/tags/stats/car/#{cars(:toyota_corolla).id}"
    assert_response(:ok)
    body = JSON.parse(response.body)
    assert_includes(body, { "tag" => "Used", "count" => 1 })
  end
end
