# Generic Tagging JSON API

### Supported entities
This generic JSON tagging API currently supports tagging bikes and cars with arbitrary tags.


The bike and car entities are stored in separate tables.
Support for more entities can be added by adding another data model.

### Decisions and Reasonings

- Scoped the routes under `/api/v1`. This is how I normally prefer to scope my APIs.
- Used MySQL as a database. I am most familiar with MySQL.
- Changed the stats routes to be scoped under `/tags` (`/stats` is now `/api/v1/tags/stats` etc.) This made more sense to me since the stats are directly related to the tags.
-  Stored all tags in a `tags` table. I used a polymorphic rails association here because I wanted the tag to able to to belong to an arbitrary number of other models on a single association.
This allows the tags table to store tags of different entity types via the entity_type field. I found that this made querying for tag stats easier as well.

### Running Tests

The test database name is `tagging_test`

Run the test suite with
```
bin/rails test/*
```

Alternatively, you could load the fixtures into the development env and test the API.

```
RAILS_ENV=development rake db:fixtures:load

```
