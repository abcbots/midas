class MidasGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :obj_before_to, :type => :string, :desc => "optional"

  argument :direction, :type => :string, :desc => "optional"

  argument :obj_after_from, :type => :string, :desc => "optional"
  argument :obj_after_to, :type => :string, :desc => "optional"

  obj_before_to = obj_before_to.to_s.downcase.singularize
  direction = direction.to_s.downcase.singularize
  obj_after_from = obj_after_from.to_s.downcase.singularize
  obj_after_to = obj_after_to.to_s.downcase.singularize

  def print_test
    print "\n"
    print "\n"
    print "Obj before to: #{obj_before_to}\n"
    print "\n"
    print "Direction: #{direction}\n"
    print "\n"
    print "Obj after from: #{obj_after_from}\n"
    print "Obj after to: #{obj_after_to}\n"
    print "\n"
    print "\n"
  end

  def push_obj
    if direction=="push"
      #generate_object obj_after_to
      push_templates
    end
  end

  def pull_obj
    if direction=="pull"
      pull_templates
    end
  end

private

  #def generate_object(pass_obj)
    #run "rails g nifty:scaffold #{pass_obj} #{pass_obj}name:string -f --rspec"
    #run "rake db:migrate"
    #run "rake db:test:clone"
  #end
 
  def git(commit_message="")
    commit_message = commit_message + ": " + Time.now.to_s + "."
    run "git add ."
    run "git commit -m '#{commit_message}'"
    print "\n  #{commit_message}\n\n"
  end

  def pull_templates
    templateize_file "app/helpers/#{obj_before_to.pluralize}_helper.rb", "objto/app/helpers/objtos_helper.rb"
    templateize_file "app/views/#{obj_before_to.pluralize}/_form.html.erb", "objto/app/views/objtos/_form.html.erb"
    templateize_file "app/views/#{obj_before_to.pluralize}/_index.html.erb", "objto/app/views/objtos/_index.html.erb"
    templateize_file "app/views/#{obj_before_to.pluralize}/_#{obj_before_to}.html.erb", "objto/app/views/objtos/_objto.html.erb"
    templateize_file "features/app/#{obj_before_to.pluralize}/create.feature", "objto/features/app/objtos/create.feature"
    templateize_file "features/app/#{obj_before_to.pluralize}/destroy.feature", "objto/features/app/objtos/destroy.feature"
    templateize_file "features/app/#{obj_before_to.pluralize}/read.feature", "objto/features/app/objtos/read.feature"
    templateize_file "features/app/#{obj_before_to.pluralize}/update.feature", "objto/features/app/objtos/update.feature"
    templateize_file "features/step_definitions/#{obj_before_to}_steps.rb", "objto/features/step_definitions/objto_steps.rb"
    if obj_after_to == "gold"
      templateize_file "app/models/#{obj_before_to}.rb", "objto/app/models/objto.rb"
      templateize_file "app/controllers/#{obj_before_to.pluralize}_controller.rb", "objto/app/controllers/objtos_controller.rb"
      templateize_file "app/views/#{obj_before_to.pluralize}/edit.html.erb", "objto/app/views/objtos/edit.html.erb"
      templateize_file "app/views/#{obj_before_to.pluralize}/index.html.erb", "objto/app/views/objtos/index.html.erb"
      templateize_file "app/views/#{obj_before_to.pluralize}/new.html.erb", "objto/app/views/objtos/new.html.erb"
      templateize_file "app/views/#{obj_before_to.pluralize}/show.html.erb", "objto/app/views/objtos/show.html.erb"
    end
  end

  def push_templates
    template "gold/objto/app/helpers/objtos_helper.rb", "app/helpers/#{obj_after_to.pluralize}_helper.rb", :force => true
    template "gold/objto/app/views/objtos/_form.html.erb", "app/views/#{obj_after_to.pluralize}/_form.html.erb", :force => true
    template "gold/objto/app/views/objtos/_index.html.erb", "app/views/#{obj_after_to.pluralize}/_index.html.erb", :force => true
    template "gold/objto/app/views/objtos/_objto.html.erb", "app/views/#{obj_after_to.pluralize}/_#{obj_after_to}.html.erb", :force => true
    template "gold/objto/features/app/objtos/create.feature", "features/app/#{obj_after_to.pluralize}/create.feature", :force => true
    template "gold/objto/features/app/objtos/destroy.feature", "features/app/#{obj_after_to.pluralize}/destroy.feature", :force => true
    template "gold/objto/features/app/objtos/read.feature", "features/app/#{obj_after_to.pluralize}/read.feature", :force => true
    template "gold/objto/features/app/objtos/update.feature", "features/app/#{obj_after_to.pluralize}/update.feature", :force => true
    template "gold/objto/features/step_definitions/objto_steps.rb", "features/step_definitions/#{obj_after_to}_steps.rb", :force => true
    template "#{obj_before_to}/objto/app/controllers/objtos_controller.rb", "app/controllers/#{obj_after_to.pluralize}_controller.rb", :force => true
    template "#{obj_before_to}/objto/app/models/objto.rb", "app/models/#{obj_after_to}.rb", :force => true
    template "#{obj_before_to}/objto/app/views/objtos/edit.html.erb", "app/views/#{obj_after_to.pluralize}/edit.html.erb", :force => true
    template "#{obj_before_to}/objto/app/views/objtos/index.html.erb", "app/views/#{obj_after_to.pluralize}/index.html.erb", :force => true
    template "#{obj_before_to}/objto/app/views/objtos/new.html.erb", "app/views/#{obj_after_to.pluralize}/new.html.erb", :force => true
    template "#{obj_before_to}/objto/app/views/objtos/show.html.erb", "app/views/#{obj_after_to.pluralize}/show.html.erb", :force => true
  end

  def templateize_file(pass_out, pass_in)
    pass_in = "lib/generators/midas/templates/#{obj_after_to}/#{pass_in}".to_s
    copy_file "../../../../#{pass_out}", pass_in, :force => true
    gsub_file pass_in, "<%", "<%%", :force => true
    gsub_file pass_in, obj_before_to.pluralize, "<%= obj_after_to.pluralize %>", :force => true
    gsub_file pass_in, obj_before_to, "<%= obj_after_to %>", :force => true
    gsub_file pass_in, obj_before_to.camelize.pluralize, "<%= obj_after_to.camelize.pluralize %>", :force => true
    gsub_file pass_in, obj_before_to.camelize, "<%= obj_after_to.camelize %>", :force => true
  end

end
