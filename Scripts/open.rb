#!C:/ruby/bin/ruby.exe


####used to open the books
require 'cgi'
cg=CGI.new 
books=cg['book']
phr=cg['phrase']
phr=phr.sub(/\.$|,$|;$/,"")

###html header
puts "Content-Type: text/html"
puts
puts "<html>"
puts "<body>"
line=""
puts "<center><font color=blue><h1>"+books+"</h1></font></center>"

###opening book
File.open(books,'r')do |afile|
  afile.each_line do |line|
    if line=="\n"
      puts "<br>"
    else
      if line=~(Regexp.new('\b'+phr+'\b','i'))
        while $'!=nil
          print $`
          print "<font size=5 color=red>"+$&+"</font>"
          temp=$'
          $'=~(Regexp.new('\b'+phr+'\b','i'))
        end
        puts temp
      else  
        puts line
      end
    end
  end
end
puts "</body>"
puts "</html>"