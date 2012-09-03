Maid.rules do
  rule 'MP3s likely to be music' do
    dir('~/Downloads/*.mp3').each do |path|
      if duration_s(path) > 30.0
        move(path, '~/Music/iTunes/iTunes Media/Automatically Add to iTunes/')
      end
    end
  end

  rule 'Linux ISOs, etc' do
    dir('~/Downloads/*.iso').each { |p| trash p }
  end

  rule 'Mac OS X applications in disk images' do
    dir('~/Downloads/*.{dmg,app}').each { |p| trash p }
  end

  rule '.pkg files' do
    dir('~/Downloads/*.pkg').each { |pkg| trash pkg }
  end

  rule 'Screenshots' do
    dir('~/Desktop/Screen Shot *').each { |scrot| trash scrot }
    dir('~/Downloads/Screen Shot *').each { |scrot| trash scrot }
  end

  rule 'Remove random pictures' do
    dir('~/Downloads/*.{png,gif,jpg,jpeg,psd}').each { |pic| trash pic }
  end

  rule 'Remaining archives' do
    dir('~/Downloads/*.{zip,tgz,rar}').each { |archive| trash archive }
  end

  rule 'Old transfers' do
    dir('~/transfers/*').each do |path|
      trash path if 1.week.since?(last_accessed(path))
    end
  end

  rule 'Unused things' do
    dir('~/Downloads/*').each do |path|
      trash path if 1.week.since?(last_accessed(path))
    end
  end
end
