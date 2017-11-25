require 'dingy'
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
  before do
    require 'fileutils'
    FileUtils.rm_f 'next-alarm.txt'
  end
  it do
    env['NOW'] = '9:00'

    out = run_command 'bin/dingy --start'

    expect(out).to eq('')
    expect(File.exists?('next-alarm.txt')).
      to be_truthy
    expect(Time.parse(File.read('next-alarm.txt'))).
      to eq(Time.parse('9:25'))
  end
  it do
    env['NOW'] = '9:00'
    File.write('next-alarm.txt', '9:25')

    out = run_command 'bin/dingy'

    expect(out).to eq('25:00')
  end
  def run_command command
    out, _ = Open3.capture2e env, command
    out.chomp
  end
  let(:env) { {} }
  require 'open3'
end
