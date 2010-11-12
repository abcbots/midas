class GeneratorTemplateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument(:pass_first_object, :type => :string, :default => "", :desc => "optional")
  argument(:pass_second_object, :type => :string, :default => "", :desc => "optional")

private

  def git(commit_message="")
    commit_message = commit_message + ":" + Time.now.to_s + "."
    run "git add ."
    run "git commit -m '#{commit_message}'"
    print "\n\n #{commit_message} \n\n\n"
  end

  def object_first
    pass_first_object.underscore.singularize.downcase
  end

  def object_second
    pass_second_object.underscore.singularize.downcase
  end

  def time_stamp
    unless @time_stamp
      @time_stamp = "r_"+Time.now.to_s.underscore.gsub(" ","_").gsub(":","_").gsub("__","_")
    end
    return @time_stamp
  end

end
