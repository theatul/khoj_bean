#!C:/ruby/bin/ruby.exe

require 'cgi'
class Search
  def initialize(filen,phrase)
    @filen=filen          # file name
    @phras=phrase     #query string
    @pr=0                 #paragraph no in result array
    @rept=0               # used to count repetation of phrase in each paragraph
    @results=[]           #stores results of search
    @count={}           #stores result no and priority ofresult
    @temp=""
  end
  
  ###searching file
  def searchfile
    File.open(@filen+".crw",'r')do |@afile|
      @afile.each_line do |@line|
          if @line=~Regexp.new('\b'+@phras+'\b','i')
            @rept+=1
            while $&!=nil
              @results[@pr]=@results[@pr].to_s+$`+"<font size=5 color=red>"+$&+"</font>"      ##manipulatin results for displaying
              @temp=$'
              @rept+=1 if $'=~(Regexp.new('\b'+@phras+'\b','i'))
            end
            @results[@pr]=@results[@pr].to_s+@temp
            @count[@pr]=@rept 
            @rept=0
            @pr+=1
          else
            @results[@pr]=""
          end
      end
    end
    @count
  end
  
  def filearray
    @results
  end
 
end

##Html page header
puts "Content-Type: text/html"
puts
puts "<html>"
puts "<body>"
puts "<FORM action=search.rb method=get>"
puts "<font color=rgb(85,253,123) size=7>Khoj</font><font color=blue size=65>-</font><font color=rgb(255,2,12) size=65>Been</font>"
puts "<br><br><INPUT  size=60 name=search value=><br><br><INPUT type=submit value=Search><BR></FORM>"
puts"<hr size=7 color=blue>"
puts "<h1>"


phr=""
cg=CGI.new 
phr=cg['search'] #reading cgi parameter


if !phr.empty?
  phr=phr.sub(/\.$|,$|;$/,"")
  
  
  
  bookshelf=["good Indian.txt","warandpeace.txt","OldIndianDays.txt"]#contain the name of books

  bookobj=[]          #used to store the objects of search class specific for books
  count=[]             #used to store the results returned by search method
  book=""
  values=[]           #used to calculate priority
  k,key,val,ln=0,0,0,0
  i=0

#calling search class for each book
  for book in bookshelf
    bookobj[i]=Search.new(book,phr)
    count[i]=bookobj[i].searchfile
    i+=1
  end


#Calculating priority
  for info in count
    info.each_value{|val| values[k]=val;k+=1}
  end
  values=values.sort
  length=values.length-1

######displaying results

puts length+1
puts "Results for: "
puts phr
puts "</h1>"


  while length>=0
    val=values[length]
    for ln in 0...count.length
      key=count[ln].index(val)
      if key!=nil
        puts "<p><h3><font color=blue><a href=open.rb?book="+bookshelf[ln].gsub(/\s/,'%20')+"&&phrase="+phr.gsub(/\s/,'%20')+">book name: "+bookshelf[ln]+"</font></a></h3></p>"
        puts "<p>"
        print bookobj[ln].filearray[key]
        count[ln].delete(key)
        break
      end   
    end
    length-=1
  end
  print "<p><h3><font color=blue><a href=search.rb?search="+phr.gsub(/\s/,".*")+">Click heare for other Related Results for:  "+phr+"</a></font></h3></p>" if phr!=phr.gsub(/\s/,".*")
end
puts "</body>"
puts "</html>"



