require 'test_helper'

class Api::V1::TagsControllerTest < ActionDispatch::IntegrationTest

  # POST /api/v1/tag
  # tests
  test 'Should create new tags for the entity' do
    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:scion_tc).id, tags: ['Used', 'Black'], format: 'json' }
    assert_response(:ok)
    assert_equal(cars(:scion_tc).tags.count, 2)
  end

  test 'Should overwrite tags for an entity that already has tags' do
    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:toyota_corolla).id, tags: ['Black'] }
    assert_response(:ok)
    assert_equal(cars(:toyota_corolla).tags.first.tag_name, 'Black')

    post api_v1_tag_path, params: { entity_type: 'Car', entity_id: cars(:toyota_corolla).id, tags: ['New'] }
    assert_response(:ok)
    assert_equal(cars(:toyota_corolla).tags.count, 1)
    assert_equal(cars(:toyota_corolla).tags.first.tag_name, 'New')
  end

end
