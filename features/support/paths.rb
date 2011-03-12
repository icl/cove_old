module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      
    when /the nda\s?page/
      '/nda'
      
    when /the login\s?page/
      '/login'
      
    when /the invitations\s?page/
      url_for(:controller => "admin/users", :action => "new")

    when /the definition\s?page for "(.*)"/
      url_for(:controller => "definitions", :action => "show", :id => $1)
    
    when /the show\s?page for interval (\d*)/
      url_for(:controller => "intervals", :action => "show", :id => $1)

    when /the admin page/
      '/admin'

    when /the user administration page/
      '/admin/users'
      
    when /the page for project "(.*)"/
      url_for(:controller => "projects", :action => "show", :id => Project.find_by_name($1).id, :only_path => true )

    when /the page for collection "(.*)"/
      url_for(:controller => "collections", :action => "show", :id => Collection.find_by_name($1).id, :only_path => true )
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
