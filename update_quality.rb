require 'award'
require 'pry'


def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue Distinction Plus' # max at 80 and never alters
      next
    when 'Blue First'   # increases the older they get, max at 50; 2x decrease after expiration
      if award.quality < 50
       award.quality += 1
       if award.expires_in <= 0 && award.quality < 50
         award.quality += 1
       end
      end
    when 'Blue Compare' # 2x increase when < 10 days; 3x increase when < 5 days; 0x after expiration
      if award.expires_in < 11 && award.expires_in > 5
       if award.quality < 49
         award.quality += 2
       else
         award.quality = 50
       end
     elsif award.expires_in < 6
       if award.quality < 48
         award.quality += 3
       else
         award.quality = 50
       end
     else
       award.quality += 1
      end
     if award.expires_in <= 0
       award.quality = 0
     end
    when 'Blue Star' #2x decrease the older they get; 2x decrease after expiration
      if award.quality >= 2
        award.quality -= 2
        if award.expires_in <= 0
          award.quality -= 2 if award.quality >= 2
        end
      end
    else # 'Normal Award' decreases the older they get; 2x decrease after expiration
      award.quality -= 1 if award.quality > 0
      if award.expires_in <= 0
        award.quality -= 1 if award.quality > 0
      end
    end
    award.expires_in -= 1
  end
end
