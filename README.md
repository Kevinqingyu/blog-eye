Blog Eye: A platform for sharing blogs
=======

[![Code Climate](http://img.shields.io/codeclimate/github/agilejzl/blog-eye.svg)][codeclimate]
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/agilejzl/blog-eye/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[codeclimate]: https://codeclimate.com/github/agilejzl/blog-eye

Blog Eye, you know, a platform for sharing blog. Site url: [http://www.blog-eye.com/](http://www.blog-eye.com/)

## How to Install

Make sure mysql already started.
```bash
git clone git@github.com:agilejzl/blog-eye.git
cd blog-eye
ruby setup.rb # A ruby script to make project RTF

# Then change config at database.yml and settings.yml
RAILS_ENV=development rails s
# start sidekiq for async sending email and uploading photo
bundle exec sidekiq -e development
```

## Gemfile Source

By default bundler installs gems using the ruby.taobao.org source, if you'd rather use the official one, set environment variable `USE_OFFICIAL_GEM_SOURCE`:

```
USE_OFFICIAL_GEM_SOURCE=1
```

## How to Test

We use rspec & capybara to test.
```bash
# create db, load schema, and initialize with seed
RAILS_ENV=test rake db:setup

RAILS_ENV=test rails s
bundle exec rspec -fd # Run all test in spec folder

# Or test specified directories
bundle exec rspec -fd ./spec/features # Make sure already installed firefox
```

## Contributors

* [Contributors](https://github.com/agilejzl/blog-eye/contributors)

## Thanks

* [Twitter Bootstrap](http://getbootstrap.com/)

## License

Copyright (c) 2014 Blog Eye

Released under the MIT license:

* [www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)

