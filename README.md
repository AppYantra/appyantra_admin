## AppYantra Admin

Rails 3 engine for managing an app's assets, users, pages, blog, SEO and Social Media Integration.

This project uses MIT-LICENSE.

## Requirements

Rails 3.1 or later.

## Getting started

I haven't released this as a GEM so you need to clone this repository and add this to your GEMFILE

```console
gem 'appyantra_admin', path: 'path/to/appyantra_admin'
```

Run the install generator

```console
rails generate appyantra_admin:install
```

Add this to your Rakefile

```ruby
# required to skip certain initializers
AppyantraAdmin.rake_running = true
```

Run the admin migrations

```console
rake db:migrate
```

Add the list of models that you want to manage through AppYantraAdmin as assets:

```ruby
# config/initializers/appyantra_admin.rb
AppyantraAdmin.setup do |config|
  # specify the model names that can be managed as assets from the Admin dashboard
  config.assets = [ 'Model1', 'Model2' ]
end
```

Create an Admin user:

```console
rake appyantra_admin:create_admin email='speedy.gonzalves@speedkills.com' first_name='Speedy' last_name='Gonzalves'
```

Create basic application settings by running:

```console
rake appyantra_admin:setup_admin
```

Don't forget to delete public/index.html

Now start your Rails server and hit the root url!

## Using a Rich Text Editor for text_area input type

AppYantra Admin currently supports CKEditor. If you want to use CKEditor for editing the content of pages then use the following rake task:

```console
rake appyantra_admin:use_rich_text_editor
```

This task adds a setting for Rich Text Editor and defaults it to CKEditor.

Next, you need to copy the ckeditor directory to "app/assets/javascripts"

Notes

* Download CKEditor from http://ckeditor.com
* For setup please refer to http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Installation#Minimum_Setup
* Also refer to the CKEditor Sample — Replace Textarea Elements by Class Name

