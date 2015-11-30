

###changes the input file in aeasy to use form for search.rb 

filen=["warandpeace.txt","good Indian.txt","OldIndianDays.txt"]
for name in filen
good=File.new(name+".crw",'w')
File.open(name,'r')do |afile|
      afile.each_line do |line|
        if line=="\n"
          good.print(line)
        else
          line=line.gsub(/\n/,' ')
          good.print(line)
        end
      end
    end
    good.close 
  end
  
   

            
            
              