require 'redmine'

#to_prepare removed from Rails 5.1
#ActionDispatch::Callbacks.to_prepare do
ActiveSupport::Reloader.to_prepare do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineAutoPercent::IssuePatch
    Issue.send(:include, RedmineAutoPercent::IssuePatch)
  end
end

Redmine::Plugin.register :redmine_issue_completion do
  name 'Redmine issue completion'
  author 'tbird1965'
  description 'Automatically sets 100% done and current date as due_date on Resolved or Closed'
  version '0.0.3'
  url 'https://github.com/tbird1965/redmine_issue_completion'
  author_url 'https://github.com/tbird1965'
end
