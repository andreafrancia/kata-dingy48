def format_time time
  return 'Rang!' if time < 0
  '%02d:%02d' % [time/60, time%60]
end
def remainig_time ring_time, now
  Time.parse(ring_time) - Time.parse(now)
end
def formatted_remaining_time ring_time, now
  format_time remainig_time ring_time, now
end

describe do
  it do
    now = '9:00'
    ring_time = '9:25'

    expect(formatted_remaining_time ring_time, now).
      to eq('25:00')
  end
end

describe 'how to calculate remaining time' do
  it do
    expect(remainig_time '9:25', '9:00').to eq(25*60)
    expect(remainig_time '9:00', '9:00').to eq(0*60)
    expect(remainig_time '9:01', '9:00').to eq(1*60)
  end
  require 'time'
end
describe 'how to format the remaining time'  do
  it do
    expect(format_time 0).to eq('00:00')
    expect(format_time 1).to eq('00:01')
    expect(format_time 11).to eq('00:11')
    expect(format_time 60+11).to eq('01:11')
    expect(format_time -1).to eq('Rang!')
  end
end
#
# NOW      9:00  -ok->
#                     bin/dingy  -ok-> stdout 25:00
# ring_time 9:25 -->
describe 'walking skeleton' do
  it do
    env = {}
    env['NOW'] = 'pluto'
    File.write('next-alarm.txt', 'paperino')

    out, _ = Open3.capture2e env, 'bin/dingy'

    expect(out.chomp).to eq('paperino')
  end
  require 'open3'
end
