require "fileutils"
include FileUtils::Verbose

def rmv(re, target)

  files = Dir["**/*"].map do |path|
    if path =~ re
      [path, path.sub(re, target)]
    else 
      nil
    end
  end.compact

  uniq_files = files.map{|f| f.last}.uniq

  if uniq_files.length != files.length
    (files.map{|f| f.last} - uniq_files).uniq
    abort "targets are not unique: #{(files - uniq_files).uniq.inspect}" 
  end

  files.each do |from, to|
    mv from, to
  end

end