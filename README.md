# TemporaryFeatures

So, you have to develop a feature for your awesome rails website, that
has to be live next week (from monday 00:00 to sunday 23:59). But you
don't want to wait until that moment to do a deploy, of course!

This gems enables you to schedule the start and the end of the feature
in production, while letting you test it before it goes live.

## Installation

Add this line to your application's Gemfile:

    gem 'temporary_features'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install temporary_features

## Usage

In config/temporary\_features.yml

    dummy_feature:
      from: 2013-11-08 23:25:00 +01:00
      to: 2013-11-08 23:26:00 +01:00

In config/initializers/temporary\_features.rb

    TemporaryFeatures.configure do |config|
      config.settings = YAML.load_file Rails.root.join "config", "temporary_features.yml"
    end

In config/routes.rb

    temporary_feature :dummy_feature do
      resources ...
    end

In controllers

    temporary_feature :dummy_feature do
      redirect_to ...
    end

In views

    <% temporary_feature :dummy_feature do %>
      <%= render ... %>
    <% end %>

Sometimes you'll want to do something when the feature is enabled and
something else when it is disabled. No problem, just use a block with a
parameter:

    <% temporary_feature :dummy_feature do |enabled| %>
      <% if enabled %>
        <%= render ... %>
      <% else %>
        We're sorry, this dummy feature is not available right now.
      <% end %>
    <% end %>

When you want to manually test the feature in production before it goes
live, you only have to add a parameter `stfcf=<id-of-your-feature>` to the
request path (stfcf stands for "skip temporary feature check for"). It
will be remembered in session so you can navigate through all the pages
that take part of your feature.

Once you've finished, make a request with a parameter `stfcf=nothing` so
that you'll see the normal behaviour (you won't see the feature unless you
are between the start and end times)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
