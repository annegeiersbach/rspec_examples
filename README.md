# RSpec Examples

A small RSpec playground for learning by example.

## Run tests:

Tests can be run with either `docker-compose run app rspec` or you can drop in
to a shell with `docker-compose run app /bin/bash` to run tests repeatedly.

A couple of useful bash scripts  have been added to the entrypoint:

1. run `untilfail rspec` will keep running tests until they fail for running flaky scenarios
2. run `n_times 3 rspec` will run the rspec tests three times in a row

## Options for .rspec

The base example, runs randomly ordered specs in the documentation format.

```
--require spec_helper
--format documentation
--order rand
```

To use the CustomFormat formatter:

```
--require spec_helper
--require custom_format
--format CustomFormat
--order rand
```

To use the defined order 'slowest_last' (see `spec_helper.rb:48`):

```
--require spec_helper
--format documentation
--order slowest_last
```
